function [fig] = plotCustom(f,raiz,a,b)
%plotCustom - Elaborado por Michael Vargas
%   Crea una grafica con ezplot y la raiz de la funcion ingresa
%   f = funcion_handle
%   raiz = punto donde la funcion evaluada vale 0
%   a,b = son los intervalos para graficar, si a y b valen 0, se toma por
%   defecto -2*pi a 2*pi
%   
%   return: fig, retorna la figura creada
if isa(f,'function_handle')
    if(a ~= 0 || b~=0)
    fig = ezplot(f,[a b]);
    else
    fig = ezplot(f);
    end
    hold on;
    fig.LineWidth = 2;
    grid on
    grid minor
    title('')
    datacursormode on
    hold on
    plot(raiz,subs(f,raiz),'or','LineWidth',2);
    %zoom on;
    str = func2str(f);
    str = str(5:length(str));
    legend(str,'Raiz');
    text(raiz,f(raiz),strcat('\leftarrow',num2str(raiz)),'Color','black','FontSize',14)
else
    msg = 'funcion invalida, debe ser de tipo function_handle';
    error(msg)
end
end


