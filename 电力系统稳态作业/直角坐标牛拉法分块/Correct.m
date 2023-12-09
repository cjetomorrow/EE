function [dUe, dUf] = Correct(n, dP, dQ, dU2, J)
%求解节点的修正量
%东南本科PPT

dW = [dP dQ dU2]';
dU = J \ dW;

dUf = [dU(1:n-1)', 0];
dUe = [dU(n:end)', 0];

end