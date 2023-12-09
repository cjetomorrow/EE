function [dP, dQ, dU2, Pi, Qi] = Unbalanced(n, m, Ue, Uf, Us, G, B, P, Q)
%	计算节点的不平衡分量
%   n ：共计n个节点
%   m ：m个PQ节点
%   Ue ：节点电压实部
%   Uf ：节点电压虚部
%   G ：节点电导
%   B ：节点电纳
%   P ：节点有功功率给定值
%   Q ：节点无功功率给定值

for i = 1 : n
    for j = 1 : n
       Pn(j) = Ue(i) * (G(i, j) * Ue(j) - B(i, j) * Uf(j)) + Uf(i) * (G(i, j) * Uf(j) + B(i, j) * Ue(j));
    end
    Pi(i) = sum(Pn);                %计算的得到的节点有功功率
end

for i = 1 : n - 1
    dP(i) = P(i) - Pi(i);			%有功不平衡量
end

for i = 1 : n
    for j = 1 : n
       Qn(j) = Uf(i) * (G(i, j) * Ue(j) - B(i, j) * Uf(j)) - Ue(i) * (G(i, j) * Uf(j) + B(i, j) * Ue(j));
    end
    Qi(i) = sum(Qn);                %计算的得到的节点无功功率
end

for i = 1 : m
    dQ(i) = Q(i) - Qi(i);			%无功不平衡量
end

for i = 1 : n-m-1
    dU2(i) = Us(i) ^ 2 - Ue(i + m) ^ 2 - Uf(i + m) ^ 2;
end

end
