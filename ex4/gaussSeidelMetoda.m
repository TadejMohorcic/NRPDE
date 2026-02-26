function [gaussSeidel, koraki_gs] = gaussSeidelMetoda(U, F, tx, ty, delta, max_koraki, tol)
% function [gaussSeidel, koraki_gs] = gaussSeidelMetoda(U, F, tx, ty,
% delta, max_koraki, tol) izvaja Gauss--Seidlovo iteracijo dokler ne
% presežemo največjega števila korakov ali se rešitev med dvema korakoma ne
% razlikuje veliko.
% Vhodni podatki: matrika U začetnih približkov, matrika F vrednosti
% funkcije f(x,y), tx,ty in delta izračunane glede na št. delilnih točk,
% število največjih korakov max_koraki in toleranca tol.
% Izhodna podatka: matrika gaussSeidel konvergiranih vrednosti rešitve in
% število izvedenih korakov koraki_gs

gaussSeidel = U;

razlika_gs = inf;
koraki_gs=1;

K = size(U,1) - 2;
J = size(U,2) - 2;

while koraki_gs < max_koraki && razlika_gs > tol
    razlika_gs = 0;
    for k = 2:K+1
        for j = 2:J+1
            stara_vrednost = gaussSeidel(k,j);
            gaussSeidel(k,j) = tx*(gaussSeidel(k,j-1) + gaussSeidel(k, j+1)) + ty*(gaussSeidel(k-1,j) + gaussSeidel(k+1,j)) + delta*F(k,j);
            razlika_gs = max(abs(stara_vrednost - gaussSeidel(k,j)),razlika_gs);
        end
    end
    koraki_gs = koraki_gs+1;

end
end