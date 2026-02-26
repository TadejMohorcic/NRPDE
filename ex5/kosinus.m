p = @(x) -1 + 0.*x;
q = @(x) 1 + 0.*x;
r = @(x) 0.*x;
a = 0;
b = 2*pi;
alpha = 1;
beta = 1;
%J = [9 19 29 39 49];
J = 9:100;

cmap = [ones(size(J,2), 1), linspace(0.9, 0, size(J,2))',  linspace(0.8, 0, size(J,2))'];
napake = zeros(1,size(J,2));
f=@(x)cos(x);
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
    napake(k)= norm(y -arrayfun(f,x),1);
    plot(x,y, 'Color', cmap(k, :), 'LineWidth', 1)
end

fplot(f,[a,b],'Color','b', 'LineWidth', 1)
hold off

%plot(J,napake)
