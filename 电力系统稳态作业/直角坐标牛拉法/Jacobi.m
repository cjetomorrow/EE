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
%	电分下54页

J = zeros(2 * n - 2);

for i = 1:m
    for j = 1:n-1
        if (i ~= j)
            J(2 * i - 1, 2 * j - 1) = -1 * (G(i, j) * Ue(i) + B(i, j) * Uf(i));
            J(2 * i - 1, 2 * j) = B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j - 1) = B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j) = G(i, j) * Ue(i) + B(i, j) * Uf(i);
        else
            k1 = 0;
            k2 = 0;

            for k = 1:n
                k1 = k1 + (G(i, k) * Ue(k) - B(i, k) * Uf(k));
                k2 = k2 + (G(i, k) * Uf(k) + B(i, k) * Ue(k));
            end

            J(2 * i - 1, 2 * j - 1) = -k1 - G(i, j) * Ue(i) - B(i, j) * Uf(i);
            J(2 * i - 1, 2 * j) = -k2 + B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j - 1) = k2 + B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j) = -k1 + G(i, j) * Ue(i) + B(i, j) * Uf(i);
        end
    end
end

for i = m+1:n-1
    for j = 1:n-1
        if (i ~= j)
            J(2 * i - 1, 2 * j - 1) = -1 * (G(i, j) * Ue(i) + B(i, j) * Uf(i));
            J(2 * i - 1, 2 * j) = B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j - 1) = 0;
            J(2 * i, 2 * j) = 0;
        else
            k1 = 0;
            k2 = 0;

            for k = 1:n
                k1 = k1 + (G(i, k) * Ue(k) - B(i, k) * Uf(k));
                k2 = k2 + (G(i, k) * Uf(k) + B(i, k) * Ue(k));
            end

            J(2 * i - 1, 2 * j - 1) = -k1 - G(i, j) * Ue(i) - B(i, j) * Uf(i);
            J(2 * i - 1, 2 * j) = -k2 + B(i, j) * Ue(i) - G(i, j) * Uf(i);
            J(2 * i, 2 * j - 1) = -2 * Ue(i);
            J(2 * i, 2 * j) = -2 * Uf(i);
        end
    end
end

end

