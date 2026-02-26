% Prva naloga
f = @(x, y) exp(1)^(-x^2 - y^2);
laplacef = @(x, y) (4*x^2 + 4*y^2 - 4)*exp(1)^(-x^2 - y^2);
biharmonicnif = @(x, y) (32 - 64*(x^2 + y^2) + 32*x^2*y^2 + 16*(x^4 + y^4))*exp(1)^(-x^2 - y^2);

lapf = laplacef(0, 0);
bihf = biharmonicnif(0, 0);

k = linspace(0, 5, 1001);
laplaceDiff = zeros(1, 1001);
biharmonicniDiff = zeros(1, 1001);

for i = 1:length(k)
    laplaceDiff(1, i) = abs(lapf - laplaceovOperator(f, 0, 0, k(i)));
    biharmonicniDiff(1, i) = abs(bihf - biharmonicniOperator(f, 0, 0, k(i)));
end

figure('Position', [350 50 1250 900]); plot(laplaceDiff); title('Napaka diskretnega Laplaceovega operatorja')
figure('Position', [350 50 1250 900]); plot(biharmonicniDiff); title('Napaka diskretnega biharmoničnega operatorja')

% Druga naloga
h = 0.05;
k1 = linspace(-1, 1, 41);

lapfgraf = zeros(41, 41);
bihfgraf = zeros(41, 41);

for i = 1:length(k1)
    for j = 1:length(k1)
        lapfgraf(i, j) = laplaceovOperator(f, k1(i), k1(j), h);
        bihfgraf(i, j) = biharmonicniOperator(f, k1(i), k1(j), h);
    end
end

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(lapfgraf, 'FaceAlpha','0.9');
title('Graf Laplaceovega operatorja funkcije f')

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(bihfgraf, 'FaceAlpha','0.9');
title('Graf biharmoničnega operatorja funkcije f')

f1 = @(x, y) (x*sin(y) - y*cos(y))*exp(1)^x;
f2 = @(x, y) sin(y)*exp(1)^x;

lapf1graf = zeros(41, 41);
bihf1graf = zeros(41, 41);
lapf2graf = zeros(41, 41);
bihf2graf = zeros(41, 41);

for i = 1:length(k1)
    for j = 1:length(k1)
        lapf1graf(i, j) = laplaceovOperator(f1, k1(i), k1(j), h);
        bihf1graf(i, j) = biharmonicniOperator(f1, k1(i), k1(j), h);
        lapf2graf(i, j) = laplaceovOperator(f2, k1(i), k1(j), h);
        bihf2graf(i, j) = biharmonicniOperator(f2, k1(i), k1(j), h);
    end
end

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(lapf1graf, 'FaceAlpha','0.9');
title('Graf Laplaceovega operatorja funkcije f1')

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(bihf1graf, 'FaceAlpha','0.9');
title('Graf biharmoničnega operatorja funkcije f1')

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(lapf2graf, 'FaceAlpha','0.9');
title('Graf Laplaceovega operatorja funkcije f2')

figure('Position', [350 50 1250 900]);
colormap winter
lap1 = mesh(bihf2graf, 'FaceAlpha','0.9');
title('Graf biharmoničnega operatorja funkcije f2')