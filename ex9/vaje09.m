% primer resevanja valovne enacbe z diferencno metodo

% enacba in obmocje
c = 1;
T = 0.5;
a = 0;
b = 1;

% zacetna pogoja
f = @(x) (-11*x/7).*(0<=x & x<7/10) + (1000*x.^3/7 - 2020*x.^2/7 + 1347*x/7 - 217/5).*(7/10<=x & x<=4/5) + (5*x - 5).*(4/5<x & x<=1);
g = @(x) zeros(size(x));

% robna pogoja
h1 = @(x) zeros(size(T));
h2 = @(x) zeros(size(T));

% diskretizacija
N = 40;
J = 79;
fprintf('Courantovo stevilo: %g\n', c*(T/N)/((b-a)/(J+1)));

[U, x] = resiValovnoDif(c,f,g,h1,h2,T,a,b,N,J);

% izris resitve
clf
hold on
for i = 1:size(U, 1)
    plot(x, U(i, :));
end
hold off
