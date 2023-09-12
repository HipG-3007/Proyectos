pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));




  query = sprintf("select Cantidad  from E1_Programa4 where Producto='TORTILLA(S)'");
  Historial_Estudiante=pq_exec_params(conn, query);
  datos = Historial_Estudiante.data;
  suma = sum(cell2mat(datos));



