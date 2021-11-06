

clc;
clear;
syms x;

ft = input('\nIngrese la funcion f(x): ');
a = input('\nIngrese el limite inferior: ');
b = input('\nIngrese el limite superior: ');
n = input('\nIngresa la cantidad de intervalos: ');



funTrapecio(ft,a,b,n);

funSimpson13(ft,a,b,n);

funSimpson38(ft,a,b,n);


