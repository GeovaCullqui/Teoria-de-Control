# ============================
# BLOQUE 1: Importación de librerías
# ============================
import matplotlib.pyplot as plt
import control as ctrl  # Librería de control para sistemas LTI

# ============================
# BLOQUE 2: Parámetros del circuito RLC
# ============================
R = 100         # Resistencia en ohmios
L = 0.1         # Inductancia en henrios
Cap = 1e-6      # Capacitancia en faradios

# Definición de la función de transferencia del circuito RLC
DEN1 = [1, (R / L), 1 / (L * Cap)]         # Denominador de G(s)
NUM1 = [1 / (L * Cap)]                     # Numerador de G(s)

# ============================
# BLOQUE 3: Parámetros del controlador PID
# ============================
Kp = 1         # Ganancia proporcional
Ki = 1000      # Ganancia integral
Kd = 0.001     # Ganancia derivativa

# ============================
# BLOQUE 4: Construcción del controlador PID
# ============================

# Parte proporcional del PID
BloqueProporcional = ctrl.TransferFunction([Kp], [1])

# Parte integral del PID
BloqueIntegral = ctrl.TransferFunction([Ki], [1, 0])  # 1/s

# Parte derivativa del PID (implementación con filtro de alta frecuencia)
N = 10000  # Factor de filtrado
derivativo = ctrl.TransferFunction([1], [1, 0])  # s
sub1_derivativo = ctrl.feedback(ctrl.TransferFunction([N], [1]), derivativo)  # N / (s + N)
derivativo_total = Kd * sub1_derivativo

# Controlador PID total: suma de los tres componentes
Pid_total = BloqueProporcional + BloqueIntegral + derivativo_total

# ============================
# BLOQUE 5: Modelo del sistema completo
# ============================

# Función de transferencia del circuito RLC
Rlc_Func = ctrl.TransferFunction(NUM1, DEN1)

# Sistema en lazo abierto: PID en serie con planta RLC
G_S = ctrl.series(Pid_total, Rlc_Func)

# Realimentación unitaria
H_S = 1
SistemaTotal = ctrl.feedback(G_S, H_S)  # Sistema en lazo cerrado

# ============================
# BLOQUE 6: Análisis de estabilidad
# ============================

# Obtener y mostrar los polos del sistema
polos = ctrl.poles(SistemaTotal)
print("Polos del sistema en lazo cerrado:")
print(polos)

# ============================
# BLOQUE 7: Visualización
# ============================

# Respuesta al escalón
plt.figure()
t, y = ctrl.step_response(SistemaTotal)
plt.plot(t, y)
plt.title('Respuesta al Escalón del Sistema en Lazo Cerrado')
plt.xlabel('Tiempo (s)')
plt.ylabel('Amplitud')
plt.grid(True)

# Diagrama de polos y ceros
plt.figure()
ctrl.pzmap(SistemaTotal, plot=True, grid=True)
plt.title('Diagrama de Polos y Ceros del Sistema en Lazo Cerrado')

# Mostrar todas las gráficas
plt.show()
