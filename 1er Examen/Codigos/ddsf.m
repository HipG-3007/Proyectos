pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));




  query = sprintf("select Cantidad  from E1_Programa4 where Producto='ARROZ'");
  Historial_Estudiante=pq_exec_params(conn, query);
  d1 = Historial_Estudiante.data;
  a = sum(cell2mat(d1));

  query = sprintf("select Cantidad  from E1_Programa4 where Producto='FRIJOL'");
  Historial_Estudiante=pq_exec_params(conn, query);
  d2 = Historial_Estudiante.data;
  f = sum(cell2mat(d2));

  query = sprintf("select Cantidad  from E1_Programa4 where Producto='HUEVO(S)'");
  Historial_Estudiante=pq_exec_params(conn, query);
  d3 = Historial_Estudiante.data;
  h = sum(cell2mat(d3));

  query = sprintf("select Cantidad  from E1_Programa4 where Producto='TORTILLA(S)'");
  Historial_Estudiante=pq_exec_params(conn, query);
  d4 = Historial_Estudiante.data;
  t = sum(cell2mat(d4));



  categorias = {'ARROZ', 'FRIJOL', 'HUEVO(S)', 'TORTILLA'};
  valores = [a, f, h, t];
  bar(valores);
  set(gca, 'XTickLabel', categorias);
  xlabel('Productos');
  ylabel('Cantidades');
  title('Tendencia de ventas');

