function koef = mke1D(p, q, r, alpha, beta, delilne_tocke)

% Funkcija sprejme p, q, r, alpha, beta  in delilne točke 
% iz navadne diferencialne enačbe 
%                    -(p(x)y')' + q(x)y = r(x) 
% pri robnih pogojih 
%                    y(a) = alpha in y(b) = beta, 
% ter vrne vektor (alpha, a1, a2, ..., aJ, beta).


    J = length(delilne_tocke) - 2;
    
    % Oblika matrike A in vektorja b
    A = zeros(J, J);
    b = zeros(J, 1);
    
    % Interval (x_{j - 1}, x_j)
    for j = 2:J+2
        [Aj, fj] = pomozne_strukture_za_interval(j, delilne_tocke, p, q, r);

        % Napolnitev matrike A.
        if (j ~= J+2)
            A(j-1, j-1) = A(j-1, j-1) + Aj(2, 2);  % diagonala
        end

        if (j ~= 2)
            A(j-2, j-2) = A(j-2, j-2) + Aj(1, 1); % diagonala 
        end

        if (j <= J+1) % elementi pod in nad diagonalo
            if (j ~= 2)
                A(j - 1, j - 2) = Aj(2, 1);
                A(j - 2, j - 1) = Aj(2, 1);
            end
        end
    
        % Napolnitev vektorja b.
        if (j == 2)
            b(1) = b(1) - alpha .* Aj(2, 1);
        end

        if (j == J + 2)
            b(J) = b(J) - beta * Aj(2, 1);
        end

        if (j ~= 2)
            b(j - 2) = b(j - 2) + fj(1);
        end

        if (j ~= J + 2)
            b(j - 1) = b(j - 1) + fj(2);
        end
    end

    % Sistem enačb za vektor alpha
    alphas = A\b;

    koef = [alpha, alphas', beta];
end

function [Aj, fj] = pomozne_strukture_za_interval(j, delilne_tocke, p, q, r)

    Aj = zeros(2, 2);
    
    % Definiramo bazne funkcije hj in hj_1
    hj = @(x) odsekoma_linearna(x, delilne_tocke, j);
    hj_1 = @(x) odsekoma_linearna(x, delilne_tocke, j - 1);
    
    % Odvodi hi in hi_1
    hj_1_odvod = -1./(delilne_tocke(j) - delilne_tocke(j-1));
    hj_odvod = 1./(delilne_tocke(j) - delilne_tocke(j-1));
    
    Aj(1, 1) = integral(@(x) p(x) .* hj_1_odvod.^2 + q(x) .* hj_1(x).^2, delilne_tocke(j - 1), delilne_tocke(j));
    Aj(2, 2) = integral(@(x) p(x) .* hj_odvod.^2 + q(x) .* hj(x).^2, delilne_tocke(j - 1), delilne_tocke(j));
    Aj(2, 1) = integral(@(x) p(x) .* hj_1_odvod .* hj_odvod + q(x) .* hj_1(x) .* hj(x), delilne_tocke(j - 1), delilne_tocke(j));

    fj = zeros(2, 1);
    fj(1) = integral(@(x) r(x) .* hj_1(x), delilne_tocke(j - 1), delilne_tocke(j));
    fj(2) = integral(@(x) r(x) .* hj(x), delilne_tocke(j - 1), delilne_tocke(j), ArrayValued=true);

end