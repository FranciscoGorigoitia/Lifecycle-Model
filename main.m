%% Tarea 4 - ADA - Francisco Gorigoitía, Lucas Lara

clear all
clc
rng(123)

X0 = 100;
sigma = 0.25;
tetha = 0.25;
r = 0.0875;
deltat = 1/252;
R_values = [0.5, 1, 2, 4, 8, 10];
T = 5;
s = 0; %por enunciado pregunta 1 lo asumimos

%% a)

%Calculamos deltaWt 
t = 0:deltat:T;
delta_Wt = zeros(1, length(t));

for i = 1:length(t)
    Z = randn(); %N(0,1)
    delta_Wt(i) = sqrt(deltat) * Z;
end

Chi = getChi(r,tetha,t,s,delta_Wt); %trayectoria Chi con dWt

%% b)

p = zeros(1,length(R_values));

for i=1:length(R_values)
    p(i) = getP(R_values(i));
end

Chi2 = zeros(1,length(R_values));

for i=1:length(p)
    for j = 1:length(t)
        Chi2(i,j) = getChiwithP(r,tetha,t(j),p(i)); %trayectoria Chi2, usamos T ya que pide [0,T] y no [t,T], para la función CRRA
    end
end

Y_elev = X0./Chi2;

X_optimoB = zeros(length(R_values),length(t));

for i = 1:length(R_values)
    for j = 1:length(t)
        X_optimoB(i,j) = Y_elev(i,j).*Chi(j).^(-1./R_values(i)).*Chi2(i,j);
    end
end

%% c)

X_optimoC = zeros(length(R_values),length(t));

for i= 1:length(R_values)
    for j=1:length(t)
        X_optimoC(i,j) = getXt(X0,r,tetha,R_values(i),delta_Wt(j),t(j));
    end
end

%% Graficamos:

% Crear una figura
figure;

subplot(2, 1, 1);
plot(t(1:21), X_optimoB(:, 1:21), 'LineWidth', 2);
xlabel('Días de Trading (en % de 5 años)');
ylabel('Valores (X optimo B)');
title('X optimo B');
grid on;
set(gca, 'FontSize', 12);

subplot(2, 1, 2); 
plot(t(1:21), X_optimoC(:, 1:21), 'LineWidth', 2);
xlabel('Días de Trading (en % de 5 años)');
ylabel('Valores (X optimo C)');
title('X optimo C');
grid on;
set(gca, 'FontSize', 12);

sub_pos = get(gca, 'Position');
sub_pos(4) = sub_pos(4) + 0.1;
set(gca, 'Position', sub_pos);

legend('X optimo B', 'X optimo C');

%Del grafico podemos ver que el componente wealth tiene fluctuaciones en
%los 21 primeros días de trading.








