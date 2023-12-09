function [J] = Jacobi(n, m, U, Theta, G, B, Pi, Qi)
%JACOBI 雅克比矩阵生成，采用极坐标法，因为极坐标的方程较直角坐标形式少n - m - 1个
%   n ：共计n个节点
%   m ：m个PQ节点
%   U ：节点电压幅值
%   Theta ：节点电压幅角
%   G ：节点电导
%   B ：节点电纳
%   Pi ：节点有功功率
%   Qi ：节点无功功率
%	雅可比矩阵是n + m - 1阶矩阵
%	电分下60页上方

H = zeros(n - 1);                   %   H : (n - 1)阶方阵，为有功功率对电压幅角的导数
N = zeros(n - 1, m);                %   N : (n - 1) * m阶矩阵，为有功功率对电压幅值的导数
K = zeros(m, n - 1);                %   K : m * (n - 1)阶矩阵，为无功功率对电压幅角的导数
L = zeros(m);                       %   L : m阶方阵，为无功功率对电压幅值的导数

for i = 1 : n - 1
    for j = 1 : n -  1
        if i ~= j
            H(i, j) = -1 * U(i) * U(j) * (G(i,j) * sin(Theta(i) - Theta(j)) - B(i, j) * cos(Theta(i) - Theta(j)));
        else
            H(i, j) = U(i).^2 * B(i,j) + Qi(i);
        end
    end

    for k = 1 : m
        if i ~= k
            N(i, k) = -1 * U(i) * U(k) * (G(i,k) * cos(Theta(i) - Theta(k)) + B(i, k) * sin(Theta(i) - Theta(k)));
        else
            N(i, k) = -1 * U(i).^2 * G(i, k) - Pi(i);
        end
    end
end



for i = 1 : m
    for j = 1 : n - 1
        if i ~= j
            K(i, j) = U(i) * U(j) * (G(i,j) * cos(Theta(i) - Theta(j)) + B(i, j) * sin(Theta(i) - Theta(j)));
        else
            K(i, j) = U(i).^2 * G(i, j) - Pi(i);
        end
    end

    for k = 1 : m
        if i ~= k
            L(i, k) = -1 * U(i) * U(k) * (G(i,k) * sin(Theta(i) - Theta(k)) - B(i, k) * cos(Theta(i) - Theta(k)));
        else
            L(i, k) = 1 * U(i).^2 * B(i, k) - Qi(i);
        end
    end
end

J=[H N;K L];

end

