%% Ejercicio 5
% 
% Realice la la convoluci�n de las se�ales (c) con (d) del problema 3.1.1 
% utilizando el comando conv de MATLAB, muestre el c�digo utilizado y gr�fique el resultado
% sugerencia: Utilice las propiedades de traslaci�n de la convoluci�n.
%%
% Definimos el primer vector
C=[0 -9 -6 -3 0 3 6 9 0 0 0];
n=-4:6;
stem(n,C)
axis([-4 4 -10 10])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.Box = 'off';
title('Grafica C')
xlabel('n')
ylabel('x[n]')
%%
% Defnimos el segundo vector
D=[0 0 4 2 0 2 4 0 0 0 0 ];
stem(n,D)
axis([-4 4 -2 5])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.Box = 'off';
title('Grafica D')
xlabel('n')
ylabel('x[n]')
%%
%
% Haciendo la Convoluci�n 
X=-7:13;
R=conv(C,D)
%% Grafica de La convoluci�n
%
stem(X,R)
axis([-8 14 -37 37])
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.Box = 'off';
title('Convoluci�n de la grafica C con D')
xlabel('n')
ylabel('x[n]')
