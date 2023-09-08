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
reconsulta=1;
while consulta
try

fprintf('Bienvenido, que operación quiere realizar: \n \n')
disp('  1.Agregar a un estudiante.')
disp('  2.Editar la información de estudiantes existentes.')
disp('  3.Revisar los datos de un estudiante.')
disp('  4.Revisar Toda la base de datos.')
disp('  5.Eliminar un estudiantes de la base de datos.')
disp('  6.Eliminar todos los Estudiante de la base de datos.')
fprintf('  7.Salir. \n \n')

opciones=input("Seleccione el numero de su operación: ");
fprintf(' \n')


if(opciones==1)%1.Agregar a un estudiante.

  n=1;
  while n
    nombre=input("Ingrese Nombre del Estudiante: ", 's');
    if any(isstrprop(nombre, 'digit')) % Verifica si la entrada contiene números
      fprintf('\n     Los Nombres no deben de contener numeros. Intenta de nuevo.\n \n');
      n=1;
    else
      n=0;
    endif
  endwhile

  e=1;
  while e
    ed = input("Ingrese la Edad del Estudiante: ", 's');
    numero = str2double(ed);
    if ~isnan(numero)
      edad=numero;
      e=0;
    else
      fprintf('\n     La edad solo deben de ser numeros. Intenta de nuevo.\n \n');
      e=1;
    endif
  endwhile

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
      fprintf('El genero no es reconocido. \n')
    endif
  endwhile

  direccion=input("Ingrese su Direccion: ", 's');
  fprintf(' \n');

  query = sprintf("SELECT COUNT(*) FROM e1_programa1 WHERE Nombre='%s' AND Edad='%d' AND Genero='%s' AND Direccion='%s'",...
  nombre, edad, genero, direccion);
  rep = pq_exec_params(conn, query);
  if rep.data{1} == 0
    disp(['Su nombre es: ', nombre])
    fprintf('Su edad es: %d años. \n', edad)
    disp(['Su genero es: ', genero])
    disp(['Su direccion es: ', direccion])

    query =sprintf("insert into E1_Programa1 (Nombre, Edad, Genero, Direccion) values ('%s', '%d', '%s', '%s')", ...
        upper(nombre), upper(edad), upper(genero), upper(direccion));
    pq_exec_params(conn, query);
    fprintf(' \n')
  else
      disp('El usuario ya existe en la base de datos.');
  endif






elseif (opciones==2)%2.Editar la información de estudiantes existentes.

  e=1;
  while e
    editar=input("Ingrese Nombre del Estudiante a editar: ", 's');
    if any(isstrprop(editar, 'digit')) % Verifica si la entrada contiene números
      fprintf('\n     Los Nombres no deben de contener numeros. Intenta de nuevo.\n \n');
      e=1;
    else
      e=0;
    endif
  endwhile

  n=1;
  while n
    nombre=input("Ingrese Nombre del Estudiante: ", 's');
    if any(isstrprop(nombre, 'digit')) % Verifica si la entrada contiene números
      fprintf('\n     Los Nombres no deben de contener numeros. Intenta de nuevo.\n \n');
      n=1;
    else
      n=0;
    endif
  endwhile

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
  endwhile

  edad=input("Ingrese la Edad del Estudiante: ");

  direccion=input("Ingrese su Direccion: ", 's');
  fprintf(' \n');

  disp(['Su nombre es: ', nombre])
  fprintf('Su edad es: %d años. \n', edad)
  disp(['Su genero es: ', genero])
  disp(['Su direccion es: ', direccion])

  query = sprintf("update E1_Programa1 set Nombre='%s', Edad='%d', Genero='%s', Direccion='%s' where Nombre = ('%s');", ...
    nombre, edad, genero,direccion, editar);
  pq_exec_params(conn, query);
  fprintf(' \n')


elseif (opciones==3)%3.Revisar los datos de un estudiante.
  revisar=input("Nombre del estudiante a Revisar: ", 's');
  fprintf(' \n');
  query = sprintf("select * from E1_Programa1 where Nombre =('%s')", ...
    revisar);
  Historial_Estudiante=pq_exec_params(conn, query);
  dato1= Historial_Estudiante.data{1};
  dato2= Historial_Estudiante.data{2};
  dato3= Historial_Estudiante.data{3};
  dato4= Historial_Estudiante.data{4};

  disp(['Su nombre es: ', dato1])
  fprintf('Su edad es: %d años. \n', dato2)
  disp(['Su genero es: ', dato3])
  disp(['Su direccion es: ', dato4])

elseif (opciones==4)%4.Revisar Toda la base de datos.
  Historial_Postgresql=pq_exec_params(conn, 'select * from E1_Programa1;')


elseif (opciones==5)%5.Eliminar un estudiantes de la base de datos
  estudiante=input("Nombre del estudiante a Eliminar: ", 's');
  seguro=yes_or_no("¿Seguro que quiere eliminar al estudiante?");
  if(seguro==1)
    query = sprintf("delete from E1_Programa1 where Nombre =('%s')", estudiante);
    pq_exec_params(conn, query);
    fprintf('Estudiante Eliminado. \n');
  endif


elseif (opciones==6)% 6.Eliminar Toda la Base de Datos.
  seguro=yes_or_no("¿Seguro que quiere eliminar a todos los estudiantes?");
  if(seguro==1)
    Borrar_Tabla=pq_exec_params(conn, "delete from E1_Programa1;");
    fprintf('Todos los estudiantes fueron eliminados. \n');
  endif


elseif (opciones==7)% 6.Salir.
  fprintf("El programa a finalizado")
  consulta=0;
  reconsulta=0;


else
  fprintf("No selecciono ninguna Opcion valida.")

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

