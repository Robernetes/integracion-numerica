


function [x1, fx, I] = funSimpson13(ft,a,b,n)


% clc;
% clear;
syms x;
disp('Integracion Numerica - Metodo de Simpson 1/3');
disp(' ');
% f = input('\nIngrese la funcion f(x): ','s');
% a = input('\nIngrese el limite inferior: ');
% b = input('\nIngrese el limite superior: ');
% n = input('\nIngresa la cantidad de intervalos: ');


f = char(ft); %SE CONVIERTE LA FUNCION INGRESADA EN TEXTO
fn = matlabFunction(ft); %FUNCION HANDLE PARA CALCULAR LA SOLUCION REAL 
sr = integral(fn,a,b); %sr ES LA SOLUCION REAL

f1 = inline(f); %FUNCION
h = (b-a)/n;    % h
x1 = zeros(n+1,1); %VECTOR PARA ALMACENAR LOS VALORES DE X


cumx1 = 0; %ATRAPA LOS VALORES DE X
cumpar = 0; %ACUMULA LOS VALORES DE LAS FUNCIONES PAR
cumimpar = 0; %ACUMULA LOS VALORES DE LAS FUNCIONES IMPAR
cumtotal = 0; 

contpar = 0; %ALMACENA LA CANTIDAD DE VALORES PAR 
contimpar = 0; %ALMACENA LA CANTIDAD DE VALORES IMPAR

%CICLO PARA CONTAR LOS VALORES PAR E IMPAR
for i=0:n
    if mod(i,2) == 0 && i > 0 && i < n
       contpar = contpar +1; 
    elseif mod(i,2) ~= 0
        contimpar = contimpar +1;
    end
end

%cant DEFINE LA CANTIDAD DE FILAS PARA EL ARRAY fx
cant = (contpar/contpar) + (contimpar/contimpar) + 2;

fx = zeros(cant,1); %fx VECTOR PARA LOS VALORES DE fx
cont1 = 0; %CONTADOR IMPAR PARA COMPARAR CON EL ANTERIOR CONTADOR IMPAR
cont2 = 0; %CONTADOR PAR PARA COMPARAR CON EL ANTERIOR CONTADOR PAR

multpar =0; %ACUMULA LOS VALORES PAR YA SUMADOS Y MULTIPLICADOS POR 2
multimpar = 0; %ACUMULA LOS VALORES IMPAR YA SUMADOS Y MULTIPLICADOS POR 4 

j=1; %INDICE PARA LOS VECTORES QUE COMIENZZA EN 1

%CICLO FOR PARA LOS CALCULOS 
for i=0:n
    cumx1 = a; %SE ASIGNA EL VALOR DE a EN cumx1
    x1(j) = cumx1; %SE GUARDA EL VALOR cumx1 EN EL VECTOR X1
    if i < 1 % SI EL INDICE ES MENOR QUE 1
        fx(j) = f1(cumx1); %SE GUARDA LA FUNCION EVALUADA EN EL VECTOR FX
    end
    %cumtotal = f1(cumx1);
    if mod(i,2) == 0 && i > 0 && i < n %SI INDICE DIVIDIDO ENTRE 2 ES IGUAL A 0 Y EL INDICE ES MAYOR QUE 1 Y MENOS QUE N
        cont1 = cont1 +1; %CONTADOR AUMENTA EN 1
        %sub indices pares

        cumx1 = x1(j-1) + h; %SE ASIGNA EL VALOR DE X A cumx1 
        x1(j) = cumx1; %SE GUARDA EL VALOR DE cumx1 EN EL VCTOR X1 
        %fx(j) = f1(cumx1);
        cumpar = cumpar + f1(cumx1); %ACUMULA LAS SUMAS DE LAS FUNCIONES EVALUADAS
        if cont1 == contpar %SI CONTADOR PAR DEL PRIMER FOR ES IGUAL AL CONTADOR DE ESTE FOR, ENTONCES YA SUMO EL ULTIMO VALOR
            multpar = 2*cumpar; % SE MULTIPLICA LA SUMA POR 2
            fx(j) = multpar; %SE AGREGA EL VALOR MULTIPLICADO AL VECTOR FX 
        end
    elseif mod(i,2) ~= 0   %SI EL INDICE DIVIDIDO ENTRE 2 ES DIFERENTE DE CERO 
        cont2 = cont2 + 1; %CONTADOR AUMENTA EN 1
        %sub indices impares
        cumx1 = x1(j-1) + h; %SE ASIGNA EL VALOR DE X A cumx1 
        x1(j) = cumx1; % EL VALOR DE cumx1 SE GUARDA EN EL VECTOR X1 
        %fx(j) = f1(cumx1);
        cumimpar = cumimpar + f1(cumx1); %SE ACUMULA LA SUMA DE LAS FUNCIONES EVALUADAS IMPARES
        if cont2 == contimpar %SI EL CONTADOR IMPAR DEL PRIMER FOR ES IGUAL A ESTE CONTADOR IMPAR 
            multimpar = 4*cumimpar; %ENTONCES YA LA SUMA SE HA COMPLETADO Y SE MULTIPLICA POR 4 
            fx(j) = multimpar; %EL VALOR MULTIPLICADO SE GUARDA EN EL VECTOR FX
        end
        
    end
    if i == n % SI INDICE ES IGUAL A N
        cumx1 = x1(j-1) + h; % SE GUARDA EL VALOR DE X QUE SERIA b
        x1(j) = cumx1; %EL VALOR SE GUARDA EN EL VECTOR X1
        fx(j) = f1(cumx1); %SE GUARDA EL VALOR DE b EVALUDADO EN LA FUNCION EN EL VECTOR FX
    end
    j=j+1; %AUTMENTA EN 1 EL INDICE DE LOS VECTORES
end

fx(fx==0)=[]; %ELIMINA LOS VALORES EN CERO DEL VECTOR FX

format long
I = sum(fx) * (h/3); %RESULTADO
er = (sr-I)/sr;
fprintf('I: %2.5f\n',I );
fprintf('Solucion real: %2.5f\n',sr );
fprintf('Er: %2.5f\n',er );
format bank
x1 %VECTOR RESUTANTE DE X1 
fx %VECTOR RESULTANTE DE FX 
end