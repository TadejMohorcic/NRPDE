function [T, X, u, max_razlika] = spremeniX(J)
% metoda za prvi primer, ko spreminjamo delta_x
% N je fiksen, J pa je vhodni parameter, ki ga lahko poljubno spreminjamo
% ter določa delitev v x smeri
% kot izhod vrne seznam [T, X, u, max_razlika]
% T in X sta mreži, uporabljeni za risanje rešitve
% u je rešitev, max_razlike pa je max absolutne vrednost razlike med
% numerično in točno vrednostjo

c = @(t, x) sin(t); % funckija, ki nastopa v PDE
f = @(x) exp(-x.^2); % funkcija, ki določa tačetni pogoj
g = @(t) exp(-(-2-(1-cos(t))).^2); % prvi robni pogoj pri a = -2
h = @(t) exp(-(4-(1-cos(t))).^2); % drugi robni pogoj pri a = 4

T = 2 * pi;
a = -2;
b = 4;

% določimo N in J tako, da sta delta_t in delta_x blizu 0.1
N = 63;
% določimo različne J, saj s tem spreminajmo delta_x
% zanima nas, kaj se dogaja z rešitvijo, ko spreminjamo delta_x, delta_t pa
% ostaja konstanten

[T, X, u] = resiPoVetru(c, f, g, h, T, a, b, N, J);
true_u_fun = @(t, x) exp(-(x-(1-cos(t))).^2);
true_u = true_u_fun(T, X);
razlika = abs(u - true_u);
max_razlika = max(razlika(:));

end





