% skripta, ki nariše graf rešitve pri fiksnem dela_T in spreminjajočem se
% delta_x
figure
J_list = 40:2:110;
num = length(J_list);
razlike = zeros(1,num);

for k = 1 : num
    J = J_list(k);
    [T, X, u, max_razlika] = spremeniX(J);
    razlike(k) = max_razlika;
    surf(T, X, u);
    hold on
    xlabel('t');
    ylabel('x');
    zlabel('u');
    title('Graf rešitve pri fiksnem N in variabilnem J');
    pause(0.5)
end

% narišemo graf max_razlike v odvisnosti od J
figure
plot(J_list, razlike)
xlabel('J');
ylabel('razlike');
title('Graf aboslutnih vrednosti razlik pri spreminjajoči vrednosti spr. J');