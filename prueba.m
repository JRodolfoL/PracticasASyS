## Práctica 1: Señales en tiempo continuo.
%
% *Integrantes:*
%
% * Arellano Paz Angel Ulises
% * Cardoso Arias Javier
% * Gachuz Hernández Karla Denisse
% * García Arteaga Alejandro
% * López Galván José Rodolfo
%
##

%% Objetivos 
% * Manipulación básica de MATLAB
% * Gráficas de señales reales y complejas continuas
% * Transformación de señales continuas (escalamientos y traslaciones)
% * Calculo de energía y potencia de señales continuas

%%  1.11 Working with functions.
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