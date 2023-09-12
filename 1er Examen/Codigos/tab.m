pkg load database

% Establecer conexión a la base de datos
conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost','port','5432','user','postgres', 'password','202001466'));

% Ejecutar la consulta
Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
datos = Historial_Postgresql.data

%{
% Imprimir los resultados en forma de tabla
fprintf('%-15s %-10s\n', 'Componente', 'Cantidad');
for i = 1:size(datos, 1)
    componente = datos{i}(1);
    cantidad = datos{i}(2);
    fprintf('%-15s %-10d\n', componente, cantidad);
end

% Cerrar la conexión
pq_close(conn);


% Imprimir los datos como una tabla
fprintf('%-15s %-10s\n', 'Columna 1', 'Columna 2');
for i = 1:size(datos, 1)
    fprintf('%-15d %-10d\n', datos(i, 1), datos(i, 2));
end
%}

fprintf('%-15s %-10s\n', 'Componente', 'Cantidad');
for i = 1:size(datos, 1)
    componente = datos{i, 1};
    cantidad = datos{i, 2};
    fprintf('%-15s %-10d\n', componente, cantidad);
end
