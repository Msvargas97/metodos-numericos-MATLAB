function [raiz,err,time,f,An,Bn,Cn] = metodo_biseccion(h,a,b,tol)
syms x y z t w;
m = vectorize(h); %Vectorizar funcion
f = matlabFunction(eval(m)); %Crea funcion anonima o handle_function
c=0;n=1; 
error=tol+1;
err = zeros(1, 1000);
An = zeros(1, 1000);
Bn = zeros(1, 1000);
Cn = zeros(1, 1000);
tic;
while(error>tol)
   c = (a+b)/2;
   error = abs(f(c));
   err(n) = error;
   An(n) = a;
   Bn(n) = b;
   Cn(n) = c;
   if(f(a)*f(c) < 0)
       b = c;
   else
       a = c;
   end
   n = n+1; 
end
time = toc;
raiz = c;
err = err(1:n-1);
An = An(1:n-1);
Bn = Bn(1:n-1);
Cn = Cn(1:n-1);
end