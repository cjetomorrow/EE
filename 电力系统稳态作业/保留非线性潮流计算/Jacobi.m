function [J] = Jacobi(n, m, Ue, Uf, G, B)
%JACOBI 雅克比矩阵生成
%   n ：共计n个节点
%   m ：m个PQ节点
%   Ue ：节点电压实部
%   Uf ：节点电压虚部
%   G ：节点电导
%   B ：节点电纳
%   Pi ：节点有功功率
%   Qi ：节点无功功率
%   假设前m行是PQ节点，后面的PV节点，最后是平衡节点
%	东南本科PPT


H = zeros(n - 1);
N = zeros(n - 1);
M = zeros(n - m - 1, n - 1);
L = zeros(n - m - 1, n - 1);
R = zeros(m, n - 1);
S = zeros(m, n - 1);

for i = 1:n-1
    for j = 1:n-1
        if (i ~= j)
            H(i, j) = G(i, j) * Uf(i) - B(i, j) * Ue(i);
            N(i, j) = G(i, j) * Ue(i) + B(i, j) * Uf(i);
        else
            aii = 0;
            bii = 0;
            for k = 1:n
                aii = aii + G(i, k) * Ue(k) - B(i, k) * Uf(k);
                bii = bii + G(i, k) * Uf(k) + B(i, k) * Ue(k);
            end
            H(i, j) = G(i, j) * Uf(i) - B(i, j) * Ue(i) + bii;
            N(i, j) = G(i, j) * Ue(i) + B(i, j) * Uf(i) + aii;
        end
    end
end

for i = 1:n-m-1
    for j = 1:n-1
        if (i ~= j)
            M(i, j) = -N(i, j);
            L(i, j) = H(i, j);
        else
            aii = 0;
            bii = 0;
            for k = 1:n
                aii = aii + G(i, k) * Ue(k) - B(i, k) * Uf(k);
                bii = bii + G(i, k) * Uf(k) + B(i, k) * Ue(k);
            end
            M(i, j) = -G(i, j) * Ue(i) - B(i, j) * Uf(i) + aii;
            L(i, j) = G(i, j) * Uf(i) - B(i, j) * Ue(i) - bii;
        end
    end
end

for i = 1:m
    for j = n-m-1:n-1
        if (i ~= j+m-n+1)
            R(i, j) = 0;
            S(i, j) = 0;
        else
            R(i, j) = 2 * Uf(i);
            S(i, j) = 2 * Ue(i);
        end
    end
end

J = [H, N; M, L; R, S];

end