import numpy as np
import matplotlib.pyplot as plt
import control as ctrl

# Parte 7.3.1 - Definir numerador y denominador para la función de transferencia
numerador = [1, 3]
denominador = [1, 5, 20, 16, 0]

# Calcular los polos y ceros
zeros_1 = np.roots(numerador)
polos = np.roots(denominador)

# Graficar polos y ceros
plt.figure()
v = [-6, 6, -6, 6]
plt.axis(v)
plt.gca().set_aspect('equal', adjustable='box')
plt.grid(True)

# Graficar ceros en verde y polos en rojo
plt.plot(np.real(zeros_1), np.imag(zeros_1), 'go', linewidth=2, label='Ceros')
plt.plot(np.real(polos), np.imag(polos), 'rx', linewidth=2, label='Polos')

# Parte 7.3.2 - Calcular ángulos de las asíntotas
k = np.array([0, 1, 2])
n = 4
m = 1
angulos_asintotas = 180 * (2 * k + 1) / (n - m)
print("Ángulos de las asíntotas:", angulos_asintotas)

# Parte 7.3.3 - Calcular el centroide
centroide = ((0 - 1 - 2 - 2) - (-3)) / (n - m)
plt.plot(centroide, 0, 'yo', linewidth=2, label='Centroide')

# Parte 7.3.4 - Graficar líneas de las asíntotas
x = np.arange(centroide, 6, 0.1)
y1 = np.sqrt(3) * (x - centroide)
y2 = -np.sqrt(3) * (x - centroide)
xa = np.arange(-6, centroide, 0.1)
ya = np.zeros(len(xa))

plt.plot(x, y1, 'k-.', label='Asíntotas')
plt.plot(x, y2, 'k-.')
plt.plot(xa, ya, 'k-.')

# Parte 7.3.6 - Determinar puntos de salida
s3 = -4.2376
s4 = -0.524
plt.plot(s4, 0, 'bs', linewidth=2, label='Puntos de salida')
plt.plot(s3, 0, 'bs', linewidth=2)

# Parte 7.3.7 - Puntos de cruce en el eje imaginario
cruce1 = 1j * 3.1409
cruce2 = -1j * 3.1409
plt.plot(0, np.imag(cruce1), 'ks', linewidth=2, label='Cruce en eje imaginario')
plt.plot(0, np.imag(cruce2), 'ks', linewidth=2)

# Configuración de la gráfica
plt.xlabel('Parte Real')
plt.ylabel('Parte Imaginaria')
plt.title('LGR')
plt.legend()
plt.grid(True)

# Parte 7.3.9 - Esbozo del Lugar de Raíces
sistema = ctrl.TransferFunction(numerador, denominador)
plt.figure()
ctrl.rlocus(sistema, xlim=(-6, 6), ylim=(-6, 6))
plt.title('Esbozo del Lugar de Raíces (LGR)')
plt.show()
