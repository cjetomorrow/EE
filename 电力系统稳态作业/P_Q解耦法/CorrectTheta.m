function [dTheta] = CorrectTheta(n, U, dP, B1)
%求解节点的修正量
%书P59

for i = 1 : n-1
    Ud1(i, i) = U(i);                                       
end

dTheta = -dP / (Ud1*B1*Ud1);
dTheta = [dTheta, 0];
end