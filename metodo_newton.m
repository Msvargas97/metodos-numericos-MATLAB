function [raiz,err,time,f,df,Xn] = metodo_newton( h,x0,tol )
%Metodo de newton - Elaborado por Michael Vargas
%   Calcular la raiz de h = (600*x.^4)-(550*x.^3)+(200*x.^2)-(20*x)-1
%   x0 = 0.1 Valor inicial
%   tol = 0.0001 tolerancia
%   Raiz = 0.23
if nargin == 0 %Ejecuta el ejemplo
    help metodo_newton
    disp('Presione cualquier tecla para continuar con el ejemplo')
    pause
    [raiz,err,time,~,~,~] = metodo_newton('(600*x^4)-(550*x^3)+(200*x^2)-(20*x)-1',0.1,0.0001);
    return
end
syms x y z t w;              %Variables symbolic
m = vectorize(char(h));      %Vuelve la funcion symbolic y vectoriza la funcion
f = matlabFunction(eval(m)); %Crea una function_handle
derivada = diff(eval(m));    %Obtiene la derivada
df=matlabFunction(derivada); %Convierte la derivada en una function_handle
n=1;                         %Inicializa el numero de iteraciones
Xn= zeros(1, 1000);         %Crea el vector de salida X0
err = zeros(1, 1000);        %Crea el vector de salida error
time = 0;                    %Inicializa el tiempo de convergencia
error = tol + 1;             %Inicializa el error para poder entrar al bucle
tic;                         %Inicia el timer
if(f(x0) ~= 0 && df(x0) ~= 0)%Verifica que el metodo converge    
    while(error > tol && n < 1000) %Ejecuta el metodo de Newton Raphson              
        x0 = x0 -  f(x0) / df(x0);
        Xn(n) = x0;
        error = abs(f(x0));
        err(n) = error;
        n = n+1;
    end
    time = toc;
    Xn = Xn(1:n-1); %Elimina el resto del espacio del vector que no se uso y lo convierte a vector fila
    err = err(1:n-1);
    if(n < 1000)
        raiz = x0;
    else
        raiz = 'El metodo no converge';
    end 
else
    raiz = 'El metodo no converge';
end

end

