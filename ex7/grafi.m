format long
J = 9;
N = 100;
c = 1/2;
g = @(t) 0; h = @(t) 0;
f = @(x) 2*x.*(x<=1/2) + 2*(1-x).*(x>1/2);
a = 0; b = 1;
T = 1;

y = linspace(0, T, N+1);
x = linspace(a, b, J+2);

[X,Y] = meshgrid(x,y);

tiledlayout(2,3)
nexttile
U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,0);
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Eksplicitna shema')

U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,1);
nexttile
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Implicitna shema')

U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,1/2);
nexttile
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Crank-Nicolsonova shema')


g = @(t) t; h = @(t) t;

U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,0);
nexttile
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Eksplicitna shema')

U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,1);
nexttile
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Implicitna shema')

U = resiToplotnoDif(c,f,g,h,T,a,b,N,J,1/2);
nexttile
surf(X,Y,U)
xlabel('x')
ylabel('t')
zlabel('U')
title('Crank-Nicolsonova shema')