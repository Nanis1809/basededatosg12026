# Contenedores de Sistemas Gestores de Base de Datos 

![ImagenDocker](./img/Gemini_Generated_Image_dp4xdgdp4xdgdp4x%20(1).png)


## Imagenes 

> Comandos para cada imagen 

- Descargar imagen de postgres

```
docker pull postgres:14.22-trixie
```
-Descargar imagen tutorial de Docker 
```
docker pull docker/getting-started 
```
## Creacion de contenedores

```docker
docker run -d -p 80:80 **Nombre o Codigo de la imagen**
``` 
Donde:
- -d detach (background)
- -p puerto (el primer numero de puerto no se cambia,el segundo si podemos cambiarlo)

## Contenedor Tutorial de Docker
```
docker run -d -p 80:80 docker/getting-started
docker run -d -p 80:80 bbb885
docker pull docker/getting-started 
```

### Contenedor de MariaDB sin Volumen 
```docker
docker run -d --name Server-MariadbG1 -p 3343:3306 -e MARIADB_ROOT_PASSWORD=123456 e0236 
```
### Contenedor de MariaDB con Volumen 
```docker
docker volume create v-mariadbg1
docker run -d --name Server-MariadbG1 -p 3343:3306 -e MARIADB_ROOT_PASSWORD=123456 -v v-mariadbg1:/var/lib/mysql e0236 
```
### Contenedor de Postgres con Volumen 
```docker
docker volume create v-postgresg1
docker run -d --name Server-PostgresG1 -p 5455:5432 -e POSTGRES_PASSWORD=123456 -v v-postgresg1:/var/lib/postgresql/data
```
 n   n 
## Comandos Docker
| Comando | Descripcion |
| :--- | :--- |
|**docker --version** | _Muestra la version del Docker_|
|**docker pull nombre_imagen** | _Descargar una imagen en Docker Hub_ [Docker Hub](https://hub.docker.com/)|
|**docker images** | _Muestra todas las imagenes_|
|**docker run** | _Crear un contenedor_|
|**docker ps** | _Visualiza todos los contenedores_|
|**docker container ls** | _Visualiza todos los contenedores_|
|**docker ps -a** | _Visualiza todos los contenedores_|
|**docker container ls -a** | _Visualiza todos los contenedores_|
|**docker rm nombre_contenedor o ID** | _Borra un contenedor _|
|**docker run** | _Crea un contenedor  _|
|**docker stop nombre o ID** | _Detiene el contenedor _|
|**docker start nombre o ID** | _Inicia un contenedor _|
|**docker rm nombre o ID** | _Elimina un contenedor que no esta en ejecucion _|
|**docker rm -f nombre o ID** | _Elimina un contenedor que  esta en ejecucion _|
|**docker volumen ls** | _Muestra los volumenes que existen en docker _|



















