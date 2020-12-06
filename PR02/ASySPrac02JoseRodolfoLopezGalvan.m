%% Práctica 2

%% Ejercicio 1
% 3.11-2 Consider the discrete-time function
% $$f[n] = e-n/5 cos(\pi*n/5)u[n]$$
%
% Section 3.11 uses anonymous
% functions in describing DT signals.
%
% f = @(n) exp(-n/5).*cos(\pi*n/5).*(n>=0);
%
% While this anonymous function operates correctly
% for a downsampling operation such as
% f[2n], it does not operate correctly for an
% upsampling operation, such as f[n/2]. Modify
% the anonymous function f so that it also
% correctly accommodates upsampling operations.
% Test your code by computing and plotting
% f(n/2) over (?10 ? n ? 10).
%%
% *Procedimiento*
%
%
% Creamos la función y vector de n
%
%%

f = @(n) exp(-n/5).*cos(pi*n/5).*(n>=0);

n=-10:1:10;

%%
% Modificamos la función 


f1 = @(n) exp(-n/5).*cos(pi*n/5).*(n>=0).*(1./(mod(n,1)==0));

stem(n,f1(n));

title('Gráfica de la señal f[n]=e^(-n/5)*cos(pin/5)u[n]');

xlabel('n');

ylabel('f[n]');

axis([-11 11 -0.5 1.2]);
grid on;

gca.XAxisLocation = 'origin';
gca.YAxisLocation = 'origin';

gca.Box = 'off';

%%
% Escalando f[n] en 1/2

stem(n,f1(n/2));

title('Gráfica de la señal f[n/2]');

xlabel('n');
ylabel('f[n/2]');

axis([-11 11 -0.5 1.2]);

grid on;

gca.XAxisLocation = 'origin';

gca.YAxisLocation = 'origin';

gca.Box = 'off';

%% Ejercicio 4
% 
% 3.11-6 Suppose a vector x exists in the MATLAB
% workspace, corresponding to a finite-duration
% DT signal x[n]
% (a) Write a MATLAB function that, when
% passed vector x, computes and returns Ex,
% the energy of x[n].
% (b) Write a MATLAB function that, when
% passed vector x, computes and returns Px,
% the power of x[n]. Assume that x[n] is
% periodic and that vector x contains data for
% an integer number of periods of x[n].
%%
% *Procedimiento*
% A) Energia



%%
%   x=input('Ingrese la función en sintaxis MATLAB:');
%   n=input('Ingrese el vector:');
%   E=0;
%   for n=n
%       sum=x(n)^2;
%       E=E+sum;
%   end
%   fprintf('La energia es:%d',E);
%
% B) Potencia

%%
%   y=input('Ingrese la función en sintaxis MATLAB:');
%   N=input('Ingrese el periodo:');
%   P=0;
%   for n=0:N-1
%       sum=(1/N)*y(n)^2;
%       P=P+sum;
%   end
%   fprintf('La Potencia es:%d',P);
% 
