function u = laplaceovOperator(f, x, y, h)
% function u = laplaceovOperator(f, x, y, h) izracuna aproksimacijo
% Laplaceovega operatorja funkcije f v tocki (x, y).

u = 1/h^2 * (f(x - h, y) + f(x + h, y) + f(x, y - h) + f(x, y + h) - 4 * f(x, y));

end