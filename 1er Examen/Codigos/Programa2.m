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
disp('Bienvenido, que operación quiere realizar:')
disp('  1.Ingresar nuevos gastos.')
disp('  2.Ajustar los presupuestos.')
disp('  3.Revisar un gasto.')
disp('  4.Resumen de los gastos acumulados')
disp('  5.Eliminar un gasto de la base de datos.')
disp('  6.Eliminar todos los Gastos de la base de datos.')
fprintf('  7.Salir. \n \n')

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')


if(opciones==1)%1.Ingresar nuevos gastos.
  gasto=  input("Ingrese el nombre del Gasto: ", 's');
  precio= input("Ingrese el total del Gasto: ");
  fprintf(' \n');

  fprintf("Se gasto en %s un total de %d \n \n ", gasto, precio)

  query=sprintf("insert into E1_Programa2 (Gasto, Precio) values ('%s', '%d')",...
    gasto,precio);
  pq_exec_params(conn, query);


elseif (opciones==2)%2.Ajustar los presupuestos.
  editar= input("Ingrese Nombre del Gasto a editar: ", 's');
  gasto=  input("Ingrese Nombre del Nuevo Gasto: ", 's');
  precio= input("Ingrese Nombre del Nuevo Precio: ");
  fprintf(' \n');

  fprintf("Se gasto en %s un total de Q%d \n \n ", gasto, precio)

  query = sprintf("update E1_Programa2 set Gasto='%s', Precio='%d' where Gasto = ('%s');", ...
    gasto,precio, editar);
  pq_exec_params(conn, query);


elseif (opciones==3)%3.Revisar un gasto.
  revisar=input("Nombre del Gasto a Revisar: ", 's');
  fprintf(' \n');
  query = sprintf("select * from E1_Programa2 where Gasto =('%s')", ...
    revisar);
  Historial_Gastos=pq_exec_params(conn, query);
  dato1= Historial_Gastos.data{1};
  dato2= Historial_Gastos.data{2};

  disp(['Nombre del Gasto: ', dato1])
  fprintf('Total del Gasto: Q%d. \n', dato2)


elseif (opciones==4)%4.Resumen de los gastos acumulados.
  Historial_Postgresql=pq_exec_params(conn, 'select * from E1_Programa2;')

  query = 'select sum(Precio) from E1_Programa2';
  resultado = pq_exec_params(conn, query);
  valor_data = resultado.data{1};
  fprintf('El total de los gastos es: %d \n', valor_data)


elseif (opciones==5)%5.Eliminar un gasto de la base de datos.
  gasto=input("Nombre del Gasto a Eliminar: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar el gasto?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa2 where Gasto =('%s')", gasto);
    pq_exec_params(conn, query);
    fprintf('El gasto fue Eliminado. \n');
  endif


elseif (opciones==6)%6.Eliminar Toda la Base de Datos.
  seguro=yes_or_no("¿Seguro que quiere eliminar a todos los gastos?");
  if(seguro==1)
    Borrar_Tabla=pq_exec_params(conn, "delete from E1_Programa2;");
    fprintf('Todos los gastos fueron eliminados. \n');
  endif


elseif (opciones==7)% 6.Salir.
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

