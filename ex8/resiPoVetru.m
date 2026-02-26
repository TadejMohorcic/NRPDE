function [T, X, u] = resiPoVetru(c, f, g, h, T, a, b, N, J)
% metoda resiPoVetru izvede premo diferenco v časovni smeri (določeni z razmikom \delta t) 
% in obratno ali premo diferenco v prostorski smeri (določeni z razmikom \delta x)
% vhodni podatki c, f, g, h določajo enačbo z začetnimi in robnimi pogoji
% vhodni podatki T, a, b, N, J pa določajo obomočje in njegovo
% diskretizacijo
% N+1 je število točk delitve časovnega intervala (0,T]
% J je število notranjih točk delitve prostorskega intervala (a,b), skupaj
% z robnima točkama jih je J+2
% kot rezultat metoda vrne trojico [T, X, u]
% u predstavlja diskretizacijo rešitev, T in X pa predstavljata mrežo,
% potrebno za vizualizacijo rešitve

    delta_t = T / N; % razmik v časovni smeri
    delta_x = (b-a) / (J+1); % razmik v prostorski smeri
    
    x_space = linspace(a, b, J + 2); % določimo delitev prostorske spremenljivke
    t_space = linspace(0, T, N + 1); % določimo delitev časovne spremenljivke

    [T, X] = meshgrid(t_space, x_space);
    u = zeros(J+2, N+1); % inicializiramo matriko ustrezne velikosti, kamor shranjujemo vrednosti funkcije u, ki je rešitev dane PDE
    u(:, 1) = f(x_space);

    % če je c funkcija, rešujemo enačbo po vetru z uporabo robnih pogojev
    % na obeh straneh, sicer (če je c konstanta) rešujemo advekcijsko 
    % enačbo z robnim pogojem na eni strani (odvisno od predznaka c)
    if isa(c, 'function_handle')
        lambda_vals = c(T, X) * delta_t / delta_x; % vnaprej izračunamo Courantovo število pri danem n in j ter rezultate shranimo v matriko 
    
        u(1, :) = g(t_space);
        u(end, :) = h(t_space);
    
        % iteriramo po časovni spremenvljiki - smo na n-tem časovnem nivoju
        for n = 1:N
            % iteriramo po prostorski spremenljivki
            for j = 2:J+1
                % use different formula depending on the sign of lambda
                if lambda_vals(j, n) > 0 % ustreza primeru, ko je c_j^n >= 0   
                    u(j, n+1) = lambda_vals(j, n) * u(j-1, n) + (1 - lambda_vals(j, n)) * u(j, n);
                else
                    u(j, n+1) = (1 + lambda_vals(j, n)) * u(j, n) - lambda_vals(j, n) * u(j+1, n);
                end
            end
        end
    % primer, ko je c pozitivna konstanta
    elseif c > 0
        lambda = c * delta_t / delta_x;
        u(1, :) = g(t_space);
        for n = 1:N
            for j = 2:J+2
                u(j, n+1) = (1 - lambda) * u(j, n) + lambda * u(j-1, n);
            end
        end
    % primer, ko je c < 0 
    else
        lambda = c * delta_t / delta_x;
        u(end, :) = h(t_space);
        for n = 1:N
            for j = 1:J+1
                u(j, n+1) = (1 + lambda) * u(j, n) - lambda * u(j+1, n);
            end
        end
    end

end