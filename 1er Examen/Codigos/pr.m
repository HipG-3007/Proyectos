


pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));


query = 'select sum(Precio) from E1_Programa2';

resultado = pq_exec_params(conn, query);

valor_data = resultado.data{1}

%primer_elemento = resultado{2}

% Obtener el resultado de la suma
%suma = resultado(1, 1);


% El resultado se encuentra en la primera fila de la primera columna

% Mostrar la suma



