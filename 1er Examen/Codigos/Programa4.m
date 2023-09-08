%{
Programa de seguimiento de pedidos: Este programa utiliza Octave y una base de
datos para realizar un seguimiento de los pedidos de los clientes.
Ofrece opciones para agregar nuevos pedidos, actualizar la información de los
pedidos existentes y eliminar pedidos que ya se hayan completado.
%}

pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));


consulta=1;
reconsulta=1;
while consulta
try
disp('Bienvenido, que operación quiere realizar:')
disp('  1.Ingresar nuevos Pedido.')
disp('  2.Actualizar la información de un Pedido.')
disp('  3.Revisar un Pedido.')
disp('  4.Resumen de los Pedidos acumulados')
disp('  5.Eliminar un Pedido de la base de datos.')
disp('  6.Eliminar todos los Pedidos de la base de datos.')
fprintf('  7.Salir. \n \n')

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')


if(opciones==1)%1.Ingresar nuevos Pedido.
  cliente=  input("Ingrese el Nombre del Cliente: ", 's');

  i=1;
  while i
    inv=Inventario("Productos", "1) Arroz--Q4", "2) Frijol--Q3", "3) Huevo(s)--Q1",...
      "4) Tortilla(s)--Q0.25");
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
      fprintf("No seleccciono ningun Producto")
      i=1;
    endif
  endwhile

  fprintf("El producto seleccionado fue %s: \n", producto);
  cantidad=  input("Ingrese la Cantidad del Producto: ");
  fprintf(' \n');
  fprintf('Se agrego al carrito %d unidades del Producto: %s \n', cantidad, producto)
  fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

  query=sprintf("insert into E1_Programa4 (Cliente, Cantidad, Producto, Precio, Precio_Total) values ('%s','%d', '%s', '%d','%d')",...
    cliente, cantidad,producto,precio,cantidad*precio);
  pq_exec_params(conn, query);



elseif (opciones==2)%2.Actualizar la información de un Pedido.

    e=1;
  while i
    inv=Seleccione El Producto a cambiar("Productos", "1) Arroz--Q4", "2) Frijol--Q3", "3) Huevo(s)--Q1",...
      "4) Tortilla(s)--Q0.25");
    if inv==1
      editar="Arroz";
      precio=4;
      e=0;
    elseif inv==2
      producto="Frijol";
      editar=3;
      e=0;
    elseif inv==3
      producto="Huevo(s)";
      editar=1;
      e=0;
    elseif inv==4
      producto="Tortilla(s)";
      editar=0.25;
      e=0;
    elseif inv==0
      fprintf("No seleccciono ningun Producto")
      e=1;
    endif
  endwhile

  i=1;
  while i
    inv=Seleccione El Nuevo Producto("Productos", "1) Arroz--Q4", "2) Frijol--Q3", "3) Huevo(s)--Q1",...
      "4) Tortilla(s)--Q0.25");
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
      fprintf("No seleccciono ningun Producto")
      i=1;
    endif
  endwhile

  fprintf("El Nuevo producto seleccionado fue %s: \n", producto);
  cantidad=  input("Ingrese la Cantidad del Producto: ");
  fprintf(' \n');
  fprintf('Se agrego al carrito %d unidades del Producto: %s \n', cantidad, producto)
  fprintf('Con un precio Unitario de Q%d y un Precio Total de Q%d \n \n', precio, cantidad*precio)

  query = sprintf("update E1_Programa4 set Cantidad='%d', Producto='%s', Precio='%d',  Precio_Total='%d' where Producto = ('%s');", ...
    cantidad,producto,precio,cantidad*precio, editar);
  pq_exec_params(conn, query);



elseif (opciones==3)%3.Revisar un Pedido.
  revisar=input("Nombre del Producto a Revisar: ", 's');
  fprintf(' \n');
  query = sprintf("select * from E1_Programa3 where Producto =('%s')", ...
    revisar);
  Historial_Producto=pq_exec_params(conn, query);

  dato1= Historial_Producto.data{1};
  dato2= Historial_Producto.data{2};
  dato3= Historial_Producto.data{3};
  dato4= Historial_Producto.data{4};

  disp(['Cantidad del Producto: ', num2str(dato1)])
  disp(['Nombre del Producto: ', dato2])
  fprintf('Precio Unitario del Producto: Q%d. \n', dato3)
  fprintf('Precio Total del Producto: Q%d. \n', dato4)


elseif (opciones==4)%4.Resumen de los Pedidos acumulados.
  Historial_Postgresql=pq_exec_params(conn, 'select * from E1_Programa3;')

  query = 'select sum(Cantidad) from E1_Programa3';
  resultado = pq_exec_params(conn, query);
  valor_data = resultado.data{1};
  fprintf('El total de los Productos es: %d \n', valor_data)

  query = 'select sum(Precio_Total) from E1_Programa3';
  total = pq_exec_params(conn, query);
  valor_t = total.data{1};
  fprintf('El total del Inventario es: Q%d \n', valor_t)


elseif (opciones==5)%5.Eliminar un Producto de la base de datos.
  producto=input("Nombre del Producto a Eliminar: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar el Producto?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa3 where Producto =('%s')", producto);
    pq_exec_params(conn, query);
    fprintf('El Producto fue Eliminado. \n');
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


