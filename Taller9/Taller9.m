
%% PARTE #1, Grafica usando la fucnion bode de Matlab

% Parámetros del circuito RLC
R = 10;        % Resistencia en ohmios
L = 1e-3;      % Inductancia en henrios
C = 100e-6;    % Capacitancia en faradios

N = 100;
w = logspace(1, 7, N); % Frecuencia angular en rad/s
% Crear la función de transferencia del circuito
DEN = [1 (R/L) 1/(L*C)];
NUM = [1/(L*C)];     % Denominador: LC * s^2 + RC * s + 1

H = tf(NUM, DEN);      % Función de transferencia en MATLAB

% Graficar el diagrama de Bode
figure;
bode(H,w);
xlim([0 1*10e7])
grid on;
title('Diagrama de Bode del Circuito RLC');

% Definir el rango de frecuencias en Hz (de 10^0 a 10^7)
f = logspace(0, 7, 100);

% Convertir frecuencia en Hz a frecuencia angular en radianes/segundo
w = 2 * pi * f;

% Inicializar vectores para la magnitud y fase de la respuesta en frecuencia
H_mag = zeros(size(w));     % Magnitud de H(jw)
H_phase = zeros(size(w));   % Fase de H(jw)

% Evaluar la función de transferencia en cada frecuencia
for i = 1:length(w)
    s = 1j * w(i);                              % Variable compleja s = j*w
    H = 1 / (L*C*s^2 + R*C*s + 1);              % Evaluar H(s) del circuito RLC
    H_mag(i) = abs(H);                          % Calcular la magnitud
    H_phase(i) = angle(H);                      % Calcular la fase
end

% Convertir la magnitud a decibeles
H_mag_db = 20 * log10(H_mag);

% Graficar el diagrama de Bode manualmente
figure;
subplot(2, 1, 1);                               % Subgráfico para la magnitud
semilogx(f, H_mag_db, 'b');                     % Magnitud en escala logarítmica
grid on;
title('Diagrama de Bode del Circuito RLC');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud (dB)');

subplot(2, 1, 2);
semilogx(f, rad2deg(H_phase), 'r');
ylim([-180 0]);
grid on;
xlabel('Frecuencia (Hz)');
ylabel('Fase (grados)');


R1 = 10e3;
C1 = 1e-12;
R2 = 10e3;
C2 = 1e-6;
R3 = 10e3;
R4 = 10e3;

% Rango de frecuencias angulares
N = 100;
w = logspace(1, 10, N); % Frecuencia angular en rad/s
num2 = [R4*R2*R1*C1 R4*R2];
den2 = [R3*R1*R2*C2 R3*R1];
G = tf(num2, den2);

% Mostrar el diagrama de Bode
figure;
bode(G, w);
grid on;


%% Actividad en clase
% Parámetros del circuito 
R1 = 10e3;
C1 = 1e-12;
R2 = 10e3;
C2 = 1e-6;
R3 = 10e3;
R4 = 10e3;

% Rango de frecuencias angulares
N = 100;
w = logspace(1, 7, N); % Frecuencia angular en rad/s
num2 = [R4*R2*R1*C1 R4*R2];
den2 = [R3*R1*R2*C2 R3*R1];
G = tf(num2, den2);

% Mostrar el diagrama de Bode
figure;
bode(G, w);
grid on;

% Encontrar los márgenes de ganancia y de fase
[GM, PM, Wcg, Wcp] = margin(G);

% Mostrar los resultados
disp(['Margen de ganancia (dB): ', num2str(20*log10(GM))]);
disp(['Margen de fase (grados): ', num2str(PM)]);
disp(['Frecuencia de ganancia cruzada (rad/s): ', num2str(Wcg)]);
disp(['Frecuencia de fase cruzada (rad/s): ', num2str(Wcp)]);

