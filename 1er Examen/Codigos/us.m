pkg load psql

% Establecer conexión a la base de datos
conn = psql_dbconn('dbname=0980 Proyectos user=postgresql password=202001466 host=localhost port=5432');

% Verificar si la conexión fue exitosa
if (conn.status != 0)
    error('Error al conectar a la base de datos');
else
    disp('Conexión exitosa');
end
