function [x, y_val] = resiRobniProblem1D(p,q,r,a,b,J,alpha,beta,sparse)
%RESIROBNIPROBLEM1D Poisce resitev problema
%             - (py')' + qy = r,
% kjer so:
%   p, q, r ...... funkcije ene spremenljivke,
%   a, b ......... meji intervala [a,b] na katerem iscemo resitev,
%   J ............ stevilo tock na katerih zelimo resitev,
%   alpha, beta .. leva in desna zacetna vrednost in
%   sparse ....... neobvezen argument za uporabo sparse matrik.
arguments
    p           function_handle
    q           function_handle
    r           function_handle
    a           double
    b           double
    J           double
    alpha       double
    beta        double
    sparse      logical = true
end

assert((a < b), "Interval is not well-defined");

if sparse 
    x_val = linspace(a,b,J+2);
    h = (b - a)/(J + 1);

    c = @(x) q(x)*h^2 + p(x+0.5*h) + p(x-0.5*h) ;
    d = @(x) - p(x+0.5*h);

    c_vals = arrayfun(c,x_val(2:end-1));
    d_vals = arrayfun(d,x_val(2:end-2));

    M = [[d_vals,0]' c_vals' [0,d_vals]'];

    A = spdiags(M,-1:1,J,J);

    f = arrayfun(r,x_val(2:end-1))*h^2;
    f(1) = f(1) + alpha*p(a+0.5*h);
    f(end) = f(end) + beta*p(b-0.5*h);

    y_val = A\f';
    
    x = linspace(a,b,J+2);
    y_val = [alpha; y_val; beta];
else 
    x_val = linspace(a,b,J+2);
    h = (b - a)/(J + 1);

    c = @(x) q(x)*h^2 + p(x+0.5*h) + p(x-0.5*h);
    d = @(x) - p(x+0.5*h);

    c_vals = arrayfun(c,x_val(2:end-1));
    d_vals = arrayfun(d,x_val(2:end-2));

    A = diag(c_vals) + diag(d_vals,1) + diag(d_vals,-1);
    
    f = arrayfun(r,x_val(2:end-1))*h^2;
    f(1) = f(1) + alpha*p(a+0.5*h);
    f(end) = f(end) + beta*p(b-0.5*h);

    y_val = A\f';
    
    x = linspace(a,b,J+2);
    y_val = [alpha; y_val; beta];
end
