function [S, U] = InitPQ()
%INITPQ PQ节点的确定
% 
n = 3;
P = zeros(n, 1);
Q = zeros(n, 1);
Ue = ones(n, 1);                                             %电压初始值
Uf = zeros(n, 1);


%PV节点参数：母线 P U
Gen = [2, -0.6661 1.05];

%负荷参数：母线 P Q，负荷消耗功率（负值）, 蜉蝣节点P,Q均取0
Load = [1, -2.8653 -1.2244];

for i = 1 : size(Gen,1)
    P(Gen(i, 1)) = Gen(i, 2);
	Ue(Gen(i, 1)) = Gen(i, 3);
end

for i = 1 : size(Load,1)
    P(Load(i, 1)) = Load(i, 2);
    Q(Load(i, 1)) = Load(i, 3);
end

Ue(n) = 1;
S = P + 1j*Q;
U = Ue + 1j*Uf;

end