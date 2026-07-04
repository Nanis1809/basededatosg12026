## Diccionario de Datos de la base de datos de Control Escolar 

1. Informacion General 
 Elemento  Valor 
 :---  :---
 Proyecto  Control Escolar 
 Version  1.0 
 Fecha  Junio 2026
 Elaboro  Maria Fernanda 
 SGBD  SQLServer 

2. Descripcion del sistema de base de datos 

El sistema administra:
- Carreras
- Alumnos 
- Profesores 
- Materias 
- Grupos
- Inscripciones 

Permite controlar la ooferta academica y las inscripcion de estudiantes 

3. Catalogo de Restricciones utilizadas 
 Codigo  Significado 
 :---  :---
 PK Primary Key 
 FK Foreign Key 
 NN NOT NULL
 UQ UNIQUE 
 AI Auto Increment 
 CK Check 
 DF Default 

4. Diccionario de Datos 

## Tabla: Carrera

**Descripcion**

| Campo | Tipo | Longitud | Restricciones | Descripcion  |
| --------- | --------- | --------- | --------- | --------- |
| id_carrera  | INT  | - | PK,AI,NN | Identificador unico de la carrera  |
| nombre | VARCHAR  | 100 | UQ,NN  | Nombre de la carrera  |
| duracion_cuatrimestre b | VARCHAR  | 100 | UQ,NN  | Nombre de la carrera  |

--
## Tabla:Alumno

**Descripcion**
Alamacena informacion de los estudiantes

| Campo | Tipo | Longitud | Restricciones | Descripcion  |
| --------- | --------- | --------- | --------- | --------- |
| id_alumno | INT  | - | PK,AI,NN | Identificador unico del Alumno |
| matricula | VARCHAR  | 10 | UQ,NN  | Matricula Institucional |
| nombre | VARCHAR  | 30 | NN  | Nombre del Alumno  |
| apellido_paterno | VARCHAR  | 50 | NN  | Apellido Paterno  |
| apellido_materno | VARCHAR  | 50 | NULL  | Apellido Materno  |
| correo | VARCHAR  | 100 | UQ,NN | Correo Institucional  |
| fecha_nacimiento  | DATE  | - | NN  | Fecha de Nacimiento  |
| id_carrera | INT  | - | FK,NN  | Carrera  a la pertenencia  |

--
5. Relaciones en la Base de Datos

| Relacion | Cardinalidad | Descripcion |
| :--- | :--- | :--- |
| Carrera -> Alumno  | 1:N | Una carrera tiene muchos alumnos  |
| Carrera -> Materia | 1:N | Una carrera tiene muchas materias |
| Profesor -> Grupo | 1:N | Una carrera puede impartir varios grupos |
| Carrera -> Materia | 1:N | Una materia tiene abrirse en varios grupos |
| Carrera -> Materia | 1:N | Una carrera tiene muchas materias |
| Carrera -> Materia | 1:N | Una carrera tiene muchas materias |
| Carrera -> Materia | 1:N | Una carrera tiene muchas materias |

6. Matriz de claves foraneas

| Tabla | Campo FK | Referencia |
| :--- | :--- | :--- |
| Alumno |id_carrera | Carrera(id_carrera) |
| Materia | id_carrera | Carrera(id_carrera) |
| Grupo | id_profesor | profesor (id_profesor) |
| Grupo| id_materia |Materia(id_materia) |
| Inscripcion| id_alumno | Alumno(id_alumno) |
| Inscripcion| id_grupo | Grupo(id_grupo) |

7. Integridad Referencial 

| Codigo | Regla | 
| :--- | :--- | 
| IR-01 |No se puede registrar un alumno con una carrera inexistente  |
| IR-02| No se puede crear un grupo para una materia inexistente  |
| IR-03| No se puede crear un grupo para un profesor inexistente  |
| IR-04| No se puede inscribir un alumno en un grupo inexistente  |
| IR-05| No se puede eliminar una carrera que tenga alumnos asocioados sin antes reasignarloso eliminarlos   |

8. Reglas de Negocio

| Codigo | Regla | 
| :--- | :--- | 
| RN-01 |Un alumno pertenece a una sola carrera  |
| RN-02|Una carrera puede tener muchos alumnos |
| RN-03| Una carrera puede tener muchas materias  |
| RN-04| Un profesor puede impartir varios grupos  |
| RN-05| Un grupo solo puede tener un profesor asignado  |
| RN-06| La calificacion debe estar entre 0.0 y 10.0  |

9. Diagrama Relacional 

![Control Relacional ](Diagrama1.drawio.png)








