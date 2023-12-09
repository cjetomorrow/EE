function [dU] = CorrectU(m, U, B2, dQ)
%求解节点的修正量
%书P59

for i = 1 : m
    Ud2(i, i) = U(i);                               %m * m阶方阵
end

dU = -inv(B2) * inv(Ud2) * dQ;
end