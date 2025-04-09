import numpy as np
import matplotlib.pyplot as plt
import control as ctl

# Tiempo de muestreo y vector de tiempo
ts = 0.1
t = np.arange(0, 40 + ts, ts)
N = len(t)
sizeV = int(N / 4)

# Señal de entrada con rampas y escalones
s1 = np.linspace(0, 10, sizeV)               # Rampa ascendente
s2 = np.ones(sizeV) * 20                     # Escalón constante
s3 = np.linspace(15, 10, sizeV)              # Rampa descendente
s4 = np.ones(sizeV + 1) * 5                  # Escalón bajada
arbsig = np.concatenate((s1, s2, s3, s4))

# Función de transferencia sin retardo
num = [3]
den = [1, 2, 3]
G = ctl.TransferFunction(num, den)

# Retardo: 3 segundos usando Padé (orden 1)
delay = 2
num_d, den_d = ctl.pade(delay, 1)
delay_tf = ctl.TransferFunction(num_d, den_d)

# Sistema con retardo aproximado
G_delay = G * delay_tf

# Simulación
t_out, y_out = ctl.forced_response(G_delay, T=t, U=arbsig)

# Graficar entrada y salida
plt.figure(figsize=(10, 5))
plt.plot(t, arbsig, label='Señal de entrada', linewidth=2)
plt.plot(t_out, y_out, label='Respuesta del sistema con retardo', linewidth=2)
plt.title('Respuesta del sistema G(s)')
plt.xlabel('Tiempo [s]')
plt.ylabel('Amplitud')
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()
