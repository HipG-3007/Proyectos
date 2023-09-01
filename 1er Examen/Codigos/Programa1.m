%{
Programa de registro de estudiantes: Este programa utiliza Octave y una base de
datos para almacenar información de estudiantes, como su nombre, edad, género y
dirección. Ofrece opciones para agregar nuevos estudiantes, editar la información
de estudiantes existentes y eliminar estudiantes de la base de datos.
%}


pkg load database

conn = pq_connect(setdbopts('dbname','0980 Proyectos','host','localhost',
'port','5432','user','postgres', 'password','202001466'));

consulta=1;
while consulta

fprintf('Bienvenido, que operación quiere realizar: \n 1.Agregar a un estudiante. \n 2.Editar la información de estudiantes existentes. \n 3.Revisar los datos de un estudiante.\n 4.Revisar Toda la base de datos. \n 5.Eliminar un estudiantes de la base de datos. \n 6.Eliminar Toda la Base de Datos. \n \n');


opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')

if(opciones==1)%1.Agregar a un estudiante.

  nombre=input("Ingrese Nombre del Estudiante: ", 's');
  fprintf(' \n');

  edad=input("Ingrese la Edad del Estudiante: ");
  fprintf(' \n');

  g=1;
  while g
  genero=input("¿El Genero del Estudiante es 'M' o 'F'? ", 's');
    if(genero=='M') || (genero=='m')
      genero="Masculino";
      g=0;
    elseif(genero=='F') || (genero=='f')
      genero="Femenino";
      g=0;
    else
      fprintf('El genero no es reconocido: \n')
    endif
  fprintf(' \n');
  endwhile

  direccion=input("Ingrese su Direccion: ", 's');
  fprintf(' \n');

  fprintf(" Su nombre es: %s \n Su edad es: %d \n Su genero es: %s \n Su direccion es: %s",...
    nombre, edad, genero,direccion)

  query = sprintf("insert into E1_Programa1 (Nombre, Edad, Genero, Direccion) values ('%s', '%d', '%s', '%s')", ...
    nombre, edad, genero,direccion);
  pq_exec_params(conn, query);
  fprintf(' \n')


elseif (opciones==2)%2.Editar la información de estudiantes existentes.

  editar=input("Ingrese Nombre del Estudiante a editar: ", 's');
  fprintf(' \n');

  nombre=input("Ingrese Nuevo Nombre del Estudiante: ", 's');
  fprintf(' \n');

  edad=input("Ingrese la Edad del Estudiante: ");
  fprintf(' \n');

  g=1;
  while g
  genero=input("¿El Genero del Estudiante es 'M' o 'F'? ", 's');
    if(genero=='M') || (genero=='m')
      genero="Masculino";
      g=0;
    elseif(genero=='F') || (genero=='f')
      genero="Femenino";
      g=0;
    else
      fprintf('El genero no es reconocido: \n')
    endif
  fprintf(' \n');
  endwhile

  direccion=input("Ingrese su Direccion: ", 's');
  fprintf(' \n');

  fprintf(" Su nombre es: %s \n Su edad es: %d \n Su genero es: %s \n Su direccion es: %s",...
    nombre, edad, genero,direccion)

  query = sprintf("UPDATE E1_Programa1 SET Nombre='%s', Edad='%d', Genero='%s', Direccion='%s' WHERE Nombre = ('%s');", ...
    nombre, edad, genero,direccion, editar);
  pq_exec_params(conn, query);
  fprintf(' \n')

elseif (opciones==3)%3.Revisar los datos de un estudiante.
  revisar=input("Nombre del estudiante a Revisar: ", 's');
  query = sprintf("select * from E1_Programa1 WHERE Nombre =('%s')", ...
    revisar)
  Historial_Estudiante=pq_exec_params(conn, query)


elseif (opciones==4)%4.Revisar Toda la base de datos.
  Historial_Postgresql=pq_exec_params(conn, 'select * from E1_Programa1;')


elseif (opciones==5)%5.Eliminar un estudiantes de la base de datos
  estudiante=input("Nombre del estudiante a Eliminar: ", 's');
  query = sprintf("DELETE FROM E1_Programa1 WHERE Nombre =('%s')", ...
    estudiante);
  pq_exec_params(conn, query);


elseif (opciones==6)% 6.Eliminar Toda la Base de Datos.
  Borrar_Tabla=pq_exec_params(conn, "DELETE FROM E1_Programa1;");

else
  fprintf("No selecciono ninguna Opcion valida.")
endif

fprintf(' \n \n')

consulta=yes_or_no("¿Quieres realizar otra operacion: ");


endwhile

fprintf(' \n \n')

