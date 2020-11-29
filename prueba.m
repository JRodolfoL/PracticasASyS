%% Práctica 1: Señales en tiempo continuo.
%
% *Integrantes:*
%
% * Arellano Paz Angel Ulises
% * Cardoso Arias Javier
% * Gachuz Hernández Karla Denisse
% * García Arteaga Alejandro
% * López Galván José Rodolfo
%
% *Objetivos:* 
%
% * Manipulación básica de MATLAB
% * Gráficas de señales reales y complejas continuas
% * Transformación de señales continuas (escalamientos y traslaciones)
% * Calculo de energía y potencia de señales continuas

%%


%% Introducción
% El inciso 4 resuelto con Python puede ser consultado en el siguiente <https://colab.research.google.com/drive/11nxr8kWdsPiXhoxsBBT6P-TnolIQIWv1?usp=sharing *enlace*>.


%%  1) Working with functions.
%
% Working with functions is fundamental to signals and systems applications. MATLAB provides several methods of defining and evaluating functions. An understanding and proficient use of these methods are therefore necessary and beneficial.

%%
% *11.1-1 Anonymous functions.*
%
% Many simple functions are most conveniently represented by using MATLAB anonymous functions. An anonymous function provides a symbolic representation of a function defined in terms of MATLAB operators, functions, or other anonymous functions. For example, consider defining the exponentially damped sinusoid $f (t) = e −t cos(2π t)$.

f = @(t) exp(-t).*cos(2*pi*t);

%%
% In this context, the @ symbol identifies the expression as an anonymous function, which is assigned a name of f. Parentheses following the @ symbol are used to identify the function’s independent variables (input arguments), which in this case is the single time variable t. Input arguments, such as t, are local to the anonymous function and are not related to any workspace variables with the same names.
%
% Once defined, $f (t)$ can be evaluated simply by passing the input values of interest. For example,

t =0; f(t)

%%
% evaluates $f (t)$ at t = 0, confirming the expected result of unity. The same result is obtained by passing t = 0 directly.

%%
% Vector inputs allow the evaluation of multiple values simultaneously, Consider the task of plotting $f(t)$ over the interval $(-2 \leq t \leq 2)$. Gross function behavior is clear:  $f(t)$ should oscilate four times with a decaying envelope. Since accurate hand sketches are cumberstone, MATLAB-generated plots are an attractive alternative. As the following example illustrates, care must be taken to ensure reliable results.
%
% Suppose the vector t is chosen to include onlu the integers contained in $(-2 \leq t \leq 2)$, namely, [−2, −1, 0, 1, 2].

t = (-2:2);

%%
% This vector input is evaluated from a vector output.

f(t)

%%
% The plot command graphs the result, which is shown in Fig. 1.46 

%%
%
%  >> plot(t,f(t));
%  >> xlabel(’t’); ylabel(’f(t)’); grid;
%

%%
% Grid lines, added by using the grid command, aid feature identification. Unfortunately, the
% plot does not illustrate the expected oscillatory behavior. More points are required to adequately
% represent f (t).
% The question, then, is how many points is enough? † If too few points are chosen, information
% is lost. If too many points are chosen, memory and time are wasted. A balance is needed. For
% oscillatory functions, plotting 20 to 200 points per oscillation is normally adequate. For the present
% case, t is chosen to give 100 points per oscillation.

plot(t, f(t));
xlabel('t');
ylabel('f(t)');
grid;
%%
% *Figure 1.46* $f(t) = e^{-t}cos(2\pi t)$ for $t = (-2::2)$.

t1 = (-2:0.01:2);
plot(t1, f(t1));
xlabel('t');
ylabel('f(t)');
grid;
%%
% *Figure 1.47* $f(t) = e^{-t}cos(2\pi t)$ for $t = (-2:0.01:2)$.

%%
% *1.11-2 Relational Operators and the Unit Step Function.*
%
% The unit step function $u(t)$ arises naturally in many practical situations. For example, a unit step can
% model the act of turning on a system. With the help of relational operators, anonymous functions
% can represent the unit step function.
% In MATLAB, a relational operator compares two items. If the comparison is true, a logical true
% (1) is returned. If the comparison is false, a logical false (0) is returned. Sometimes called indicator
% functions, relational operators indicates whether a condition is true. Six relational operators are
% available: <, >, <=, >=, ==, and ~=.
%   The unit step function is readily defined using the >= relational operator.

u = @(t) 1.0.*(t>=0);

%%
% Any function with a jump discontinuity, such as the unit step, is difficult to plot. Consider plotting
% $u(t)$ by using $t = (-2:2)$.

t = (-2:2);
plot(t, u(t));
xlabel ('t');
ylabel('u(t)');

%%
% *Figure 1.48* $u(t)$ for $t = (-2:2)$.

%%
% Two significant problems are apparent in the resulting plot, shown in Fig. 1.48. First,
% MATLAB automatically scales plot axes to tightly bound the data. In this case, this normally
% desirable feature obscures most of the plot. Second, MATLAB connects plot data with lines,
% making a true jump discontinuity difficult to achieve. The coarse resolution of vector t emphasizes
% the effect by showing an erroneous sloping line between t = −1 and t = 0.
% The first problem is corrected by vertically enlarging the bounding box with the axis
% command. The second problem is reduced, but not eliminated, by adding points to vector t.

t = (-2:0.01:2);
plot(t, u(t));
xlabel('t');
ylabel('u(t)');
axis([-2 2 -0.1 1.1]);
title('Figure 1.48 u(t) for t = (-2:0.01:2)');

%%
% The four-element vector argument of axis specifies x axis minimum, x axis maximum, y axis
% minimum, and y axis maximum, respectively. The improved results are shown in Fig. 1.49.
% Relational operators can be combined using logical AND, logical OR, and logical negation: &,
% |, and ~, respectively. For example, (t>0) & (t<1) and ~((t<=0) $|$ (t>=1)) both test if 0 < t < 1.
% To demonstrate, consider defining and plotting the unit pulse p(t) = u(t) − u(t − 1), as shown in
% Fig. 1.50:

p =@(t) 1.0.*((t>=0)&(t<1));
t = (-1:0.01:2);
plot(t, p(t));
xlabel('t');
ylabel('p(t) = u(t) - u(t-1)');
axis([-1 2 -0.1 1.1]);
title('Figure 1.50 p(t) = u(t) − u(t − 1) over (−1 ≤ t ≤ 2).');
%%
% Since anonymous functions can be constructed using other anonymous functions, we could
% have used our previously defined unit step anonymous function to define p(t) as p = @(t)
% u(t)-u(t-1);.

%%
% For scalar operands, MATLAB also supports two short-circuit logical constructs. A
% short-circuit logical AND is performed by using &&, and a short-circuit logical OR is performed by
% using ||. Short-circuit logical operators are often more efficient than traditional logical operators
% because they test the second portion of the expression only when necessary. That is, when scalar
% expression A is found false in (A&&B), scalar expression B is not evaluated, since a false result
% is already guaranteed. Similarly, scalar expression B is not evaluated when scalar expression A is
% found true in (A||B), since a true result is already guaranteed.

%%
% *1.11-3 Visualizing Operations on the Independent Variable*

%%
% Two operations on a function’s independent variable are commonly encountered: shifting and
% scaling. Anonymous functions are well suited to investigate both operations.
% Consider $g(t) = f (t)u(t) = e −t cos (2π t)u(t)$, a causal version of $f(t)$. MATLAB easily
% multiplies anonymous functions. Thus, we create $g(t)$ by multiplying our anonymous functions
% for $f(t)$ and $u(t)$.

g = @(t) f(t).*u(t);

%%
% A combined shifting and scaling operation is represented by $g(at + b)$, where a and b are
% arbitrary real constants. As an example, consider plotting $g(2t + 1)$ over $(−2 ≤ t ≤ 2)$. With a = 2,
% the function is compressed by a factor of 2, resulting in twice the oscillations per unit t. Adding
% the condition b > 0 shifts the waveform to the left. Given anonymous function g, an accurate plot
% is nearly trivial to obtain.

t = (-2:0.01:2);
plot(t,g(2*t+1)); xlabel('t'); ylabel('g(2t+1)'); grid;
title('Figure 1.51 g(2t + 1) over (−2 ≤ t ≤ 2).');


%%
% Figure 1.51 confirms the expected waveform compression and left shift. As a final check, realize
% that function $g(·)$ turns on when the input argument is zero. Therefore, $g(2t + 1)$ should turn on
% when 2t + 1 = 0 or at t = −0.5, a fact again confirmed by Fig. 1.51.

%%
% Next, consider plotting $g(−t + 1)$ over $(−2 ≤ t ≤ 2)$. Since a < 0, the waveform will be
% reflected. Adding the condition b > 0 shifts the final waveform to the right.

plot(t,g(-t+1)); xlabel('t'); ylabel('g(-t+1)'); grid;
title('Figure 1.52 g(−t + 1) over (−2 ≤ t ≤ 2)');

%%
% Figure 1.52 confirms both the reflection and the right shift.
% Up to this point, Figs. 1.51 and 1.52 could be reasonably sketched by hand. Consider plotting
% the more complicated function $h(t) = g(2t + 1) + g(−t + 1)$ over $(−2 ≤ t ≤ 2)$ (Fig. 1.53); an
% accurate hand sketch would be quite difficult. With MATLAB, the work is much less burdensome.

plot(t,g(2*t+1)+g(-t+1)); xlabel('t'); ylabel('h(t)'); grid;
title('Figure 1.53 h(t) = g(2t + 1) + g(−t + 1) over (−2 ≤ t ≤ 2).');

%%
% *1.11-4 Numerical Integration and Estimating Signal Energy*
%%
% Interesting signals often have nontrivial mathematical representations. Computing signal energy,
% which involves integrating the square of these expressions, can be a daunting task. Fortunately,
% many difficult integrals can be accurately estimated by means of numerical integration techniques.
% Even if the integration appears simple, numerical integration provides a good way to verify
% analytical results.

%%
% To start, consider the simple signal $x(t) = e^{-t}(u(t) − u(t − 1))$. The energy of $x(t)$ is expressed
% as $E_{x} = \int_{-\infty}^{\infty} |x(t)|^{2} dt = \int_{0}^{1} e^{-2t}$. Integrating yields $E_{x} = 0.5(1 − e^{−2})$ ≈ 0.4323. The energy
% integral can also be evaluated numerically. Figure 1.27 helps illustrate the simple method of
% rectangular approximation: evaluate the integrand at points uniformly separated by $\Delta t$, multiply
% each by $ \Delta t$ to compute rectangle areas, and then sum over all rectangles. First, we create function
% $x(t)$.

x = @(t) exp(-t).*((t>=0)&(t<1));

%%
% With $\Delta t = 0.01$, a suitable time vector is created.

t = (0:0.01:1);

%%
% The final result is computed by using the sum command.

E_x = sum(x(t).*x(t)*0.01)

%%
% The result is not perfect, but at 1% relative error it is close. By reducing $ \Delta t$, the approximation is
% improved. For example,$ \Delta t = 0.001$ yields E_x = 0.4328, or 0.1% relative error.
% Although simple to visualize, rectangular approximation is not the best numerical integration
% technique. The MATLAB function quad implements a better numerical integration technique
% called recursive adaptive Simpson quadrature. To operate, quad requires a function describing
% the integrand, the lower limit of integration, and the upper limit of integration. Notice that no $\Delta t$
% needs to be specified.

%%
% To use quad to estimate E x , the integrand must first be described.

x_squared = @(t) x(t).*x(t);

%%
% Estimating $E_{x}$ immediately follows.

E_x = quad(x_squared,0,1)

%%
% In this case, the relative error is −0.0026%.
%%
% The same techniques can be used to estimate the energy of more complex signals. Consider
% $g(t)$, defined previously. Energy is expressed as $E_{g}=\int_{0}^{\infty}e^{-2t}cos^{2}(2\pi t)dt$. A closed-form solution
% exists, but it takes some effort. MATLAB provides an answer more quickly.

g_squared = @(t) g(t).*g(t);

%%
% Although the upper limit of integration is infinity, the exponentially decaying envelope ensures
% $g(t)$ is effectively zero well before $t$ = 100. Thus, an upper limit of t = 100 is used along with
% $\Delta t$ = 0.001.

t = (0:0.001:100);
E_g = sum(g_squared(t)*0.001)

%%
% A slightly better approximation is obtained with the quad function.

E_g = quad(g_squared,0,100)

%% 2) Resolución del problema 1.2-2

%%
% For the signal x(t) illustrated in Fig. P1.2-2, sketch
%%
% A) $x(t-4)$
%%
% B) $x(t/1.5)$
%%
% C) $x(-t)$
%%
% D) $x(2t-4)$
%%
% E) $x(2-t)$


u = @(t) 1.0.*(t>=0);

u1= @(t) 1.0.*((t>=-4)&(t<0));

u2=@(t) 1.0.*((t>=0)&(t<=2));

f=@(t) (-t.*u1(t)) + (t.*u2(t));

t = (-20:0.01:20);

plot(t,f(t))

axis([-5 5 -1 5]);

title('Fig. P1.2-2');

xlabel('t');

ylabel('x(t)');

%%
% *A)* $x(t-4)$



x1=@(t) f(t-4);

plot(t,x1(t));

axis([-1 9 -1 5]);

title('Inciso a');

xlabel('t');

ylabel('x(t-4)');

%%
% *B)* $x(t/1.5)$



x2=@(t) f(t/1.5);

plot(t,x2(t));

axis([-8 5 -1 5]);

title('Inciso b');

xlabel('t');

ylabel('x(t/1.5)');

%%
% *C)* $x(-t)$




x3=@(t) f(-t);

plot(t,x3(t));

axis([-5 5 -1 5]);

title('Inciso c');

xlabel('t');

ylabel('x(-t)');

%%
% *D)* $x(2t-4)$




x4=@(t) f(2.*t - 4);

plot(t,x4(t));

axis([-5 5 -1 5]);

title('Inciso d');

xlabel('t');

ylabel('x(2t-4)');

%%
% *E)* $x(2t-4)$




x5=@(t) f(2 - t);

plot(t,x5(t));

axis([-1 8 -1 5]);

title('Inciso e');

xlabel('t');

ylabel('x(2-t)');


t=(-3*pi:0.001:3*pi);



%% 3) Resolución del problema 1.11-1
%
%%
% Provide MATLAB code and output that plots
% the odd portion $x_{o}(t)$ of the function $x(t) =
% 2^{-t}cos(2\pi t)u(t?\pi )$ over a suitable-length interval using a suitable number of points.
%
%%
% $X(t)=2^tcos(2\pi t)$
%%
% $X_{impar(t)}=\frac{x(t)-x(-t)}{2}$
%%
% $X_{impar(t)}=2^{-t-1}cos(2\pi t)u(t-\pi )-2^{t-1}cos(-2\pi t)u(-t-\pi )$


for i=1:length(t)
if t(i)<=-pi
R(i)=-(2.^(t(i)-1)).*cos(-2*pi*t(i));
elseif t(i)>=pi
R(i)=(2.^(-t(i)-1)).*cos(2*pi*t(i));
else
R(i)=0;
end
end

plot(t,R);
ylabel('Ximpar(t)');
xlabel('t');
title('Ejercicio 1.11-1');
grid on;

%% 4) Construcción de la gráfica. 
%
% Construye la grafica de

%% 
% $$x(t) = \sum_{k=1}^{10} cos(2\pi k t)$$
%
% para cuatro rangos (figura 2x2). Los ejes deben mostrarse en el origen además de la edición de su preferencia.
% Procedimiento:
%

clf;
subplot(2,2,1);
y=0;
t=linspace(-4*pi,-2*pi,1000);
for k=1:10
    
x=cos(2*pi*k*t);
y=y+x;
end
plot(t,y);
grid on;
ax = gca;
xlabel('Dominio t');
ylabel('x(t)');
title('Gráfica rango -4pi<=t<=-2pi ');



subplot(2,2,2);
y=0;
t=linspace(-2*pi,0,1000);
for k=1:10
    
x=cos(2*pi*k*t);
y=y+x;
end
plot(t,y);
grid on;
ax = gca;
xlabel('Dominio t');
ylabel('x(t)');

title('Gráfica rango -2pi<=t<=0 ');



subplot(2,2,3);
y=0;
t=linspace(0,2*pi,1000);
for k=1:10
    
x=cos(2*pi*k*t);
y=y+x;
end
plot(t,y);
grid on;
ax = gca;
xlabel('Dominio t');
ylabel('x(t)');
title('Gráfica rango 0<=t<=2pi ');



subplot(2,2,4);
y=0;
t=linspace(2*pi,4*pi,1000);
for k=1:10
    
x=cos(2*pi*k*t);
y=y+x;
end
plot(t,y);
grid on;
ax = gca;
xlabel('Dominio t');
ylabel('x(t)');
title('Gráfica rango 2pi<=t<42pi ');


%% 5) Resolucón del problema 1.11-3

%%
% Define $x(t) = e^{t(1+j2\pi)}u(-t)$ and $y(t) = Re[2x(\frac{-5-t}{2})]$.
%
% *A)* Use MATLAB to plot $Re{x(t)}$ versus
% $Im{x(at)}$ for a = 0.5, 1, and 2 and $-10\leq t\leq 10$.
% How important is the scale factor a
% on the shape of the resulting figure?
% 
% *B)* Use MATLAB to plot $y(t)$ over -10\leq t\leq
% 10. Analytically determine the time $t_0$ where
% y(t) has a jump discontinuity. Verify yourcalculation 
% of $t_0$ using the plot of $y(t)$.
% 
% *C)* Use MATLAB and numerical integration to
% compute the energy $E_x$ of signal x(t).
% 
% *D)* Use MATLAB and numerical integration to
% compute the energy $E_y$ of signal $y(t)$.
%
% *E)* Graficar a la función $x(t)$ en el intervalo (-10 \leq t \leq 10).

t = (-10:0.01:10);

u = @(t) 1.0.*(t>=0);

x = @(t) exp(t.*(1+j*2*pi)).*u(-t);

y = @(t) real(2.*x((-5.-t)/2));


%%
% *A)* Use MATLAB to plot $Re{x(t)}$ versus
% $Im{x(at)}$ for a = 0.5, 1, and 2 and $-10\leq t\leq 10$.
% How important is the scale factor a
% on the shape of the resulting figure?

subplot(2,2,1)
a=0.5;

plot(real(x(t)),imag(x(a*t)));

axis([-2 2 -1 1]);

title('a=0.5');

xlabel('Re{x(t)}');

ylabel('im{x(0.5t)}');



subplot(2,2,2)
a=1;

plot(real(x(t)),imag(x(a*t)));

axis([-2 2 -1 1]);

title('a=1');

xlabel('Re{x(t)}');

ylabel('im{x(t)}');



subplot(2,2,3)
a=2;

plot(real(x(t)),imag(x(a*t)));

axis([-2 2 -1 1]);

title('a=2');

xlabel('Re{x(t)}');

ylabel('im{x(2t)}');


%%
% *B)* Use MATLAB to plot $y(t)$ over -10\leq t\leq
% 10. Analytically determine the time $t_0$ where
% y(t) has a jump discontinuity. Verify yourcalculation 
% of $t_0$ using the plot of $y(t)$.

plot(t,y(t));

axis([-2 2 -1 1]);

title('inciso b');

xlabel('t');

ylabel('y(t)');


%%
% *C)* Use MATLAB and numerical integration to
% compute the energy $E_x$ of signal x(t).
% 
h1 =@(t) power(real(x(t)),2) + power(imag(x(t)),2);
plot(t, h1(t));
xlabel ('t');
ylabel ('|x(t)|^2');
title ('Norma al cuadrado de x(t)');

%%
% De la gràfica de la norma al cuadrado podemos obtener los lìmites para realizar la integral numérica.
q1 = integral(h1,-10,1)

%% 
% $\therefore E_{x} = 0.5$

%%
% *D)* Use MATLAB and numerical integration to
% compute the energy $E_y$ of signal $y(t)$.

h2 = @(t) power(real(y(t)), 2) + power(imag(y(t)), 2);
plot(t,h2(t));
xlabel ('t');
ylabel ('|y(t)|^2');
title ('Norma al cuadrado de y(t)');

%%
% De la gráfica de la norma al cuadrado podemos obtener los lḿites para realizar la integral numèrica.

q2 = integral (h2,-6,10)

%% 
% $\therefore E_{y} = 2.0494$

%%
% *E)* Graficar a la función $x(t)$ en el intervalo $(-10 \leq t \leq 10)$.

plot3(real(x(t)), imag(x(t)), t);
xlabel ('Re(x(t))');
ylabel ('Im(x(t))');
zlabel ('t');
title ('Inciso e');