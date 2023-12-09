clear
clc

Tmax = 50;                                      %最大迭代次数
limit = 1.0e-6;                                 %要求精度
n = 3;                                          %总节点数
m = 1;                                          %PQ节点数

[P, Q, U, Theta] = InitPQ();
disp('初始条件：')
disp('各节点有功：')
disp(P);
disp('各节点无功：')
disp(Q);
disp('各节点电压幅值：')
disp(U);
Theta=(deg2rad(Theta));                         %角度转换成弧度
disp('各节点电压相角(度)：')
disp(rad2deg(Theta));                           %显示依然使用角度


Y = InitY();
G = real(Y);                                    %电导矩阵
B = imag(Y);                                    %电纳矩阵
B1 = B(1:n-1, 1:n-1);
%B1 = decomposition(B1);                         %B1矩阵分解
B2 = B(1:m, 1:m);
%B2 = decomposition(B2);                         %B2矩阵分解
Kp = 1;
Kq = 1;

disp('节点导纳矩阵');
disp(Y);

for i = 1 : Tmax
    [dP, Pi] = UnbalancedP(n, U, Theta, G, B, P);
    if (abs(dP) < limit)
        Kp = 0;
    else
        dTheta = CorrectTheta(n, U, dP, B1);
        Theta = Theta + dTheta;
        Kq = 1;
    end

    if (Kp == 0 && Kq == 0)
        break;
    end

    [dQ, Qi] = UnbalancedQ(n, m, U, Theta, G, B, Q);
    if (abs(dQ) < limit)
        Kq = 0;
    else
        dU = CorrectU(m, U, B2, dQ);
        U(1:m) = U(1:m) + dU;
        Kp = 1;
    end
end

if (max(abs(dP))<limit && max(abs(dQ))<limit )
	disp('计算收敛');
else
	disp('计算不收敛或未达到要求精度');
end

%打印功率
fprintf('迭代总次数：%d\n', i);
disp('节点电压幅值：');
disp(U);
disp('节点电压相角：');
disp(rad2deg(Theta));
disp('有功计算结果：');
disp(Pi);
disp('无功计算结果：');
disp(Qi);

for i = 1 : n
    for j = 1 : n
        [Pij(i, j), Qij(i, j)] = Sijtide(i, j, U, Theta, G, B);
    end
end

for i = 1 : n
    for j = 1 : n
        if Y(i, j) ~= 0 && i ~= j
            fprintf("S%d%d : %14d + %14dj\n", i, j, Pij(i, j), Qij(i, j));
        end
    end
end