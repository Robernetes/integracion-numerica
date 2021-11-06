

function [x1,fx,I] = funSimpson38(ft,a,b,n)
% clc;
syms x;
disp('Integracion Numerica - Metodo de Simpson 3/8');
disp(' ');
% f = input('\nIngrese la funcion f(x): ','s');
% a = input('\nIngrese el limite inferior: ');
% b = input('\nIngrese el limite superior: ');
% n = input('\nIngresa la cantidad de intervalos: ');

% f = '3*x^2';
% a = 1;
% b = 4;
% n = 4;

f = char(ft); %SE CONVIERTE LA FUNCION INGRESADA EN TEXTO
fn = matlabFunction(ft); %FUNCION HANDLE PARA CALCULAR LA SOLUCION REAL 
sr = integral(fn,a,b); %sr ES LA SOLUCION REAL

f1 = inline(f);
h = (b-a)/n;
x1 = zeros(n+1,1);


cumx1 = 0;
cumpar = 0;
cumimpar = 0;
%cumtotal = 0;

contpar = 0;
contimpar = 0;


for i=0:n
    if mod(i,3) == 0 && i > 0 && i < n
       contpar = contpar +1; 
    elseif mod(i,3) ~= 0 && i > 0 && i < n
        contimpar = contimpar +1;
    end
end
cant = (contpar/contpar) + (contimpar/contimpar) + 2;

fx = zeros(cant,1);
cont1 = 0;
cont2 = 0;

j=1;
for i=0:n
    cumx1 = a;
    %disp(cumx1);
    x1(j) = cumx1;
    if i < 1
        fx(j) = f1(cumx1);
    end
    %cumtotal = f1(cumx1);
    if mod(i,3) == 0 && i > 0 && i < n %SI INDICE ES MULTIPLO DE 3 Y MAYOR QUE CERO Y MENOR QUE N
        cont1 = cont1 +1;
        %sub indices pares

        cumx1 = x1(j-1) + h;
        x1(j) = cumx1;
        %fx(j) = f1(cumx1);
        cumpar = cumpar + f1(cumx1);
        if cont1 == contpar
            multpar = 2*cumpar;
            fx(j) = multpar;
        end
    elseif mod(i,3) ~= 0 %SI NO SON MULTIPLOS DE 3 
        cont2 = cont2 + 1;
        %sub indices impares
        cumx1 = x1(j-1) + h;
        x1(j) = cumx1;
        %fx(j) = f1(cumx1);
        cumimpar = cumimpar + f1(cumx1);
        if cont2 == contimpar
            multimpar = 3*cumimpar;
            fx(j) = multimpar;
        end
        
    end
    if i == n
        cumx1 = x1(j-1) + h;
        x1(j) = cumx1;
        fx(j) = f1(cumx1);
    end
    j=j+1;
end
fx(fx==0)=[];

I = sum(fx) * ((3*h)/8);
er = (sr-I)/sr;
fprintf('I: %2.5f\n',I );
fprintf('Solucion real: %2.5f\n',sr );
fprintf('Er: %2.5f\n',er );
format bank
x1
fx


end
