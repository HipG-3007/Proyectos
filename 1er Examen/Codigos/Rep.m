% Supongamos que tienes una conexión establecida llamada 'conexion'

pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));




% Datos ingresados por el usuario
nombre = 'Transistores';
email = 150;

% Realizamos una consulta para verificar si ya existen registros con los mismos datos
query = sprintf("SELECT COUNT(*) FROM e1_programa2 WHERE Gasto='%s' AND Precio='%d'", nombre, email);

rep = pq_exec_params(conn, query);


if rep.data{1} == 0
    disp('El usuario no existe en la base de datos.');
else
    disp('El usuario ya existe en la base de datos.');
endif


%{
resultado = fetch(cursor);

% Cerramos el cursor
close(cursor);

% Verificamos el resultado

%}
