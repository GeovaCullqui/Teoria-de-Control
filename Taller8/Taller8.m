% 2.3.1 Implementación y análisis del modelo del motor dc

% Definición de parámetros físicos del motor
Ra = 0.635;          
La = 0.0883;         
Ki = 9.43*10^-3;     
Kb = 1010;           
Jm = 330;             
Bm = 1*10^-3;         

% Función de transferencia del motor: G(s)
Gs = tf([Ki/(La*Jm)], [1 ((Bm)/(Jm)+(Ra)/(La))  ((Ra*Bm)+(Ki*Kb))/(La*Jm)]);

% Obtener denominador y calcular raíces (polos del sistema)
den = [1 ((Bm)/(Jm)+(Ra)/(La))  ((Ra*Bm)+(Ki*Kb))/(La*Jm)];
roots(den);  % Polos del sistema original

% Ejercicio 2.1 - Respuesta al escalón y lugar de raíces del sistema original
figure;
grid on
subplot(2,1,1);
step(Gs);  % Respuesta transitoria al escalón
subplot(2,1,2);
rlocusplot(Gs);  % Lugar de las raíces

% 2.3.2 Compensación del modelo

% Especificaciones de diseño
Mp = 0.1;           
tss = 1;          

% Cálculo de zeta (factor de amortiguamiento) y frecuencia natural omega_n
Zera = log(1/Mp)/sqrt(pi^2 + (log(1/Mp))^2);
Wn = 4/ (tss * Zera);

% Ecuación característica del sistema de segundo orden deseado
Ec_Segundo_Orden = [1 2*Zera*Wn Wn^2];
Polos_diseno = roots(Ec_Segundo_Orden);  % Polos deseados
Segundo_Orden = tf([Wn^2], [Ec_Segundo_Orden]);  % TF deseada

% Ejercicio 2.2 - Comparación entre polos originales y deseados
figure;
rlocusplot(Gs);  % Lugar de raíces del sistema original
hold on, grid on
plot(real(Polos_diseno), imag(Polos_diseno), 'bx')  % Polos deseados
hold off

% 2.3.3 Diseño del compensador

angulo_rad = 54*pi/180;  % Ángulo de deficiencia necesario para el diseño [rad]
pc = 7.9543;              % Polo del compensador
Zc = 7.1457;              % Cero del compensador (ubicado donde se cancela el polo original)

% Cálculo del punto en el eje real donde ubicar el nuevo polo (proyección angular)
x = (5.4575 / tan(angulo_rad)) + 4;
sd = -4 + 5.4575i;              % Polo deseado para el cálculo de Kc
Gc_temp = tf([1 Zc], [1 pc]);   % Compensador sin ganancia (Kc = 1)
L = Gc_temp * Gs;               % Función de lazo abierto sin Kc

% Evaluación de la magnitud del lazo abierto en el polo deseado
mag = abs(evalfr(L, sd) * Kb);

% Cálculo de la ganancia del compensador
Kc = 1 / mag;

% Definición del compensador con ganancia
Gc = tf([1*Kc Kc*Zc], [1 pc]);

% Sistema compensado en lazo abierto: Gc(s)*G(s)
Gs_con_Compensador = series(Gc, Gs);
Hs = Kb;  % Función de transferencia del sensor (realimentación)

% Ejercicio 2.3 - Lugar de raíces del sistema compensado
figure;
rlocusplot(Gs_con_Compensador);  
hold on, grid on
plot(real(Polos_diseno), imag(Polos_diseno), 'Bx', 'MarkerSize', 15)  
hold off

% Sistema compensado en lazo cerrado
Gs_compensado = feedback(Gs_con_Compensador, Hs);

% 2.3.4 Respuesta al escalón entre sistema original y compensado
figure;
subplot(2,1,1);
step(Gs)  
hold on
step(Gs_compensado)  %
hold off

subplot(2,1,2);
rlocusplot(Gs_compensado);  

% Respuesta al escalón del sistema compensado (figura final)
figure;
step(Gs_compensado)
