function [PIJ, QIJ] = Sijtide(I, J, Ue, Uf, G, B)
%PTIDE 此处显示有关此函数的摘要
%   从I流到J的潮流

g = -G;
b = -B;
gI0 = sum(g(I, :));
bI0 = -sum(b(I, :));

PIJ = (Ue(I) ^ 2 + Uf(I) ^ 2) * (gI0 + g(I, J)) - g(I, J) * (Ue(I) * Ue(J) + Uf(I) * Uf(J)) + b(I, J) * (Uf(I) * Ue(J) - Ue(I) * Uf(J));
QIJ = -(Ue(I) ^ 2 + Uf(I) ^ 2) * (bI0 + b(I, J)) + b(I, J) * (Ue(I) * Ue(J) + Uf(I) * Uf(J)) - g(I, J) * (Uf(I) * Ue(J) - Ue(I) * Uf(J));

end