function [sor, koraki_sor] = sorMetoda(U, F, tx, ty, delta, max_koraki, tol, omega)
% function [sor, koraki_sor] = sorMetoda(U, F, tx, ty, delta, max_koraki,
% tol, omega) izvaja SOR iteracijo dokler ne presežemo največjega števila
% korakov ali se rešitev med dvema korakoma ne razlikuje veliko.
% Vhodni podatki: matrika U začetnih približkov, matrika F vrednosti
% funkcije f(x,y), tx,ty in delta izračunane glede na št. delilnih točk,
% število največjih korakov max_koraki, toleranca tol in omega.
% Izhodna podatka: matrika sor konvergiranih vrednosti rešitve in število
% izvedenih korakov metode koraki_sor.

sor = U;

razlika_sor = inf;
koraki_sor = 1;

K = size(U,1) - 2;
J = size(U,2) - 2;

while koraki_sor < max_koraki && razlika_sor > tol
    razlika_sor = 0;
    for k = 2:K+1
        for j = 2:J+1
            stara_vrednost = sor(k,j);
            sor(k,j) = (tx*(sor(k,j-1) + sor(k, j+1)) + ty*(sor(k-1,j) + sor(k+1,j)) + delta*F(k,j))*omega + (1 - omega)*sor(k,j);
            razlika_sor = max(abs(stara_vrednost - sor(k,j)),razlika_sor);
        end
    end
    koraki_sor = koraki_sor+1;

end
end