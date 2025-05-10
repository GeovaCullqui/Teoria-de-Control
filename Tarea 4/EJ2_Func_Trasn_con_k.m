% Valores de K a analizar
K_values = linspace(0.5,71,5);

% Crear figura
figure;
hold on;

% Colores para distinguir cada curva
colors = lines(length(K_values));  % Paleta de colores automática

for i = 1:length(K_values)

    % Funcion de Trasnferencia
    num = K_values(i);
    den = [1 8 9 K_values(i)];

    % Crear sistema
    sys = tf(num, den);

    % Simular respuesta al escalón
    [y, t] = step(sys, 0:0.01:30);  % Tiempo de simulación de 0 a 30 s
    plot(t, y, 'DisplayName', ['K = ' num2str(K_values(i))], 'LineWidth', 1.5, 'Color', colors(i,:));
end

% Personalizar gráfica
title('Respuesta al escalón para distintos valores de K')
xlabel('Tiempo (s)')
ylabel('Amplitud')
legend('show')
grid on;
hold off;
