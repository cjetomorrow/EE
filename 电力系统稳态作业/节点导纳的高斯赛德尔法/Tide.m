clear
clc

Tmax = 50;                                  %最大迭代次数
limit = 1.0e-6;                             %要求精度
n = 3;                                      %总节点数
m = 1;                                      %PQ节点数

[S, U] = InitPQ();
disp('初始条件：')
disp('各节点功率：')
disp(S);
disp('各节点电压：')
disp(U);
Y = InitY();
disp('节点导纳矩阵');
disp(Y);


for i = 1 : Tmax
    Uk = U(1:n-1);

    for j = m+1:n-1
        S(j) = real(S(j)) + 1j * imag(U(j) * (conj(Y(j, :)) * conj(U)));
    end

    for j = 1:n-1
        U(j) = (conj(S(j)) / conj(U(j)) - Y(j, :) * U + Y(j, j) * U(j)) / Y(j, j);
    end

    for j = m+1:n-1
        if (abs(U(j)) ~= abs(Uk(j)))
            U(j) = abs(Uk(j)) * (cos(angle(U(j))) + 1j * (sin(angle(U(j)))));
        end
    end

    if (max(abs(U - [Uk; 1])) < limit)
        break;
    end
end

if (i < 50)
	disp('计算收敛');
else
	disp('计算不收敛或未达到要求精度');
end

[Pi, Qi] = PQCalculation(n, real(U), imag(U), real(Y), imag(Y));
S = (Pi + 1j * Qi).';

%打印功率
fprintf('迭代总次数：%d\n', i);
disp('节点电压：');
disp(U);
disp('功率结果：');
disp(S);
Ue = real(U);
Uf = imag(U);
G = real(Y);
B = imag(Y);

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