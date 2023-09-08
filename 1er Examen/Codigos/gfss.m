while true
    entrada = input('Ingresa una letra: ', 's'); % 's' indica que se espera una cadena

    if isempty(entrada) % Verifica si no se ingresó nada
        fprintf('No ingresaste nada. Intenta de nuevo.\n');
        continue; % Salta al inicio del bucle sin ejecutar el código restante
    end

    if any(isstrprop(entrada, 'digit')) % Verifica si la entrada contiene números
        fprintf('Error: Ingresaste un número. Intenta de nuevo.\n');
        continue; % Salta al inicio del bucle sin ejecutar el código restante
    end

    % Si llegamos aquí, significa que la entrada es solo letras
    fprintf('Ingresaste la letra: %s\n', entrada);
    break; % Rompe el bucle si se ingresa una letra válida
end
