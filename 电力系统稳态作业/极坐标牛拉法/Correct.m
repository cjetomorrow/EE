function [dU, dTheta] = Correct(n, m, U, dP, dQ, J)
%求解节点的修正量
%书P59

for i = 1 : m
    Ud2(i, i) = U(i);                               %m * m阶方阵
end

dPQ = [dP, dQ]';                                    %P是1 * n - 1阶矩阵，Q是1 * m阶矩阵，dPQ是n + m - 1 * 1阶矩阵
dUTheta = (-(inv(J)) * dPQ)';                       %dUTheta是1 * n + m - 1阶矩阵
dTheta = dUTheta(1, 1: n - 1);                      %dUTheta的前n - 1个是dTheta，除了平衡节点，所有节点都要修正电压幅角
dTheta = [dTheta, 0];                               %算上平衡节点,平衡节点是第n个所以补在最后，补零即不修改
dU = (Ud2 * dUTheta(1, n : n + m - 1)')';           %后m个是dU，m个PQ节点需要修正电压幅值
dU = [dU, zeros(1, n - m)];                         %仅修正前m个PQ节点的电压幅值，后面补上n - m个零代表不修改
end