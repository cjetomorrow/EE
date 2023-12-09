function [P, Q, Ue, Uf, Us] = InitPQ()
%INITPQ PQ节点的确定
% 
n = 3;
m = 1;
P = zeros(1, n);
Q = zeros(1, n);
Ue = ones(1, n);
Uf = zeros(1, n);
Us = zeros(1, n - m - 1);


%PV节点参数：母线 P U
Gen = [2, -0.6661 1.05];

%负荷参数：母线 P Q，负荷消耗功率（负值）, 蜉蝣节点P,Q均取0
Load = [1, -2.8653 -1.2244];

for i = 1 : size(Gen,1)
    P(Gen(i, 1)) = Gen(i, 2);
	Us(Gen(i, 1) - m) = Gen(i, 3);
end

for i = 1 : size(Load,1)
    P(Load(i, 1)) = Load(i, 2);
    Q(Load(i, 1)) = Load(i, 3);
end

Ue(n) = 1;
Uf(n) = 0;

end