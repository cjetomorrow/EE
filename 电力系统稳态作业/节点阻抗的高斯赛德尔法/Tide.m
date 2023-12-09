clear
clc

Tmax = 50;                                  %最大迭代次数
limit = 1.0e-6;                             %要求精度
n = 3;                                      %总节点数
m = 1;                                      %PQ节点数

[S, U] = InitPQ();
Us = U(m+1:n-1);
disp('初始条件：')
disp('各节点功率：')
disp(S);
disp('各节点电压：')
disp(U);
Y = InitY();
Z = inv(Y);
disp('节点阻抗矩阵');
disp(Z);
I = real(S) * (1 - j/2) ./ conj(U);
dI = zeros(n, 1);


for i = 1 : Tmax
    U1 = U;
    I(n) = (U(n) - sum(Z(1:n-1, n) .* I(1:n-1))) / Z(n, n);

    for j = 1:m
        U(j) = sum(Z(:, j) .* I);
        I(j) = conj(S(j)) / conj(U(j));
        I(n) = (U(n) - sum(Z(1:n-1, n) .* I(1:n-1))) / Z(n, n);
    end

    for j = m+1:n-1
        %Uc(j) = S(j) / conj(I(j));
        Uc(j) = sum(Z(:, j) .* I);
        U(j) = Uc(j) * Us(j - m) / abs(Uc(j));
        dI = Uc(j) / (Z(j, j) - Z(j, n)^2 / Z(n, n)) * (Us(j - m) / abs(Uc(j)) - 1);
        S(j) = real(S(j)) + 1j * imag(U(j) * conj(I(j) + dI));
        I(j) = conj(S(j)) / conj(U(j));
        I(n) = (U(n) - sum(Z(1:n-1, n) .* I(1:n-1))) / Z(n, n);
    end

    if (abs(U1 - U) < limit)
        break;
    end
end


if (i < 50)
	disp('计算收敛');
else
	disp('计算不收敛或未达到要求精度');
end

[Pi, Qi] = PQCalculation(n, real(U), imag(U), real(Y), imag(Y));
S = Pi + 1j * Qi;

%打印功率
fprintf('迭代总次数：%d\n', i);
disp('节点电压：');
disp(U);
disp('功率结果：');
disp(S.');

for i = 1 : n
    for j = 1 : n
        [Pij(i, j), Qij(i, j)] = Sijtide(i, j, real(U), imag(U), real(Y), imag(Y));
    end
end

for i = 1 : n
    for j = 1 : n
        if Y(i, j) ~= 0 && i ~= j
            fprintf("S%d%d : %14d + %14dj\n", i, j, Pij(i, j), Qij(i, j));
        end
    end
end

abs(U)