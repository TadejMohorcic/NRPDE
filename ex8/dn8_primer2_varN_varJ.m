% skripta, kjer računamo, kako se spreminja kvaliteta rešitve u, ko
% manjšamo delta_t in delta_x, pri čemer njuno razmerje ostaja konstantno

% N in J oz. delta_t/delta_x sta v razmerju J+1/N = 1, če je J = N-1
N_list = 10:10:120; 
J_list = 9:10:120;
num = length(N_list);

razlike_v1 = zeros(1,num);
razlike_v2 = zeros(1,num);
razlike_u = zeros(1,num);

for i = 1:num
    N = N_list(i);
    J = J_list(i); 
    
    [max_diff_v1, max_diff_v2, max_diff_u] = spremeni_N_J(N,J);
    razlike_v1(i) = max_diff_v1;
    razlike_v2(i) = max_diff_v2;
    razlike_u(i) = max_diff_u;

end

% maksimalne aboslutne vrednosti razlik v odivsnosti od manjšanja razmika
razlike_v1
razlike_v2
razlike_u

figure
plot(N_list, razlike_u)
xlabel('N');
ylabel('razlike u');
title('Graf max(abs(u-utocna)) v odvisnosti od spremembe N in J')