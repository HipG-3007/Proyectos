%{
Programa de seguimiento de presupuesto personal: Este programa utiliza Octave y
una base de datos para ayudar a los usuarios a realizar un seguimiento de sus
gastos y presupuestos personales. Ofrece opciones para ingresar nuevos gastos,
ver un resumen de los gastos acumulados y ajustar los presupuestos según sea necesario.
%}

pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));

consulta=1;
reconsulta=1;
while consulta
try
fprintf("\n Bienvenido, que operación quiere realizar: \n \n")
disp("  1.Ingresar nuevos gastos.")
disp("  2.Ajustar los presupuestos.")
disp("  3.Revisar un gasto.")
disp("  4.Resumen de los gastos acumulados")
disp("  5.Eliminar un gasto de la base de datos.")
disp("  6.Eliminar todos los Gastos de la base de datos.")
fprintf("  7.Salir. \n \n")

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')









if(opciones==1)%1.Ingresar nuevos gastos.

  g=1;
  while g
    gasto=  input("Ingrese Nombre del Gasto: ", 's');
    if isempty(gasto)
      fprintf("\n     El nombre del Gasto no puede estar vacío. Intenta de nuevo.\n \n");
      g=1;
    else
      g=0;
    endif
  endwhile

  p=1;
  while p
    prec= input("Ingrese el Precio:", 's');
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

  query = sprintf("SELECT COUNT(*) FROM e1_programa2 WHERE Gasto='%s' AND Precio='%d'",...
    upper(gasto), upper(precio));
  rep = pq_exec_params(conn, query);

  if rep.data{1} == 0

    fprintf("Se gasto en %s un total de Q%d \n \n ", gasto, precio)

    query=sprintf("insert into E1_Programa2 (Gasto, Precio) values ('%s', '%d')",...
      upper(gasto), upper(precio));
    pq_exec_params(conn, query);
    fprintf(' \n')

  else
      fprintf("El Gasto ya existe en la base de datos. \n\n");
  endif









elseif (opciones==2)%2.Ajustar los presupuestos.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  fprintf(' \n');

  if(tama>0)
  edit=1;
  while edit
    editar= input("Ingrese Nombre del Gasto a editar: ", 's');
    if isempty(editar)
      fprintf("\n     El Gasto a Editar no puede estar vacío. Intenta de nuevo.\n \n");
      edit=1;
    else
      edit=0;
    endif
  endwhile

  g=1;
  while g
    gasto=  input("Ingrese Nombre del Nuevo Gasto: ", 's');
    if isempty(gasto)
      fprintf("\n     El nombre del Gasto no puede estar vacío. Intenta de nuevo.\n \n");
      g=1;
    else
      g=0;
    endif
  endwhile

  p=1;
  while p
    prec= input("Ingrese el Nuevo Precio:", 's');
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

  query = sprintf("SELECT COUNT(*) FROM e1_programa2 WHERE Gasto='%s' AND Precio='%d'",...
    upper(gasto), upper(precio));
  rep = pq_exec_params(conn, query);

  if rep.data{1} == 0

    fprintf("Se gasto en %s un total de Q%f \n \n ", gasto, precio)

    query = sprintf("update E1_Programa2 set Gasto='%s', Precio='%d' where Gasto = ('%s');", ...
    upper(gasto), upper(precio), upper(editar));
    pq_exec_params(conn, query);
    fprintf(' \n')

  else
      fprintf("El Gasto ya existe en la base de datos. \n\n");
  endif

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  fprintf(' \n')

  else
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif








elseif (opciones==3)%3.Revisar un gasto.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif

  fprintf(' \n');

  if(tama>0)
    revisar=input("Nombre del Gasto a Revisar: ", 's');
  fprintf(' \n');
  query = sprintf("select * from E1_Programa2 where Gasto =('%s')", ...
    upper(revisar));
  Historial_Gastos=pq_exec_params(conn, query);
  dato1= Historial_Gastos.data{1};
  dato2= Historial_Gastos.data{2};

  disp(['Nombre del Gasto: ', dato1])
  fprintf('Total del Gasto: Q%d. \n', dato2)

  else
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif
  fprintf(' \n');






elseif (opciones==4)%4.Resumen de los gastos acumulados.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")
  endif

  fprintf(' \n');

  query = 'select sum(Precio) from E1_Programa2';
  resultado = pq_exec_params(conn, query);
  valor_data = resultado.data{1};
  fprintf('El total de los gastos es: %d \n \n', valor_data)







elseif (opciones==5)%5.Eliminar un gasto de la base de datos.

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  if(tama==0)
    fprintf("\n     La Tabla esta vacia.\n \n")

  else

  fprintf(" \n");

  gasto=input("Nombre del Gasto a Eliminar: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar el gasto?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa2 where Gasto =('%s')", upper(gasto));
    pq_exec_params(conn, query);
    fprintf('\nEl gasto fue Eliminado. \n');
  endif

  fprintf(" \n");

  Historial_Postgresql = pq_exec_params(conn, 'select * from E1_Programa2;');
  datos = Historial_Postgresql.data;
  tama=size(datos, 1);

  fprintf('%-20s %-15s\n', 'Gasto', 'Precio');
  for i = 1:size(datos, 1)
    Gasto = datos{i, 1};
    Precio = datos{i, 2};
    fprintf('%-20s %-15d \n', Gasto, Precio);
  end

  endif






elseif (opciones==6)%6.Eliminar Toda la Base de Datos.
  seguro=yes_or_no("¿Seguro que quiere eliminar a todos los gastos?");
  if(seguro==1)
    Borrar_Tabla=pq_exec_params(conn, "delete from E1_Programa2;");
    fprintf('Todos los gastos fueron eliminados. \n');
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

