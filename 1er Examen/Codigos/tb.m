pkg load database

% Establecer conexión a la base de datos
db = database('postgresql', '0980 Proyectos', 'usuario', '202001466', 'localhost');

% Ejecutar una consulta SQL para seleccionar todos los registros de una tabla
sql = 'SELECT * FROM nombre_tabla';
data = sql_query(db, sql);

% Mostrar la tabla
disp(data);

% Cerrar la conexión
close(db);
