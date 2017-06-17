function [raiz,err,time,f,Xn] = metodo_secante(h,x0,x1,tol)
%Metodo de secante - Elaborado por Michael Vargas
%   Detailed explanation goes here
syms x y z t w;
m = vectorize(h); %Vectorizar funcion
f = matlabFunction(eval(m)); %Crea funcion anonima o handle_function
n=1;
x2=0; 
Xn = zeros(1, 1000);         %Crea el vector de salida X0
err = zeros(1, 1000);
tic;
if (abs(f(x0)) < abs(f(x1)))
    aux=x0;
    x0=x1;
    x1=aux;
end
error = tol + 1;
while(error > tol)
    x2 = x1 - (f(x1) * (x0-x1) / (f(x0) - f(x1)));
    error=abs(f(x2));
    err(n)=error;
    Xn(n) = x1;
    n = n + 1;
    x0 = x1;
    x1 = x2;
end
time = toc;
err = err(1:n-1);
Xn = Xn(1:n-1);
raiz=x2;
end

