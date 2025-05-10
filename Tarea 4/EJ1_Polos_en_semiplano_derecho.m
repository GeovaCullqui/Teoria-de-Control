% ----------------------------
% Sistema en lazo cerrado (1)
% ----------------------------

% Paso 1: Denominadores de G(s) y H(s)
G_den = [1 7 20];
H_den = [1 3 4];
GH_den = conv(G_den, H_den);  % (s^2 + 7s + 20)(s^2 + 3s + 4)

% Paso 2: Expandir y sumar 4*(s + 1)
extra = conv([4], [1 1]);           % 4*(s + 1) = 4s + 4 → [4 4]
extra_padded = [0 0 0 extra];       % Alinear con GH_den (grado 4)
den_total = GH_den + extra_padded; % Denominador total corregido

% Paso 3: Numerador
num_total = 4 * [1 1];              % 4*(s + 1) = [4 4]

% Paso 4: Crear sistema y graficar polos/ceros
sys = tf(num_total, den_total);
pzmap(sys)
grid on
title('Polos y ceros del sistema en lazo cerrado (Ejercicio 1)')
