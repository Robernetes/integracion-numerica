
%FUNCION PARA EL METODO DEL TRAPECIO
%ESTA FUNCION RETORNA UNA TABLA CON LOS VALORES DE X Y F(X)
%RESTORNA EL RESULTADO, LA SOLUCION REAL Y EL ERROR RELATIVO

function [I,sr,er,Tab] = funTrapecio(ft,a,b,n)

clc;
% clear;
syms x;
disp('Integracion Numerica - Metodo del trapecio');
% ft = input('\nIngrese la funcion f(x): ');
% a = input('\nIngrese el limite inferior: ');
% b = input('\nIngrese el limite superior: ');
% n = input('\nIngresa la cantidad de intervalos: ');


f = char(ft); %SE CONVIERTE LA FUNCION INGRESADA EN TEXTO
fn = matlabFunction(ft); %FUNCION HANDLE PARA CALCULAR LA SOLUCION REAL 
sr = integral(fn,a,b); %sr ES LA SOLUCION REAL


f1=inline(f); %FUNCION HANDLE

h=(b-a)/n; %SE CALCULA el valor de h
fx = zeros(n+1,1); %VECTOR PARA LOS VALORES EVALUADOS
x1 = zeros(n+1,1); %VECTOR PARA LOS VALORES DE X

s = 0; %VARIABLE PARA GUARDAR TEMPORALMENTE VALORES
s1 = 0; %ACUMULADOR PARA LA SUMA TOTAL
j = 1; %INDICE DE LOS VECTORES

%CICLO FOR QUE VA DESDE a CON PASO DE h HASTA b
for i=a:h:b
    if i == a % SI i ES IGUAL a SE GUARDA DIRECTAMENTE EL VALOR
        s = (f1(i)); % s RECIBE EL VALOR EVALUADO DE i
        [x1(j),fx(j)]=deal(i,s); %MULTIPLE ASIGNACION: i SE GUADA EN VECTOR x1 Y S EN VECTOR fx 
        s1 = s1 + s; %s1 ACUMULA EL VALOR DE s
    elseif i > 1 && i < b
        s = 2*f1(i); % sRECIBE EL VALOR EVALUADO DE i Y MULTIPLICADO POR 2 
        [x1(j),fx(j)]=deal(i,s); %MULTIPLE ASIGANACION
        s1 = s1 +s; %s1 ACUMULA EL VALOR DE s
    elseif i == b
        s = f1(i);
        [x1(j),fx(j)]=deal(i,s); %MULTIPLE ASIGANACION
        s1 = s1 +s; %s1 ACUMULA EL VALOR DE s
    end
    j = j + 1; % j AUMENTA 1 EN CADA ITERACION
end

I = (h/2)*s1; %MULTIPLICACION DE LA SUMA POR EL RESULTADO DE h ENTRE 2
fprintf('\nI: %2.5f\n',I);
er = abs(((sr-I)/sr))*100; %SE CACLULA EL ERROR RELATIVO 
fprintf('Solucion real: %f\n',sr);
fprintf('Er: %2.5f%% \n',er);

%x1(x1==0)=[];
%fx(fx==0)=[];
Tab = table(x1,fx); % SE CONVIERTE EN TABLA LOS VECTORES x1 Y fx 
disp(Tab);

end