% ----------------------------
% Sistema en lazo cerrado (1)
% ----------------------------
% Paso 2: Expandir y sumar 4*(s + 1)
den_total = [1 10 45 92 84];

% Paso 3: Numerador
num_total = [4 4];

% Paso 4: Crear sistema y graficar polos/ceros
% sys = tf(num_total, den_total);
% pzmap(sys)
% grid on
% title('Polos y ceros del sistema en lazo cerrado (Ejercicio 1)')


v = [1];
for k = 0:14
num_total  = k;
den_total = [1 3 3 2 k];
    v = [v,k];
    H1 = tf(num_total, den_total)

step(H1)
hold on
grid on
end