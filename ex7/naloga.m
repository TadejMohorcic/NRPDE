format long
J = 9;
N = 100;
c = 1/2;
g = @(t) 0; h = @(t) 0; % alipa g=h=t
f = @(x) 2*x.*(x<=1/2) + 2*(1-x).*(x>1/2);
a = 0; b = 1;
T = 1;
th = 0; %utez theta (0...expl, 1...impl, 1/2...C_N shema)


[U,lambda] = resiToplotnoDif(c,f,g,h,T,a,b,N,J,th);

U(N+1,:)'
lambda

