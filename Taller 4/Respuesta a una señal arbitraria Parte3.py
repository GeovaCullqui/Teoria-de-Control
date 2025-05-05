import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import control as ctrl
from scipy.integrate import solve_ivp

# === PARÁMETROS DEL CIRCUITO RLC ===
R = 100
L = 0.1
C = 1e-6

A = np.array([[0, 1],
              [-1/(L*C), -R/L]])
B = np.array([[0],
              [1/L]])
C_mat = np.array([[1/C, 0]])
D = np.array([[0]])

# === DEFINIR SISTEMA CON CONTROL (opcional) ===
system = ctrl.ss(A, B, C_mat, D)

# === FUNCIÓN DINÁMICA ===
def modelRLC(t, x, A, B, u):
    return A @ x + B.flatten() * u

# === CARGAR SEÑAL ARBITRARIA DESDE CSV ===
data = pd.read_csv("entrada_arbitraria.csv")
t_signal = data["tiempo"].values
u_signal = data["u"].values
n = len(t_signal)

# === INICIALIZACIÓN ===
X = np.zeros((n, 2))
X[0] = [0, 0]

# === SIMULACIÓN TRAMO A TRAMO (con precisión mejorada) ===
for k in range(1, n):
    t_seg = [t_signal[k-1], t_signal[k]]
    sol = solve_ivp(modelRLC, t_seg, X[k-1],
                    args=(A, B, u_signal[k]),
                    method='RK45', max_step=(t_seg[1] - t_seg[0])/10)
    X[k] = sol.y[:, -1]  # solo último valor para continuidad

# === CALCULAR SALIDA ===
y = C_mat @ X.T + D * u_signal

# === GRAFICAR ENTRADA Y SALIDA SUPERPUESTAS ===
plt.figure(figsize=(10, 5))
plt.plot(t_signal, u_signal, label='Entrada u(t)', color='blue', linestyle='--')
plt.plot(t_signal, y[0], label='Salida Vc(t)', color='red')
plt.title('Respuesta del sistema RLC a señal arbitraria')
plt.xlabel('Tiempo [s]')
plt.ylabel('Voltaje [V]')
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()

