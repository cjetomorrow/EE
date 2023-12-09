function [dP, dQ, Pi, Qi] = Unbalanced(n, m, U, Theta, G, B, P, Q)
%	计算节点的不平衡分量
%   n ：共计n个节点
%   m ：m个PQ节点
%   U ：节点电压幅值
%   Theta ：节点电压幅角
%   G ：节点电导
%   B ：节点电纳
%   P ：节点有功功率给定值
%   Q ：节点无功功率给定值
%	电分下59 11-58
for i = 1 : n
    for j = 1 : n
       Pn(j) = U(i) * U(j) * (G(i, j) * cos(Theta(i) - Theta(j)) + B(i, j) * sin(Theta(i) - Theta(j)));

    end
    Pi(i) = sum(Pn);                %计算的得到的节点有功功率
end

for i = 1 : n - 1
    dP(i) = P(i) - Pi(i);			%有功不平衡量
end

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
