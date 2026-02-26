function [U,F,tx,ty,delta,X,Y] = pripraviSistem(a,b,c,d,J,K,f,g_n, g_e, g_s, g_w)
% Funkcija pripraviSistem je namenjena reševanju parcialne diferencialne
% enačbe oblike -laplace u = f, na pravokotniku [a,b]×[c,d]

%VHODNI PODATKI:
% - točke a, b, c in d določajo pravokotnik, na katerem rešujemo dani
% problem
% - J in K sta števili notranjih delilnih točk v x oz.  y smeri
% - f je funkcija dveh spremenljivk, ki nastopa na desni strani enačbe
% - g_n, g_e, g_s in g_w so funkcije, s katerimi je  določena rešitev U na
% zgornji (north), levi (east), spodnji (south) in pa desni (west) stranici
% pravokotnika [a,b]×[c,d]

% IZHODNI PODATKI
% - začetni približek U,
% - matrika F vrednosti funkcije f, izračunane na mreži
% - theta_x (tx), theta_y (ty) in delta^2 (delta)
% - matriki X in Y, to sta matriki x in y koordinat točk na mreži

% Izhodne podatke funkcije pripraviSistem nato vstavimo v kakšno od
% iterativnih metod, da dobimo numerično rešitev parcialne diferencialne
% enačbe.

% Izračunamo koraka v x in y smereh
dx = (b-a)/(J+1);
dy = (d-c)/(K+1);

% Izračunamo theta_x in theta_y ter delto na kvadrat
delta = (dx*dy)^2/(2*(dx^2 + dy^2));
tx = delta/dx^2;
ty = delta/dy^2;

% Vektorja delilnih točk v x in y smeri
x = a:dx:b;
y = c:dy:d;

[X,Y] = meshgrid(x,y);

% Matrika izračunanih vrednosti funkcije f in začetnega približka U
F = zeros(K+2,J+2);
U = zeros(K+2,J+2);

for i = 1:(J+2)
    for j = 1:(K+2)
        F(j,i) = f(x(i),y(j));
    end
    U(1,i) = g_s(x(i), y(1));
    U(K+2,i) = g_n(x(i),y(K+2));
end

for j = 1:(K+2)
    U(j, 1) = g_w(x(1), y(j));
    U(j, J+2) = g_e(x(J+2), y(j));
end

end