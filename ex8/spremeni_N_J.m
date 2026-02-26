function [max_diff_v1, max_diff_v2, max_diff_u] = spremeni_N_J(N,J)
% funkcija, ki kot vhod sprejme N in J
% ter reši nalogo 2 za dani v1, v2 in u
% kot izhod vrne maksimalne absolutne vrednosti razlik za posamezne
% funkcije, ki jih uporabimo za določitev kvalitete rešitve

c = 0.5;

v1 = @(t, x) sin(pi * (x + c * t)) / sqrt(2); % prva funckija
v2 = @(t, x) sin(pi * (x - c * t)) / sqrt(2); % druga funkcija
u = @(t, x) (v1(t, x) + v2(t, x)) / sqrt(2); 

f = @(x) sin(pi * x) / sqrt(2); % začetni pogoj
g = @(t) - sin(pi * c * t) / sqrt(2); % prvi robni pogoj
h = @(t) sin(pi * (1 + c * t)) / sqrt(2); % drugi robni pogoj

T = 1;
a = 0;
b = 1;

[~, ~, numerical_v1] = resiPoVetru(-c, f, g, h, T, a, b, N, J);
[T, X, numerical_v2] = resiPoVetru(c, f, g, h, T, a, b, N, J);
numerical_u = (numerical_v1 + numerical_v2) / sqrt(2);

true_v1 = v1(T, X);
true_v2 = v2(T, X);
true_u = u(T, X);

% izračunamo maksimalne absolutne vrednosti razlik za dano funkcijo in njen
% numeričen približek
max_diff_v1 = max(max(abs(numerical_v1 - true_v1)));
max_diff_v2 = max(max(abs(numerical_v2 - true_v2)));
max_diff_u = max(max(abs(numerical_u - true_u)));


end