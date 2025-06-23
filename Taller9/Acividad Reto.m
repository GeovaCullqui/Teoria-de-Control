% Parámetros del circuito 
R_h = 100;    % Resistencia para Pasa-alta en ohmios
L_h = 112.54e-3;  % Inductancia para Pasa-alta en henrios
C_h = 22.5e-6;  % Capacitancia para Pasa-alta en faradios

R_b = 100;    % Resistencia para Pasa-bandas en ohmios
L_b = 159.15e-3;  % Inductancia para Pasa-bandas en henrios
C_b = 15.915e-6;  % Capacitancia para Pasa-bandas en faradios

% Definición de la variable s (Laplace)
s = tf('s');

%% Pasa-alta (Voltaje en el inductor)
% Impedancia total para Pasa-alta
Z_highpass = R_h + s*L_h + 1/(s*C_h);

% Voltaje en el inductor (pasa-alta)
H_highpass = (s*L_h) / Z_highpass;
disp('Función de transferencia Pasa-alta:');
H_highpass

%% Pasa-bandas (Voltaje en la resistencia)
% Impedancia total para Pasa-bandas
Z_bandpass = R_b + s*L_b + 1/(s*C_b);

% Voltaje en la resistencia (pasa-bandas)
H_bandpass = R_b / Z_bandpass;
disp('Función de transferencia Pasa-bandas:');
H_bandpass

% Bode plots para visualizar las funciones de transferencia
figure;
bode(H_highpass);
title('Pasa-alta');

figure;
bode(H_bandpass);
title('Pasa-bandas');


%% Calculo MANUAL
% Parámetros del circuito 
R_h = 100;          % Ohmios
L_h = 112.54e-3;    % Henrios
C_h = 22.5e-6;      % Faradios

R_b = 100;
L_b = 159.15e-3;
C_b = 15.915e-6;

% Frecuencia angular (de 10^1 a 10^5 rad/s)
w = logspace(1, 5, 1000);  % 1000 puntos entre 10^1 y 10^5

% Variable compleja s = jω
s = 1j * w;

% Función de transferencia del filtro pasa-alta (voltaje en el inductor)
Z_highpass = R_h + s.*L_h + 1./(s.*C_h);
H_highpass = (s.*L_h) ./ Z_highpass;

% Función de transferencia del filtro pasa-bandas (voltaje en la resistencia)
Z_bandpass = R_b + s.*L_b + 1./(s.*C_b);
H_bandpass = R_b ./ Z_bandpass;

% Calcular magnitud y fase
mag_high = 20*log10(abs(H_highpass));
phase_high = angle(H_highpass) * (180/pi);

mag_band = 20*log10(abs(H_bandpass));
phase_band = angle(H_bandpass) * (180/pi);

% Graficar Bode para pasa-alta
figure;

subplot(2,1,1);
semilogx(w, mag_high, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Frecuencia [rad/s]');
ylabel('Magnitud [dB]');
title('Filtro Pasa-Alta - Magnitud');

subplot(2,1,2);
semilogx(w, phase_high, 'r', 'LineWidth', 1.5);
grid on;
xlabel('Frecuencia [rad/s]');
ylabel('Fase [°]');
title('Filtro Pasa-Alta - Fase');

% Graficar Bode para pasa-banda
figure;

subplot(2,1,1);
semilogx(w, mag_band, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Frecuencia [rad/s]');
ylabel('Magnitud [dB]');
title('Filtro Pasa-Banda - Magnitud');

subplot(2,1,2);
semilogx(w, phase_band, 'r', 'LineWidth', 1.5);
grid on;
xlabel('Frecuencia [rad/s]');
ylabel('Fase [°]');
title('Filtro Pasa-Banda - Fase');
