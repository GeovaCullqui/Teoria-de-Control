% Actividad Reto - Compensador en adelanto para circuito RLC

% Parámetros del circuito RLC
R = 22;       
L = 500e-6;  
C = 220e-6;      

% Función de transferencia del circuito RLC
num = 1;
den = [L*C, R*C, 1];
roots(den);
G = tf(num, den);

figure;         % FIGURA 1 (Resp escalón y LGR del sistema original)
subplot(2,1,1);
step(G);
title('Respuesta al Escalón del Sistema RLC');
subplot(2,1,2);
rlocus(G);
title('Lugar Geométrico del Sistema RLC');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Parte 2: Especificaciones y Cálculo de Polos Deseados %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mp = 0.25;    % Sobreimpulso máximo (25%)
tss = 0.05;   % Tiempo de establecimiento (50 ms)

Zera = log(1/Mp)/sqrt(pi^2 + (log(1/Mp))^2);
Wn = 4/ (tss * Zera);

% Ecuación característica del sistema de segundo orden deseado
Ec_Segundo_Orden = [1 2*Zera*Wn Wn^2];
Polos_diseno = roots(Ec_Segundo_Orden);  % Polos deseados
Segundo_Orden = tf([Wn^2], [Ec_Segundo_Orden]);  % TF deseada

%%% Mostrar resultados por consola %%%
disp('--- Resultados del sistema RLC ---');
disp(['Zera (ζ): ', num2str(Zera)]);
disp(['Wn : ', num2str(Wn)]);

% Polos del sistema original
poles_original = pole(G);

figure;         % FIGURA 2 (Lugar geométrico con comparación)
rlocus(G);
hold on;
plot(real(poles_original), imag(poles_original), 'Bx', 'MarkerSize', 10);
plot(real(Polos_diseno), imag(Polos_diseno), 'r*', 'MarkerSize', 10);
title('Lugar Geométrico con Polos Originales y Deseados');
grid on;
hold off;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%     Parte 3: Diseño Compensador            %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definimos el ángulo deseado de contribución del polo del compensador
angulo_deg = 54;
angulo_rad = deg2rad(angulo_deg);

% Calculamos la posición del polo y del cero  (cero en el polo dominante original)
zc = real(poles_original(2));  % Zc = -208.35 aprox.
pc = -100;

kc = 320;
%Hs = Kb;  % Función de transferencia del sensor (realimentación)
Hs = 1;

% Definición del compensador con ganancia
Gc = tf([1*kc kc*zc], [1 pc]);
Gs_con_Compensador = series(Gc, G);                % Sistema compensado en lazo abierto: Gc(s)*G(s)
Gs_compensado = feedback(Gs_con_Compensador, Hs);   % Sistema compensado en lazo cerrado

% 2.3.4 Respuesta al escalón entre sistema original y compensado
figure;
step(G)  
hold on
step(Gs_compensado)  
hold off

figure;
step(Gs_compensado)



