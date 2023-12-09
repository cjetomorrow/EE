clear
clc
Tmax = 50;                                  %最大迭代次数
limit = 1.0e-6;                             %要求精度
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
J = Jacobi(n, m, Ue, Uf, G, B);
disp('恒定雅可比矩阵：');
disp(J);
InvJ = inv(J);

[Pi, Qi, U2i] = PQUCalculation(n, m, Ue, Uf, G, B);                     %y(x0),维数稍有差异
Pi0 = Pi - P;
Qi0 = Qi - Q;
U2i0 = U2i - Us ^ 2;
UbalancePQU0 = [Pi0(1:n-1), Qi0(1:m), U2i0];                            %y(x0) - ys
dUek = zeros(1, n);
dUfk = zeros(1, n);
dUek1 = zeros(1, n);
dUfk1 = zeros(1, n);

for i = 1 : Tmax
    [dPi, dQi, dU2i] = PQUCalculation(n, m, dUek, dUfk, G, B);
    y = UbalancePQU0 + [dPi(1:n-1), dQi(1:m), dU2i];
    dU = -InvJ * y';
    dUfk1(1 : n-1) = dU(1 : n-1);
    dUek1(1 : n-1) = dU(n : end);
    if (max(dUek1 - dUek) < limit) && (max(dUfk1 - dUfk) < limit)
        break;
    end
    dUek = dUek1;
    dUfk = dUfk1;
end
if ((max(dUek1 - dUek) < limit) && (max(dUfk1 - dUfk) < limit))
	disp('计算收敛');
else
	disp('计算不收敛或未达到要求精度');
end

Ue = Ue + dUek1;
Uf = Uf + dUfk1;
[Pi, Qi, U2i] = PQUCalculation(n, m, Ue, Uf, G, B);   
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