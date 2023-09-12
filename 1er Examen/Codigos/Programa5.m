%{
Programa de monitoreo de ventas: Este programa utiliza Octave y una base de
datos para monitorear las ventas de una empresa.
Ofrece opciones para agregar nuevos datos de ventas, generar informes sobre
las ventas y analizar los datos para encontrar patrones y tendencias de ventas.
%}


pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));


consulta=1;
reconsulta=1;
while consulta
try
fprintf("\n Bienvenido, que operación quiere realizar: \n \n")
disp("  1.Ingresar nuevos Pedido.")
disp("  2.Actualizar la información de un Pedido.")
disp("  3.Revisar un Pedido.")
disp("  4.Resumen de los Pedidos acumulados")
disp("  5.Eliminar un Pedido de la base de datos.")
disp("  6.Eliminar todos los Pedidos de la base de datos.")
disp("  7.Mostrar tendencia de ventas.")
fprintf("  8.Salir. \n \n")

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')


if(opciones==1)%1.Ingresar nuevos Pedido.

  i=1;
  while i
    inv=menu("Seleccione su Productos", "1) Arroz--------Q4", "2) Frijol--------Q3",...
      "3) Huevo(s)----Q1", "4) Tortilla(s)----Q0.25");
    if inv==1
      producto="Arroz";
      precio=4;
      i=0;
    elseif inv==2
      producto="Frijol";
      precio=3;
      i=0;
    elseif inv==3
      producto="Huevo(s)";
      precio=1;
      i=0;
    elseif inv==4
      producto="Tortilla(s)";
      precio=0.25;
      i=0;
    elseif inv==0
      fprintf("   No seleccciono ningun Producto \n")
      i=0;
    endif
  endwhile

  if(inv==0)

  else

  fprintf("Selecciono el Producto: %s \n", upper(producto));

  n=1;
  while n
    cliente=input("Ingrese Nombre del Cliente: ", 's');
    if any(isstrprop(cliente, 'digit')) % Verifica si la entrada contiene números
      fprintf("\n     Los Nombres no deben de contener numeros. Intenta de nuevo.\n \n");
      n=1;
    else
      n=0;
    endif
    if isempty(cliente)
      fprintf("\n     El cliente no puede estar vacío. Intenta de nuevo.\n \n");
      n=1;
    endif
  endwhile

  c=1;
  while c
    canti=  input("Ingrese la Cantidad del Producto: ", 's');
    numero = str2double(canti);
    if ~isnan(numero)
      cantidad=numero;
      c=0;
    else
      fprintf("\n     La Cantidad solo deben de ser numeros. Intenta de nuevo.\n \n");
      c=1;
    endif
  endwhile

  fprintf(' \n');

  query = sprintf("SELECT COUNT(*) FROM e1_programa4 WHERE Cliente='%s' AND Producto='%s'",...
    upper(cliente), upper(producto));
  rep = pq_exec_params(conn, query);
  if rep.data{1} == 0
    fprintf('Se agrego al carrito %d unidades del Producto: %s \n', cantidad, producto)
    fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

    query=sprintf("insert into E1_Programa4 (Cliente, Cantidad, Producto, Precio, Precio_Total) values ('%s','%d', '%s', '%d','%d')",...
      upper(cliente), upper(cantidad), upper(producto), upper(precio), upper(cantidad*precio));
    pq_exec_params(conn, query);
    fprintf(' \n')
  else
      disp('El usuario ya existe en la base de datos.');
  endif

  endif









elseif (opciones==2)%2.Actualizar la información de un Pedido.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');


    e=1;
    i=1;

  while e
    inv=menu("Producto a cambiar", "1) Arroz--Q4", "2) Frijol--Q3", "3) Huevo(s)--Q1",...
      "4) Tortilla(s)--Q0.25");
    if inv==1
      editar="Arroz";
      e=0;
    elseif inv==2
      editar="Frijol";
      e=0;
    elseif inv==3
      editar="Huevo(s)";
      e=0;
    elseif inv==4
      editar="Tortilla(s)";
      e=0;
    elseif inv==0
      e=0;
      i=0;
    endif
  endwhile

  if(inv~=0)
    fprintf("El Producto a cambiar es: %s \n", upper(editar));
  endif

  while i
    inv=menu("Seleccione su Nuevo Producto", "1) Arroz--------Q4", "2) Frijol--------Q3",...
      "3) Huevo(s)----Q1", "4) Tortilla(s)----Q0.25");
    if inv==1
      producto="Arroz";
      precio=4;
      i=0;
    elseif inv==2
      producto="Frijol";
      precio=3;
      i=0;
    elseif inv==3
      producto="Huevo(s)";
      precio=1;
      i=0;
    elseif inv==4
      producto="Tortilla(s)";
      precio=0.25;
      i=0;
    elseif inv==0
      i=0;
    endif
  endwhile

  if(inv~=0)
    fprintf("El Nuevo Producto es: %s \n \n", upper(producto));
  endif

  if(inv==0)
    fprintf("   No seleccciono ningun Producto \n")

  else

  n=1;
  while n
    cliente=input("Ingrese Nombre del Cliente: ", 's');
    if any(isstrprop(cliente, 'digit')) % Verifica si la entrada contiene números
      fprintf("\n     Los Nombres no deben de contener numeros. Intenta de nuevo.\n \n");
      n=1;
    else
      n=0;
    endif
    if isempty(cliente)
      fprintf("\n     El cliente no puede estar vacío. Intenta de nuevo.\n \n");
      n=1;
    endif
  endwhile

  c=1;
  while c
    canti=  input("Ingrese la Cantidad del Producto: ", 's');
    numero = str2double(canti);
    if ~isnan(numero)
      cantidad=numero;
      c=0;
    else
      fprintf("\n     La Cantidad solo deben de ser numeros. Intenta de nuevo.\n \n");
      c=1;
    endif
  endwhile

  fprintf(' \n');
  fprintf('Se agrego al carrito %d unidades del Producto: %s \n', cantidad, producto)
  fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

  query = sprintf("update E1_Programa4 set Cliente='%s', Cantidad='%d', Producto='%s', Precio='%d',  Precio_Total='%d' where Cliente=('%s') AND Producto = ('%s');", ...
    upper(cliente), upper(cantidad), upper(producto), upper(precio), upper(cantidad*precio), upper(cliente), upper(editar));
  pq_exec_params(conn, query);

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');


  endif








elseif (opciones==3)%3.Revisar un Pedido.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');


  if(tama>0)

    cliente=input("Nombre Cliente: ", 's');

    fprintf(' \n');

    query = sprintf("select * from E1_Programa4 where Cliente=('%s')", ...
      upper(cliente));
    Historial_Estudiante=pq_exec_params(conn, query);

    datos = Historial_Estudiante.data;
    tama=size(datos, 1);

    fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
    for i = 1:size(datos, 1)
      Cliente = datos{i, 1};
      Cantidad = datos{i, 2};
      Producto = datos{i, 3};
      Precio = datos{i, 4};
      Precio_Total = datos{i, 5};
      fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
    end
  fprintf(' \n');

  else
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif
  fprintf(' \n');









elseif (opciones==4)%4.Resumen de los Pedidos acumulados.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif

  fprintf(' \n');

  query = 'select sum(Cantidad) from E1_Programa4';
  resultado = pq_exec_params(conn, query);
  valor_data = resultado.data{1};
  fprintf('El total de los Productos Pendientes es: %d \n', valor_data)

  query = 'select sum(Precio_Total) from E1_Programa4';
  total = pq_exec_params(conn, query);
  valor_t = total.data{1};
  fprintf('El total de la ganacia bruta es: Q%d \n', valor_t)









elseif (opciones==5)%5.Eliminar un Producto de la base de datos.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")

  else
  fprintf(' \n');

  i=1;
  while i
    inv=menu("Producto a Eliminar", "1) Arroz--------Q4", "2) Frijol--------Q3",...
      "3) Huevo(s)----Q1", "4) Tortilla(s)----Q0.25");
    if inv==1
      producto="Arroz";
      precio=4;
      i=0;
    elseif inv==2
      producto="Frijol";
      precio=3;
      i=0;
    elseif inv==3
      producto="Huevo(s)";
      precio=1;
      i=0;
    elseif inv==4
      producto="Tortilla(s)";
      precio=0.25;
      i=0;
    elseif inv==0
      fprintf("   No seleccciono ningun Producto \n")
      i=0;
    endif
  endwhile

  cliente=input("Nombre Cliente: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar el Producto?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa4 where Cliente=('%s') AND Producto =('%s')",...
    upper(cliente), upper(producto));
    pq_exec_params(conn, query);
    fprintf('El Producto fue Eliminado. \n');
  endif

  fprintf(" \n");

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa4;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-15s %-10s %-15s %-10s %-15s\n', 'Cliente', 'Cantidad', 'Producto', 'Precio', 'Precio Total');
  for i = 1:size(datos, 1)
    Cliente = datos{i, 1};
    Cantidad = datos{i, 2};
    Producto = datos{i, 3};
    Precio = datos{i, 4};
    Precio_Total = datos{i, 5};
    fprintf('%-15s %-10d %-15s %-10d %-15d\n', Cliente, Cantidad, Producto, Precio, Precio_Total);
  end
  fprintf(' \n');

  endif









elseif (opciones==6)%6.Eliminar todos los Productos de la base de datos.
  seguro=yes_or_no("¿Seguro que quiere eliminar todos los Productos?");
  if(seguro==1)
    Borrar_Tabla=pq_exec_params(conn, "delete from E1_Programa4;");
    fprintf('Todos los Productos fueron eliminados. \n');
  endif









elseif (opciones==7)
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

  fprintf("Venta de ARROZ total: %d\n", a);
  fprintf("Venta de FRIJOL total:%d\n", f);
  fprintf("Venta de HUEVO(S) total:%d\n", h);
  fprintf("Venta de TORTILLA(S) total:%d\n\n", t);

  categorias = {'ARROZ', 'FRIJOL', 'HUEVO(S)', 'TORTILLA'};
  valores = [a, f, h, t];
  bar(valores);
  set(gca, 'XTickLabel', categorias);
  xlabel('Productos');
  ylabel('Cantidades');
  title('Tendencia de ventas');









elseif (opciones==8)% 7.Salir.
  fprintf("El programa a finalizado")
  consulta=0;
  reconsulta=0;


else
  fprintf("No selecciono ninguna Opcion valida. \n\n")

endif


fprintf(' \n')


if(reconsulta==1)% Reconsulta
  consulta=yes_or_no("¿Quieres realizar otra operacion: ");
endif


catch
 fprintf(" \n")
 fprintf("    ¡Error! El dato que ingreso no es aceptado. Vuelva a intentarlo.\n \n");
end_try_catch


endwhile

fprintf(' \n \n')
