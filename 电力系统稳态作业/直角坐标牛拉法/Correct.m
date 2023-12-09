function [dUe, dUf] = Correct(n, m, dP, dQ, dU2, J)
%求解节点的修正量
%书P54

dW = zeros(2 * n - 2, 1);

for i = 1:m
    dW(2 * i - 1) = dP(i);
    dW(2 * i)= dQ(i);
end

for i = m+1:n-1
    dW(2 * i - 1) = dP(i);
    dW(2 * i)= dU2(i - m);
end

dU = -inv(J) * dW;

for i = 1:n-1
    dUe(i) = dU(2 * i - 1);
    dUf(i) = dU(2 * i);
end

dUe = [dUe, 0];
dUf = [dUf, 0];

end