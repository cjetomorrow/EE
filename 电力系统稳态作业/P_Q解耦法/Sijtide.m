function [PIJ, QIJ] = Sijtide(I, J, U, Theta, G, B)
%PTIDE 此处显示有关此函数的摘要
%   从I流到J的潮流

g = -G;
b = -B;
gI0 = sum(g(I, :));
bI0 = -sum(b(I, :));

PIJ = U(I)^2 * (gI0 + g(I, J)) - U(I) * U(J) * (g(I, J) * cos(Theta(I) - Theta(J)) + b(I,J) * sin(Theta(I) - Theta(J)));
QIJ = -U(I)^2 * (bI0 + b(I, J)) + U(I) * U(J) * (b(I, J) * cos(Theta(I) - Theta(J)) - g(I,J) * sin(Theta(I) - Theta(J)));

end