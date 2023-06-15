%% Ejercicio 3 - Guia 1
clear all
%% Radio
R = [57909100,108208930,149598261,227939100,413832587,778547200,...
    1433449370,2876679082,4503443661,5906376272]';
% metros
R = R.*1000;
% Tera metros
R = R./1e12;
% Radio al cubo
d = R.^3;
%
%% Periodo
z = [87.969,224.7,365.25636,686.971,1680.5,4331.57,10759.22,...
    30799.10,60190,90613.31]';
z = z./1000;
%
%% Matriz G
a=0;
for i=1:10
    a=a+1;
    G(a,:)=[1,z(i),z(i).^2];
end
%
%% Coeficientes m_n
m = (inv(G'*G)*(G'))*d;
%
x=0:100;
y=m(1)+m(2)*x+m(3)*x.^2;
%
%% Calculamos el error
for i=1:10
    aux=m(1)+m(2)*z(i)+m(3)*z(i).^2;
    error(i,1)=d(i)-aux;
end
clear aux
%% FIGURA
close all
figure()
subplot(2,1,1)
plot(z,d,'*','LineWidth',2,'Color','r')
hold on
plot(x,y,'LineWidth',1.5,'Color','k')
xlabel('period, Kdays')
ylabel('radius^3, Tm^3')
grid minor
axis([x(1) x(end) 0 250])
%
subplot(2,1,2)
plot(z,error,'o','LineWidth',2,'Color','r')
hold on
plot(x,y-y,'LineWidth',1.5,'Color','k')
xlabel('period, Kdays')
ylabel('error, Tm^3')
grid minor
axis([0 100 -0.5 0.5])
%
%% Matriz de covarianza

Ginv = inv(G'*G)*(G');
Cov = Ginv * (Ginv');

%% Intervalo de confianza al 95%

del = 1.96*sqrt(diag(Cov));
