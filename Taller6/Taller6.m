function routh_hurwitz(coeffs)
    % Routh-Hurwitz para determinar estabilidad de un sistema
    % coeffs: vector fila con los coeficientes del polinomio característico

    if length(coeffs) < 2
        error('Debe haber al menos dos coeficientes.');
    end

    n = length(coeffs);         % Grado del polinomio
    m = ceil(n / 2);            % Columnas necesarias en la tabla

    routh = zeros(n, m);        % Inicialización de la tabla

    % Primera y segunda fila
    routh(1, :) = coeffs(1:2:end);
    if length(coeffs) > 1
        routh(2, 1:length(coeffs(2:2:end))) = coeffs(2:2:end);
    end

    % Llenado de la tabla
    for i = 3:n
        for j = 1:m-1
            a = routh(i-1, 1);
            b = routh(i-2, 1);
            c = routh(i-1, j+1);
            d = routh(i-2, j+1);

            if a == 0
                a = 1e-6;  % evitar división por cero
            end

            routh(i, j) = ((a * d) - (b * c)) / a;
        end

        % Si toda la fila es cero, se usa el método auxiliar
        if all(abs(routh(i, :)) < 1e-6)
            disp('Fila de ceros detectada. Aplicando método auxiliar...');
            order = n - i + 1;
            aux = routh(i-1, :);
            deriv = polyder(aux);
            routh(i, 1:length(deriv)) = deriv;
        end
    end

    % Etiquetas de las potencias de s
    s_labels = cell(n, 1);
    for i = 1:n
        s_labels{i} = sprintf('s^%d', n - i);
    end

    % Mostrar tabla
    fprintf('\nTabla de Routh-Hurwitz:\n');
    col_headers = ['     s     ', arrayfun(@(x) sprintf('Col %d    ', x), 1:m, 'UniformOutput', false)];
    fprintf('%s\n', strjoin(col_headers, ' | '));
    fprintf('%s\n', repmat('-', 1, 15 + m * 10));

    for i = 1:n
        row_str = sprintf('%8s |', s_labels{i});
        for j = 1:m
            row_str = [row_str, sprintf(' %9.4f |', routh(i,j))];
        end
        disp(row_str);
    end

    % Análisis de estabilidad
    first_col = routh(:, 1);
    sign_changes = sum(sign(first_col(1:end-1)) ~= sign(first_col(2:end)));

    if any(isnan(first_col)) || any(isinf(first_col))
        disp('⚠️ La tabla contiene valores infinitos o indefinidos.');
    elseif sign_changes == 0
        disp('✅ El sistema es ESTABLE (todas las raíces con parte real negativa).');
    else
        fprintf('El sistema es INESTABLE');
    end
end

% Establecemos las funciones del sistema (Datos)
G1 = tf(3,[1 0]);
G2 = tf(1,[1 0 1]);
H1 = 3;

%**************************************************************************
%             Funcion de Transferencia del sistema (Gs)
%**************************************************************************
G1G2 = series(G1,G2);       % Creamos la funcion en serie
Gs= feedback(G1G2 , H1);     % Hacemos la operacion para el lazo cerrado

%**************************************************************************
%                      Criterio de Routh Hurwitz
%**************************************************************************
% Separamos el denominador y el numerador de la Gs
numerador = Gs.num{1};
denominador = Gs.den{1};
routh_hurwitz([denominador]);


%**************************************************************************
%              Codigo de la Respuesta al Escalón del Sistema
%**************************************************************************
step(Gs);
title('Respuesta al Escalón del Sistema');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


%**************************************************************************
%                   Codigo de diagrama de Polos y Ceros 
%**************************************************************************
disp('Polos del sistema:');
disp(pole(Gs));
disp('Ceros del sistema:');
disp(zero(Gs));

% Graficar el diagrama de polos y ceros
figure;
pzmap(Gs);
grid on;
title('Diagrama de Polos y Ceros (PZ Map)');

