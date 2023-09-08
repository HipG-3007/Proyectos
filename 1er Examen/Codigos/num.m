while true
    entrada = input('Ingresa un número: ', 's');
    numero = str2double(entrada);
    if ~isnan(numero)
        disp(['Has ingresado el número: ', num2str(numero)]);
        break;
    else
        disp('Entrada no válida. Por favor, ingresa un número.');
    end
end
