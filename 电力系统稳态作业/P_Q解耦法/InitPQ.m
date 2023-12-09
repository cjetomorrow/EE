function [P, Q, U, Theta] = InitPQ()
%INITPQ PQ节点的确定
% 
n = 3;
P = zeros(1, n);
Q = zeros(1, n);
U = ones(1,n);                                  %电压初始值
Theta = zeros(1, n);                            %此处未知节点皆设为1.0∠0，此处角度单位为度，提取后再转换成弧度，后面计算使用弧度


%PV节点参数：母线 P U
Gen = [2, -0.6661 1.05];

%负荷参数：母线 P Q，负荷消耗功率（负值）, 蜉蝣节点P,Q均取0
Load = [1, -2.8653 -1.2244];

for i = 1 : size(Gen,1)
    P(Gen(i, 1)) = Gen(i, 2);
	U(Gen(i, 1)) = Gen(i, 3);
end

for i = 1 : size(Load,1)
    P(Load(i, 1)) = Load(i, 2);
    Q(Load(i, 1)) = Load(i, 3);
end

U(n) = 1;
Theta(n) = 0;

end