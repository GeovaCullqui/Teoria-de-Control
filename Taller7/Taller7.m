% TALLER 7

% Numerador y Denominador para la FT
numerador = [1 3];
denominador = [1 5 20 16 0];

% Polos y ceros
zeros_1 = roots(numerador);
polos = roots(denominador);

% Graficar los polos y ceros
figure 
v = [-6 6 -6 6]; 
axis(v);
axis('square')
hold on; grid on;
plot(real(zeros_1), imag(zeros_1), 'go', 'LineWidth', 2);
plot(real(polos), imag(polos), 'rx', 'LineWidth', 2);
hold on; grid on;

% Viendo la gráfica nos damos cuenta que los polos y ceros se encuentran en:
% Como vemos, tenemos todos los polos en el semiplano negativo, por tanto es
% estable, y también es oscilante y está amortiguándose

% 7.3.2 Determinar los ángulos de las asíntotas
k = [0 1 2];
n = 4;
m = 1;

angulos_asintotas = 180 * (2 * k + 1) / (n - m);
disp(angulos_asintotas); % ángulos de las asíntotas en grados

% 7.3.3 Calcular el centroide
centroide = ((0 - 1 - 2 - 2) - (-3)) / (n - m);
plot(real(centroide), imag(0), 'yo', 'LineWidth', 2);
hold on; grid on;

% Como vemos el centroide se encuentra en -0.6667, desde este punto partirán
% las asíntotas

% 7.3.4 Determinar la intersección de las asíntotas con el eje imaginario
% Sabemos que un ángulo es de 60 grados y el otro de 300 o sea -60 grados, y
% el último de 180. Por tanto, aplicando la tangente inversa de 60 grados nos da
% que la pendiente de esta recta será sqrt(3), y la de -60 grados -sqrt(3)

% Graficamos las líneas de las asíntotas
x = centroide:0.1:6;
y1 = sqrt(3) * (x - centroide);
y2 = -y1;
xa = -6:0.1:centroide;
ya = zeros(1, length(xa));

y1corte = sqrt(3) * (-2/3);
y2corte = -y1corte;

plot(0, y1corte, 'ko');
plot(0, y2corte, 'ko');
plot(x, y1, 'k-.');
plot(x, y2, 'k-.');
plot(xa, ya, 'k-.');

hold on; grid on;

% 7.3.5 Determinar el lugar de raíces
% Esto hicimos a mano:
% En el intervalo desde 0.1 a infinito no hay LGR.
% En el intervalo de -0.999 a 0 sí tenemos LGR ya que a la derecha tenemos
% número impar de polos y ceros.
% En el intervalo de -2.999 a -1 no tenemos LGR ya que a la derecha tenemos
% número par de polos y ceros.
% En el intervalo de -infinito a -3 sí tenemos LGR ya que a la derecha tenemos
% número impar de polos y ceros.

% 7.3.6 Determinar los puntos de llegada y partida
% También se calculó a mano.
% Escogemos solo los que tengan parte real, en este caso:
s3 = -4.2376;
s4 = -0.524;
plot(real(s4), imag(0), 'bs', 'LineWidth', 2);
plot(real(s3), imag(0), 'bs', 'LineWidth', 2);
hold on; grid on;

% 7.3.7 Intersección de las raíces con el eje imaginario
% También se calculó a mano usando el criterio de Routh

% Definir los puntos de cruce en el eje imaginario
cruce1 = 1i * 3.1409;
cruce2 = -1i * 3.1409;

% Graficar los puntos de cruce en el eje imaginario con un símbolo cuadrado negro
plot(0, imag(cruce1), 'ks', 'LineWidth', 2);  % cruce1 en eje imaginario positivo
hold on;
plot(0, imag(cruce2), 'ks', 'LineWidth', 2);  % cruce2 en eje imaginario negativo

% Configuración adicional del gráfico
grid on;
hold on;

% 7.3.8 Determinar los ángulos de salida
% También se calculó a mano 
% Obtuvimos -62 grados

% 7.3.9 Realizamos el esbozo del LGR:
% rlocus(tf(numerador, denominador));
% xlim([-6, 6]);
% ylim([-6, 6]);
