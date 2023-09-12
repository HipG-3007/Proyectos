pkg load database

% Establecer conexión a la base de datos
conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost','port','5432','user','postgres', 'password','202001466'));

% Ejecutar la consulta
Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
datos = Historial_Postgresql.data;

fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
for i = 1:size(datos, 1)
  cantidad = datos{i, 1};
  producto = datos{i, 2};
  precio = datos{i, 3};
  precio_total = datos{i, 4};
  fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
end
