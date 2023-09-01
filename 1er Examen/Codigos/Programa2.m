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
while consulta

fprintf('Bienvenido, que operación quiere realizar: \n 1.Ingresar nuevos gastos.
\n 2.Ajustar los presupuestos.
\n 3.Revisar un gasto.
\n 4.Resumen de los gastos acumulados.
\n 5.Eliminar un gasto de la base de datos.
\n 6.Eliminar Toda la Base de Datos. \n \n');


opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')

if(opciones==1)%1.Ingresar nuevos gastos.
  gasto=input("Ingrese el nombre del Gasto: ", 's');
  fprintf(' \n');
  precio=input("Ingrese el total del Gasto: ");
  fprintf(' \n');

  fprintf(" Se gasto en: %s un total de: %d \n \n ",...
    gasto, precio)

  query = sprintf("insert into E1_Programa2 (Gasto, Precio) values ('%s', '%d')", ...
    gasto,precio);
  pq_exec_params(conn, query);
  fprintf(' \n')


elseif (opciones==2)%2.Ajustar los presupuestos.
  editar=input("Ingrese Nombre del Gasto a editar: ", 's');
  fprintf(' \n');

  gasto=input("Ingrese Nombre del Nuevo Gasto: ", 's');
  fprintf(' \n');

  precio=input("Ingrese Nombre del Nuevo Precio: ");
  fprintf(' \n');

  fprintf(" Se gasto en: %s un total de: %d \n \n ",...
    gasto, precio)

  query = sprintf("UPDATE E1_Programa2 SET Gasto='%s', Precio='%d' WHERE Gasto = ('%s');", ...
    gasto,precio, editar);
  pq_exec_params(conn, query);
  fprintf(' \n')


elseif (opciones==3)%3.Revisar un gasto.
  revisar=input("Nombre del Gasto a Revisar: ", 's');
  query = sprintf("select * from E1_Programa2 WHERE Gasto =('%s')", ...
    revisar)
  Historial_Estudiante=pq_exec_params(conn, query)


elseif (opciones==4)%4.Resumen de los gastos acumulados.
  Historial_Postgresql=pq_exec_params(conn, 'select * from E1_Programa2;')


elseif (opciones==5)%5.Eliminar un gasto de la base de datos.
  estudiante=input("Nombre del Gasto a Eliminar: ", 's');
  query = sprintf("DELETE FROM E1_Programa2 WHERE Gasto =('%s')", ...
    estudiante);
  pq_exec_params(conn, query);


elseif (opciones==6)%6.Eliminar Toda la Base de Datos.
  Borrar_Tabla=pq_exec_params(conn, "DELETE FROM E1_Programa2;");

else
  fprintf("No selecciono ninguna Opcion valida.")
endif

fprintf(' \n \n')

consulta=yes_or_no("¿Quieres realizar otra operacion: ");


endwhile

fprintf(' \n \n')

