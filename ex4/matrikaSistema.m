function A = matrikaSistema(a,b,c,d,J,K)

% Funkcija matrikaSistema kot vhodne podatke prejme oglišča pravokotnika in
% pa število notranjih delilnih točk v x oz. y smeri, kot izhodni podatek
% pa vrne matriko sistema A.


deltax = (b-a)/(J+1);
deltay = (d-c)/(K+1);

delta_kvadrat = (deltax^2*deltay^2)/(2*(deltax^2 + deltay^2));
thetax = delta_kvadrat/deltax^2;
thetay = delta_kvadrat/deltay^2;

diag = ones(J*K,1);
poddiag1 = [-thetax*ones(J*K-1,1);0];
naddiag1 = [0;-thetax*ones(J*K-1,1)];
if J > 1
    poddiag1(J:J:end) = 0;
    naddiag1(J+1:J:end) = 0;
end

poddiag2 = [-thetay*ones(J*K-J,1);zeros(J,1)];
naddiag2 = [zeros(J,1);-thetay*ones(J*K-J,1)];

if J > 1
    A = spdiags([poddiag2,poddiag1,diag,naddiag1,naddiag2],[-J,-1,0,1,J],J*K,J*K);
else
    A = spdiags([poddiag2,diag,naddiag2],[-1,0,1],J*K,J*K);
end

end