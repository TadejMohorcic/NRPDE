function [U,kor] = jacobiKonvolucija(U,F,tx,ty,delta,koraki,tol)

A = [0 ty 0; tx 0 tx; 0 ty 0];

U_prev = U;
kor = 1;
razlika = inf;

while kor < koraki && razlika > tol
    U_notr = conv2(U_prev,A,"same");
    U(2:(end-1),2:(end-1)) = U_notr(2:(end-1),2:(end-1)) + delta*F(2:(end-1),2:(end-1));
    kor = kor + 1;
    razlika = max(max(abs(U_prev - U)));
    U_prev = U;
end