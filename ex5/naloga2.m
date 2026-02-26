p = @(x) 1 + x.^2;
q = @(x) x.^2;
r = @(x) -1;
a = 0;
b = 1;
alpha = 0;
beta = 0; 
J = linspace(9,49,5);

cmap = [ones(size(J,2), 1), linspace(0.9, 0, size(J,2))',  linspace(0.8, 0, size(J,2))'];
hold on

for k = 1:size(J,2)
    delilne_tocke = linspace(a,b,J(k)+2);

    koeficienti = mke1D(p, q, r, alpha, beta, delilne_tocke);

    % izris aproksimacije

    x = linspace(a,b, J(k)+2);
    y = zeros(1,J(k)+2);
    for j = 1:size(y,2)
       for i = 1:J(k)+2
        y(j) = y(j) + koeficienti(i).*odsekoma_linearna(x(j), delilne_tocke, i);
       end
    end

    plot(x,y, 'Color', cmap(k, :), 'LineWidth', 1)
end


% Resitev po diferencni metodi za J = 100

[x,y] = resiRobniProblem1D(p,q,r,a,b,100,0,0);
plot(x, y, 'Color', 'b', 'LineWidth', 1)

hold off
