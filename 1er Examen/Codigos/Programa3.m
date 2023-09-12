%{
Programa de gestión de inventario: Este programa utiliza Octave y una base de
datos para gestionar un inventario de productos. Ofrece opciones para agregar
nuevos productos, actualizar la información de los productos existentes y eliminar
productos que ya no se necesiten.
%}

pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));

consulta=1;
reconsulta=1;
while consulta
try
fprintf("\n Bienvenido, que operación quiere realizar: \n \n")
disp("  1.Ingresar nuevos Productos.")
disp("  2.Actualizar la información de los productos.")
disp("  3.Revisar un Producto.")
disp("  4.Resumen de los Producto acumulados")
disp("  5.Eliminar un Producto de la base de datos.")
disp("  6.Eliminar todos los Productos de la base de datos.")
fprintf("  7.Salir. \n \n")

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')









if(opciones==1)%1.Ingresar nuevos Productos.

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

  pro=1;
  while pro
    producto=  input("Ingrese el nombre del Producto: ", 's');
    if isempty(producto)
      fprintf("\n     El nombre del Producto no puede estar vacío. Intenta de nuevo.\n \n");
      pro=1;
    else
      pro=0;
    endif
  endwhile

  p=1;
  while p
    prec= input("Ingrese el Precio del Producto:", 's');
    numero = str2double(prec);
    if ~isnan(numero)
      precio=numero;
      p=0;
    else
      fprintf("\n     El Precio solo deben de ser numeros. Intenta de nuevo.\n \n");
      p=1;
    endif
  endwhile

  fprintf(' \n');
  fprintf('Se agrego al Inventario %d unidades del Producto: %s \n', cantidad, producto)
  fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

  query=sprintf("insert into E1_Programa3 (Cantidad, Producto, Precio, Precio_Total) values ('%d', '%s', '%f','%f')",...
    upper(cantidad),upper(producto),upper(precio),upper(cantidad*precio));
  pq_exec_params(conn, query);









elseif (opciones==2)%2.Actualizar la información de los productos.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  if(tama>0)
  edit=1;
  while edit
    editar= input("Ingrese el Nombre del Producto a editar: ", 's');
    if isempty(editar)
      fprintf("\n     El Producto a Editar no puede estar vacío. Intenta de nuevo.\n \n");
      edit=1;
    else
      edit=0;
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

  pro=1;
  while pro
    producto=  input("Ingrese el nombre del Producto: ", 's');
    if isempty(producto)
      fprintf("\n     El nombre del Producto no puede estar vacío. Intenta de nuevo.\n \n");
      pro=1;
    else
      pro=0;
    endif
  endwhile

  p=1;
  while p
    prec= input("Ingrese el Precio del Producto:", 's');
    numero = str2double(prec);
    if ~isnan(numero)
      precio=numero;
      p=0;
    else
      fprintf("\n     El Precio solo deben de ser numeros. Intenta de nuevo.\n \n");
      p=1;
    endif
  endwhile

  fprintf(' \n');

  query = sprintf("SELECT COUNT(*) FROM e1_programa3 WHERE Cantidad='%d' AND Producto='%s' AND Precio='%d' AND Precio_Total='%d'",...
    upper(cantidad),upper(producto),upper(precio),upper(cantidad*precio));
  rep = pq_exec_params(conn, query);

  if rep.data{1} == 0

    fprintf(' \n');
    fprintf('Se agrego al Inventario %d unidades del Producto: %s \n', cantidad, producto)
    fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

    query = sprintf("update E1_Programa3 set Cantidad='%d', Producto='%s', Precio='%d',  Precio_Total='%d' where Producto = ('%s');", ...
      upper(cantidad),upper(producto),upper(precio),upper(cantidad*precio), upper(editar));
    pq_exec_params(conn, query);
    fprintf(' \n')

  else
      fprintf("El Gasto ya existe en la base de datos. \n\n");
  endif

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  else
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif









elseif (opciones==3)%3.Revisar un Producto.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  if(tama>0)
    revisar=input("Nombre del Producto a Revisar: ", 's');
    fprintf(' \n');
    query = sprintf("select * from E1_Programa3 where Producto =('%s')", ...
      upper(revisar));
    Historial_Producto=pq_exec_params(conn, query);

    dato1= Historial_Producto.data{1};
    dato2= Historial_Producto.data{2};
    dato3= Historial_Producto.data{3};
    dato4= Historial_Producto.data{4};

    disp(['Cantidad del Producto: ', num2str(dato1)])
    disp(['Nombre del Producto: ', dato2])
    fprintf('Precio Unitario del Producto: Q%d. \n', dato3)
    fprintf('Precio Total del Producto: Q%d. \n', dato4)

  else
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif
  fprintf(' \n');









elseif (opciones==4)%4.Resumen de los Producto acumulados

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif

  fprintf(' \n');

  query = 'select sum(Cantidad) from E1_Programa3';
  resultado = pq_exec_params(conn, query);
  valor_data = resultado.data{1};
  fprintf('El total de los Productos es: %d \n', valor_data)

  query = 'select sum(Precio_Total) from E1_Programa3';
  total = pq_exec_params(conn, query);
  valor_t = total.data{1};
  fprintf('El total del Inventario es: Q%d \n', valor_t)









elseif (opciones==5)%5.Eliminar un Producto de la base de datos.
  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")

  else
  fprintf(' \n');

  producto=input("Nombre del Producto a Eliminar: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar el Producto?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa3 where Producto =('%s')", upper(producto));
    pq_exec_params(conn, query);
    fprintf('El Producto fue Eliminado. \n');
  endif

  fprintf(" \n");

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa3;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-10s %-15s %-10s %-15s\n', 'Cantidad', 'Producto', 'Precio', 'Precio_Total');
  for i = 1:size(datos, 1)
    cantidad = datos{i, 1};
    producto = datos{i, 2};
    precio = datos{i, 3};
    precio_total = datos{i, 4};
    fprintf('%-10d %-15s %-10d %-15d\n', cantidad, producto, precio, precio_total);
  end

  fprintf(' \n');

  endif










elseif (opciones==6)%6.Eliminar todos los Productos de la base de datos.
  seguro=yes_or_no("¿Seguro que quiere eliminar todos los Productos?");
  if(seguro==1)
    Borrar_Tabla=pq_exec_params(conn, "delete from E1_Programa3;");
    fprintf('Todos los Productos fueron eliminados. \n');
  endif









elseif (opciones==7)% 7.Salir.
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

