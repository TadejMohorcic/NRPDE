% testna skripta za prvi primer
c = @(t, x) sin(t); % funckija, ki nastopa v PDE
f = @(x) exp(-x.^2); % funkcija, ki določa začetni pogoj
g = @(t) exp(-(-2-(1-cos(t))).^2); % prvi robni pogoj pri a = -2
h = @(t) exp(-(4-(1-cos(t))).^2); % drugi robni pogoj pri a = 4

T = 2 * pi;
a = -2;
b = 4;

% določimo N in J tako, da sta delta_t in delta_x blizu 0.1
N = 63;
J = 59;

[T, X, u] = resiPoVetru(c, f, g, h, T, a, b, N, J);
true_u_fun = @(t, x) exp(-(x-(1-cos(t))).^2);
true_u = true_u_fun(T, X);

% narišemo graf diskretne rešitve
figure;
surf(T, X, u);
xlabel('t');
ylabel('x');
zlabel('u');
title('Graf rešitve za advekcijsko enačbo pri N = 63 in J = 59');

% narišemo graf razlik
figure;
surf(T, X, u - true_u);
xlabel('t');
ylabel('x');
zlabel('u');
title('Graf predznačene razlike med diskretno in pravo rešitvijo');

razlika = abs(u - true_u);
max_razlika = max(razlika(:))
[r, c] = find(ismember(razlika, max(razlika(:))))
