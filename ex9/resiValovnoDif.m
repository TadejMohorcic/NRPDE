function [U, x] = resiValovnoDif(c, f, g, h1, h2, T, a, b, N, J)
% function [U, x] = resiValovnoDif(c, f, g, h1, h2, T, a, b, N. J) izracuna
% resitev valovne enacbe du^2/dt^2 = c^2du^2/dx^2 z zacetnima pogojema u(0,
% x) = f(x) in d/dt u(0, x) = g(x) ter robnima pogojema u(t, a) = h1(t) in
% u(t, b) = h2(t) z uporabo diferencne sheme.

dt = T/N;
dx = (b - a)/(J + 1);
lam = c * dt/dx;

x = a:dx:b;

U = zeros(N + 1, J + 2);

U(1, :) = f(x);

U(2, 1) = h1(dt);
U(2, end) = h2(dt);
U(2, 2:J+1) = (1 - lam^2) * U(1, 2:J+1) + lam^2/2*(U(1, 1:J) + U(1, 3:J+2)) + dt*g(x(2:J+1));

for n = 2:N
    U(n+1, 1) = h1(n * dt);
    U(n+1, end) = h2(n * dt);
    U(n+1, 2:J+1) = 2 * (1 - lam^2) * U(n, 2:J+1) + lam^2 * (U(n, 1:J) + U(n, 3:J+2)) - U(n-1, 2:J+1);
end

end