
%//////////////////////////////////////////////////////////////
%//////////  Respuesta a señales típicas  /////////////////////
%//////////////////////////////////////////////////////////////

%///////////////////////////////////////////////
%///////////////  Punto 1.1  ///////////////////
%///////////////////////////////////////////////

num = 3;
den = [1 2 3];

G  =tf(num,den, "InputDelay",2);

[y,t] = step(Gs);
%figure();
%plot(t,y)
%subplot(2,1,1)
%impulse(G);
%subplot(2,1,2)
%step(G);

%//////////////////////////////////////////////////////////////
%//////////  Respuesta a señales arbitrarias  /////////////////
%//////////////////////////////////////////////////////////////

%///////////////////////////////////////////////
%///////////////  Punto 2.1  ///////////////////
%///////////////////////////////////////////////
ts = 0.1;
t = 0:ts:30;
t = t';
N = length(t);
sizeV = int32(N/3);  % = 100

s1 = zeros(1, sizeV);        % De 0 a 10s → valor 0
s2 = ones(1, sizeV) * 5;     % De 10 a 20s → valor 5
s3 = ones(1, sizeV + 1) * 10;% De 20 a 30s → valor 10 (+1 para igualar tamaño con t)

% Unimos todos los segmentos
arbsig = [s1 s2 s3]';

u = [t arbsig];


%hold on
%grid on
%title('Señal Arbitraria')
%xlabel('Tiempo [s]')
%ylabel('Amplitud')
%plot(t,arbsig,"-","LineWidth",2)
%hold off

%///////////////////////////////////////////////
%///////////////  Punto 2.2  ///////////////////
%///////////////////////////////////////////////
ts = 0.1;
t = 0:ts:30;
t = t';
N = length(t);
sizeV = int32(N/3);  % = 100

s1 = zeros(1, sizeV);        % De 0 a 10s → valor 0
s2 = ones(1, sizeV) * 5;     % De 10 a 20s → valor 5
s3 = ones(1, sizeV + 1) * 10;% De 20 a 30s → valor 10 (+1 para igualar tamaño con t)

% Unimos todos los segmentos
arbsig = [s1 s2 s3]';

Resp = lsim(G, arbsig,t);
%hold on
%grid on
%title('Respuesta del sistema')
%xlabel('Tiempo [s]')
%ylabel('Amplitud')
%plot(t,arbsig,"-","LineWidth",2)
%plot(t, Resp,"-","LineWidth",2)
%hold off



%///////////////////////////////////////////////
%///////////////  Punto 2.3  ///////////////////
%///////////////////////////////////////////////
ts = 0.1;
t = 0:ts:40;
t = t';
N = length(t);
sizeV = int32(N/4);  % = 100

s1 = zeros(1, sizeV);        % De 0 a 10s → valor 0
s2 = ones(1, sizeV) * 5;     % De 10 a 20s → valor 5
s3 = linspace(15, 25, sizeV); % Rampa de 20 a 30s
s4 = ones(1, sizeV + 1) * 25; % De 30 a 40s → valor 25 

% Unimos todos los segmentos
arbsig = [s1 s2 s3 s4]';

%Resp = lsim(G, arbsig,t);
%hold on
%grid on
%title('Respuesta del sistema')
%xlabel('Tiempo [s]')
%ylabel('Amplitud')
%plot(t,arbsig,"-","LineWidth",2)
%plot(t, Resp,"-","LineWidth",2)
%hold off


%//////////////////////////////////////////////////////////////
%//////////////////  Actividad Reto  //////////////////////////
%//////////////////////////////////////////////////////////////

%///////////////////////////////////////////////
%///////////////  Punto 3.1  ///////////////////
%///////////////////////////////////////////////
ts = 0.1;
t = 0:ts:40;
t = t';
N = length(t);
sizeV = int32(N/4);  % = 100

s1 = linspace(0, 10, sizeV);      % De 0 a 10s → valor 0
s2 = ones(1, sizeV) * 20;     % De 10 a 20s → valor 5
s3 = linspace(15, 10, sizeV); % Rampa de 20 a 30s
s4 = ones(1, sizeV + 1) * 5; % De 30 a 40s → valor 25 

% Unimos todos los segmentos
arbsig = [s1 s2 s3 s4]';

Resp = lsim(G, arbsig,t);
hold on
grid on
title('Respuesta del sistema')
xlabel('Tiempo [s]')
ylabel('Amplitud')
plot(t,arbsig,"-","LineWidth",2)
plot(t, Resp,"-","LineWidth",2)
hold off










