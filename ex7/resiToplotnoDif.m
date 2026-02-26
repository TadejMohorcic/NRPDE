function [U,lambda] = resiToplotnoDif(c,f,g,h,T,a,b,N,J,th)
% Opis:
%  resiToplotnoDif izracuna resitev toplotne enacbe du/dt = c^2 du^2/dx^2 z
%  zacetnim pogojem u(0,x) = f(x) ter robnima pogojema u(t,a) = g(t) in
%  u(t,b) = h(t) z uporabo utezene diferencne sheme pri predpisani
%  diskretizaciji
%
% Definicija:
%  [U,x] = resiToplotnoDif(c,f,g,h,T,a,b,N,J,th)
%
% Vhodni podatki:
%  c        parameter, ki doloca enacbo,
%  f        funkcija, ki doloca zacetni pogoj,
%  g,h      funkciji, ki dolocata robni pogoj,
%  T        maksimalni cas,
%  a,b      parametra, ki omejujeta prostorsko spremenljivko,
%  N        stevilo delilnih tock v casovni smeri (brez 0),
%  J        stevilo notranjih delilnih tock v prostorski smeri,
%  th       parameter utezene diferencne sheme (0 = eksplicitna shema,
%           1 = implicitna shema, 1/2 = Crank-Nicolsonova shema)
%
% Izhodna podatka:
%  U        tabela velikosti (N+1)x(J+2), ki vsebuje izracunane priblizke
%           za resitev problema pri casih med 0 in T ter polozajih med a in
%           b; natancneje, element na mestu (n,j) predstavlja priblizek pri
%           casu (n-1)*T/N in polozaju a+(j-1)*(b-a)/(J+1).
%  lambda   Courantovo stevilo

t = linspace(0,T, N+1);
x = linspace(a, b, J+2);

dt = T/N; dx = (b-a)/(J+1);
lambda = c^2*dt/(dx^2);

U = zeros(N+1, J+2);
U(1,:) = f(x);
U(2:end,1) = g(t(2:end));
U(2:end,end) = h(t(2:end));
B = 2*diag(ones(1,J)) - diag(ones(1,J-1),-1) - diag(ones(1,J-1),1);
b = @(x) [g(x) zeros(1,J-2) h(x)]';

for n = 2:N+1
    u = U(n-1,2:end-1)';
    A = eye(J)+th*lambda*B;
    C = eye(J)-(1-th)*lambda*B;
    D = lambda*(th*b(dt*(n-1))+(1-th)*b(dt*(n-2)));
    u1 = A\(C*u+D);
    U(n,2:end-1) = u1';
end

