function [Pi, Qi] = PQCalculation(n, Ue, Uf, G, B)
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
       Pn(j) = G(i, j) * Ue(i) * Ue(j) - B(i, j) * Ue(i) * Uf(j) + G(i, j) * Uf(i) * Uf(j) + B(i, j) * Uf(i) * Ue(j);
    end
    Pi(i) = sum(Pn);                %计算的得到的节点有功功率
end

for i = 1 : n
    for j = 1 : n
       Qn(j) = G(i, j) * Uf(i) * Ue(j) - B(i, j) * Uf(i) * Uf(j) - G(i, j) * Ue(i) * Uf(j) - B(i, j) * Ue(i) * Ue(j);
    end
    Qi(i) = sum(Qn);                %计算的得到的节点无功功率
end

end
