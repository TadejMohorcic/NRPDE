% določi N in J tako, da sta delta_t in delta_x blizu 0.1
N = 20;
J = 19;
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
max_diff_v1 = max(max(abs(numerical_v1 - true_v1)))
max_diff_v2 = max(max(abs(numerical_v2 - true_v2)))
max_diff_u = max(max(abs(numerical_u - true_u)))

% plot the solutions and the true solutions in a 2x3 subplot showing 
% numerical aproximation, true solution and the difference

figure;
subplot(2, 3, 1);
surf(T, X, numerical_v1);
title('Numerična aproksimacija za v1');
subplot(2, 3, 2);
surf(T, X, true_v1);
title('Točna rešitev za v1');
subplot(2, 3, 3);
surf(T, X, numerical_v1 - true_v1);
title('Razlika med aproksimacijo in točno rešitivjo za v1');
subplot(2, 3, 4);
surf(T, X, numerical_v2);
title('Numerična aproksimacija za v2');
subplot(2, 3, 5);
surf(T, X, true_v2);
title('Točna rešitev za v2');
subplot(2, 3, 6);
surf(T, X, numerical_v2 - true_v2);
title('Razlika med aproksimacijo in točno rešitivjo za v2');

% plot the solutions and the true solutions in a 1x3 subplot showing
% numerical aproximation, true solution and the difference
figure;
subplot(1, 3, 1);
surf(T, X, numerical_u);
title('Numerična aproksimacija za u');
subplot(1, 3, 2);
surf(T, X, true_u);
title('Točna rešitev u');
subplot(1, 3, 3);
surf(T, X, numerical_u - true_u);
title('Razlika med aproksimacijo in točno rešitivjo za u');


