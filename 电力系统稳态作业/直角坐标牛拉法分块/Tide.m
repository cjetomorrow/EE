clear
clc

Tmax = 50;                                  %最大迭代次数
limit = 1.0e-3;                             %要求精度
n = 3;                                      %总节点数
m = 1;                                      %PQ节点数

[P, Q, Ue, Uf, Us] = InitPQ();
disp('初始条件：')
disp('各节点有功：')
disp(P);
disp('各节点无功：')
disp(Q);
disp('各节点电压实部：')
disp(Ue);
disp('各节点电压虚部：')
disp(Uf);


Y = InitY();
G = real(Y);                                  %电导矩阵
B = imag(Y);                                  %电纳矩阵
disp('节点导纳矩阵');
disp(Y);

for i = 1 : Tmax
    [dP, dQ, dU2, Pi, Qi] = Unbalanced(n, m, Ue, Uf, Us, G, B, P, Q);
    disp('有功不平衡量： ');
    disp(dP);
    disp('无功不平衡量： ');
    disp(dQ);
    if(max(abs(dP)) < limit && max(abs(dQ)) < limit)
        break;
    end
    
    fprintf("第%d次迭代\n", i);
    J = Jacobi(n, m, Ue, Uf, G, B);
    disp('雅可比矩阵：');
    disp(J);

    [dUe, dUf] = Correct(n, dP, dQ, dU2, J);
    Ue = Ue + dUe;
    Uf = Uf + dUf;
end

if (max(abs(dP))<limit && max(abs(dQ))<limit)
	disp('计算收敛');
else
	disp('计算不收敛或未达到要求精度');
end

%打印功率
fprintf('迭代总次数：%d\n', i);
disp('节点电压实部：');
disp(Ue);
disp('节点电压虚部：');
disp(Uf);
disp('有功计算结果：');
disp(Pi);
disp('无功计算结果：');
disp(Qi);


for i = 1 : n
    for j = 1 : n
        [Pij(i, j), Qij(i, j)] = Sijtide(i, j, Ue, Uf, G, B);
    end
end

for i = 1 : n
    for j = 1 : n
        if Y(i, j) ~= 0 && i ~= j
            fprintf("S%d%d : %14d + %14dj\n", i, j, Pij(i, j), Qij(i, j));
        end
    end
end