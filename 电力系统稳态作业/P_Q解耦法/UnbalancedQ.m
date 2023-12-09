function [dQ, Qi] = UnbalancedQ(n, m, U, Theta, G, B, Q)
%	计算节点的不平衡分量
%   n ：共计n个节点
%   m ：m个PQ节点
%   U ：节点电压幅值
%   Theta ：节点电压幅角
%   G ：节点电导
%   B ：节点电纳
%   Q ：节点无功功率给定值
%	电分下59 11-58
for i = 1 : n
    for j = 1 : n
       Qn(j) = U(i) * U(j) * (G(i, j) * sin(Theta(i) - Theta(j)) - B(i, j) * cos(Theta(i) - Theta(j)));
    end
    Qi(i) = sum(Qn);                %计算的得到的节点无功功率
end

for i = 1 : m
    dQ(i) = Q(i) - Qi(i);			%无功不平衡量
end

end
