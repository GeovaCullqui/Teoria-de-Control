import numpy as np
import matplotlib.pyplot as plt
import control as ctrl  # Librería principal para sistemas dinámicos

# === PARÁMETROS DEL CIRCUITO RLC ===
R = 100       # Ohmios
L = 0.1       # Henrios
C = 1e-6      # Faradios

# === MATRICES DEL SISTEMA EN ESPACIO DE ESTADOS ===
A = np.array([[0, 1],
              [-1/(L*C), -R/L]])
B = np.array([[0],
              [1/L]])
C_mat = np.array([[1/C, 0]])  # Salida: Vc = q / C
D = np.array([[0]])

# === CREACIÓN DEL SISTEMA EN ESPACIO DE ESTADOS ===
system = ctrl.ss(A, B, C_mat, D)

# === TIEMPO DE SIMULACIÓN ===
t = np.linspace(0, 0.015, 1000)  # 15 ms

# === RESPUESTA AL ESCALÓN ===
t_step, y_step = ctrl.step_response(system, T=t)

# === RESPUESTA AL IMPULSO ===
t_imp, y_imp = ctrl.impulse_response(system, T=t)

# === GRAFICAR RESULTADOS ===
plt.figure(figsize=(10, 6))

# Escalón
plt.subplot(2, 1, 1)
plt.plot(t_step, y_step)
plt.title('Respuesta al Escalón')
plt.xlabel('Tiempo [s]')
plt.ylabel('Vc [V]')
plt.grid(True)

# Impulso
plt.subplot(2, 1, 2)
plt.plot(t_imp, y_imp)
plt.title('Respuesta al Impulso')
plt.xlabel('Tiempo [s]')
plt.ylabel('Vc [V]')
plt.grid(True)

plt.tight_layout()
plt.show()
