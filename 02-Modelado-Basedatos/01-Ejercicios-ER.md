## EJERCICIOS MODELO E-R

1. En un hospital se registra informacion de sus pacientes 

## De cada paciente se desea almacenar:
  -Algo que lo identifique 

  -Nombre

  -Fecha de Nacimiento 

## De un expediente medico se almacena:
  -Numero de Expediente 

  -Fecha de Apertura

  -Tipo de sangre 


## Resultado de Modelo E-R 
![Hospital](image-1.png)

## Modelo Relacional 
![Hospital](Diagrama1.drawio.png)


2. Una universidad administra profeosres y cursos.
 
> De cada profesor se almacena:
   - Clave profesor 
   - Nombre 
   - Especialidad 

> De cada curso se almacena:
  - Identificacion del curso 
  - Nombre del curso 
  - Creditos 

> Reglas del Negocio 
  1. Un profesor puede impartir varios cursos 
  2. Un curso solamente puede ser impartido por un profesor 
  3. Puede existir un profesor que actualmente no imparta cursos 
  4. Todo curso debe ser asignado a un profesor 

  Se debe realizar lo siguente :
   - Entidades 
   - Identificar la relacion 
   **IMPARTE**
   - Determinar la cardinalidad 
   - Determinar la participacion 

## Resultado de Modelo E-R 
![Profesor](Diagrama2.png)
## Modelo Relacional 
![Profesor](Tabla2.drawio.png)


3. Una escuela administra alumnos y materias 
> De cada alumno se almacena:
  - Matricula 
  - Nombre 
  - Semestre 

> De cada materia se almacena:
  - Nombre de la materia 
  - Creditos 
  - Clave de la materia 

 reglas 
  1. Un alumno puede inscribirse en varias materias 
  2. Una materia puede tener muchos alumnos inscritos 
  3. Puede existir una materia sin alumnos inscritos 
  4. Todo alumno debe estar inscrito en al menos una materia
  5. De cada inscrpcion se debe almacenar:
     - Fecha de inscrpcion 
     - Calificacion final 
## Resultado de Modelo E-R 
![Escuela](Diagrama3.png)

## Modelo Relacional 
![Escuela](TablaEscuela.jpeg)


4. Una empresa encargada de realizar venta de productos:
> De cada cliente se almacena:
   - Numero de cliente que lo identifique
   - Y su nombre de cliente el cual es una persona moral
   - RFC 
> La empresa realiza pedidos los cuales almacena lo siguiente:
   - Numero de pedido
   - Fecha 
> La empresa tambien almacena productos de los cuales registra lo siguiente:
   - Numero del producto 
   - Nombre 
   - Precio
> Al realizar los pedidos deben registrar la cantidad de productos pedidos y precio 
>Reglas 
1. Un cliente puede realizar muchos pedidos 
2. Cada pedido pertenece a un solo cliente
3. Un pedido puede contener varios productos 
4. Un producto puede aparecer en muchos pedidos 
5. Un pedido debe contener al menos un producto
6. Un producto puede no haber  sido vendido
7. El detalle de pedido no existe sin pedido 
8. El detalle de pedido no existe sin producto
9. El detalle almacen cantidadd y precio de venta

## Resultado de Modelo E-R 

![Clientes](Diagrama4.png)      

## Modelo Relacional 
![Clientes](Tabla4.png)

5. Una empresa administra departamentos, empleados, proyectos y dependientes

>De cada departamento se almacena:
  - Número de departamento
  - Nombre del departamento
  - Fecha de inicio del gerente
  - Ubicación(es)

>De cada empleado se almacena:
 -Número de Seguro Social (SSN)
  - Nombre
  - Dirección
  - Salario
  - Sexo
  - Fecha de nacimiento

>De cada proyecto se almacena:
  - Número de proyecto
  - Nombre del proyecto
  - Ubicación

> De cada dependiente se almacena:
  - Nombre
  - Sexo
  - Fecha de nacimiento
  - Parentesco con el empleado

> Reglas
  - Cada departamento tiene un nombre y un número únicos.
  - Cada departamento es administrado por un solo empleado.
  - Un empleado puede administrar como máximo un departamento.
  - Se almacena la fecha en que un empleado comenzó a administrar el departamento.
  - Un departamento puede tener una o varias ubicaciones.
  - Un departamento controla uno o varios proyectos.
  - Cada proyecto pertenece a un solo departamento.
  - Cada proyecto tiene un nombre y un número únicos, además de una sola ubicación.
  - Todo empleado pertenece a un único departamento.
  - Un departamento puede tener varios empleados.
  - Un empleado puede trabajar en varios proyectos.
  - Un proyecto puede tener varios empleados trabajando en él.
  - De cada asignación de un empleado a un proyecto se almacena el número de horas trabajadas por semana.
  - Cada empleado tiene un supervisor directo, quien también es un empleado.
  - Un supervisor puede supervisar a varios empleados.
  - Un empleado puede tener cero o varios dependientes.
  - Cada dependiente pertenece a un solo empleado.

## Resultado de Modelo E-R
![Empresa](Ejercicio5.drawio.png)
## Modelo Relacional
![Empresa](Tablaejer5.1.drawio.png)
![Empresa](Tablasejer5.2.drawio.png)

6. Tarea
## Resultado de Modelo E-R
![Tarea](TareaEjercicio6.png)
## Modelo Relacional
![Tarea](Tabla6.jpeg)
