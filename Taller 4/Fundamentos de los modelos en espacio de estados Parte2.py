import numpy as np
import matplotlib.pyplot as plt
import control as ctrl
from scipy.integrate import solve_ivp

# === PARÁMETROS DEL CIRCUITO RLC ===
R = 100       # Ohmios
L = 0.1       # Henrios
C = 1e-6      # Faradios

# === MATRICES DEL SISTEMA EN ESPACIO DE ESTADOS ===
A = np.array([[0, 1],
              [-1/(L*C), -R/L]])
B = np.array([[0],
              [1/L]])
C_mat = np.array([[1/C, 0]])
D = np.array([[0]])

# === DEFINIR SISTEMA USANDO CONTROL (OPCIONAL) ===
system = ctrl.ss(A, B, C_mat, D)  # Se usa para consistencia con el reto

# === FUNCIÓN DEL MODELO EN ESPACIO DE ESTADOS ===
def modelRLC(t, x, A, B, u):
    dxdt = A @ x + B.flatten() * u
    return dxdt

# === PARÁMETROS DE SIMULACIÓN ===
x0 = [0, 0]             # Condiciones iniciales
u = 1                   # Entrada constante (escalón)
t_eval = np.linspace(0, 0.015, 1000)  # 15 ms

# === RESOLVER CON SOLVE_IVP ===
sol = solve_ivp(modelRLC, [t_eval[0], t_eval[-1]], x0,
                args=(A, B, u), t_eval=t_eval, method='RK45')

# === CALCULAR LA SALIDA ===
X = sol.y.T  # Transpuesta: (1000, 2)
y = C_mat @ X.T + D * u  # Salida: (1, 1000)

# === GRAFICAR RESULTADO ===
plt.plot(t_eval, y[0])
plt.title('Respuesta al Escalón usando control + scipy')
plt.xlabel('Tiempo [s]')
plt.ylabel('Vc [V]')
plt.grid(True)
plt.tight_layout()
plt.show()
