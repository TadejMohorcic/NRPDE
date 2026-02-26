function [jacobi, koraki_jacobi] = jacobiMetoda(U, F, tx, ty, delta, max_koraki, tol)
% function [jacobi, koraki_jacobi] = jacobiMetoda(U, F, tx, ty, delta,
% max_koraki, tol) izvaja Jakobijevo iteracijo dokler ne presežemo
% največjega števila korakov ali se rešitev med dvema korakoma ni
% spremenila veliko.
% Vhodni podatki: matrika U začetnih približkov, matrika F vrednosti
% funkcije f(x,y), tx,ty in delta izračunane glede na št. delilnih točk,
% število največjih korakov max_koraki in toleranca tol.
% Izhodna podatka: matrika jacobi konvergiranih vrednosti rešitve in
% število izvedenih korakov koraki_jacobi.

jacobi_prev = U;
jacobi = U;

razlika_jacobi = inf;
koraki_jacobi = 1;

K = size(U,1) - 2;
J = size(U,2) - 2;

while koraki_jacobi < max_koraki && razlika_jacobi > tol
    for k = 2:K+1
        for j = 2:J+1
            jacobi(k,j) = tx*(jacobi_prev(k,j-1) + jacobi_prev(k, j+1)) + ty*(jacobi_prev(k-1,j) + jacobi_prev(k+1,j)) + delta*F(k,j);
        end
    end
    razlika_jacobi = max(max(abs(jacobi - jacobi_prev)));
    
    jacobi_prev = jacobi;
    koraki_jacobi = koraki_jacobi + 1;

end
end