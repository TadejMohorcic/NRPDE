function u = biharmonicniOperator(f, x, y, h)
% function u = biharmonicniOperator(f, x, y, h) izracuna vrednost
% biharmonicnega operatorja funkcije f v tocki (x, y).

u = f(x - 2*h, y) + f(x + 2*h, y) + f(x, y - 2*h) + f(x, y + 2*h);
u = u + 2*(f(x - h, y - h) + f(x - h, y + h) + f(x + h, y - h) + f(x + h, y + h));
u = u - 8*(f(x - h, y) + f(x + h, y) + f(x, y - h) + f(x, y + h));
u = 1/h^4 * (u + 20*f(x, y));

end