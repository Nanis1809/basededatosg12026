/* =====================
    Crear base de datos
===================== */

CREATE DATABASE comercializadora;


/* =====================
    Usar base de datos
===================== */

USE comercializadora;


/* =====================
    Crear tabla producto
===================== */

CREATE TABLE producto(
    producto_id CHAR(5) NOT NULL,
    fabricante_id CHAR(3) NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    existencia INT NOT NULL,
    CONSTRAINT pk_producto
    PRIMARY KEY (producto_id, fabricante_id),
    CONSTRAINT uq_producto_descripcion
    UNIQUE (descripcion),
    CONSTRAINT ck_producto_existencia
    CHECK (existencia > 0)
);


/* =====================
    Crear tabla cliente
===================== */

CREATE TABLE cliente(
    cliente_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_cliente
    PRIMARY KEY,
    empresa VARCHAR(30) NOT NULL
    CONSTRAINT uq_cliente_empresa
    UNIQUE,
    limite_credito DECIMAL(10,2) NOT NULL
    CONSTRAINT ck_cliente_limite_credito
    CHECK (limite_credito BETWEEN 10000 AND 100000),
    representante_id INT NOT NULL,
);


/* =====================
    Crear tabla representante
===================== */

CREATE TABLE representante(
    representante_id INT NOT NULL IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL,
    apellido_paterno VARCHAR(15) NOT NULL,
    apellido_materno VARCHAR(15) null,
    fecha_contrato DATETIME2 NOT NULL
    CONSTRAINT df_representante_fecha_contrato
    DEFAULT SYSDATETIME(),
    edad INT NOT NULL,
    puesto VARCHAR(15),
    cuota DECIMAL (10,2) NOT NULL,
    ventas DECIMAL(10,2),
    representante_id_jefe INT, --es la foreing key recurciva o jerarquica
    oficina_id INT NOT NULL, --  foreing key de representante
    CONSTRAINT pk_representante
    PRIMARY KEY (representante_id),
    CONSTRAINT ck_representante_edad
    CHECK (edad >= 18 AND edad <= 50),
    CONSTRAINT ck_representante_cuota
    CHECK (ventas > 0.0),
    CONSTRAINT ck_representante_venta
    CHECK (ventas >= 0.0),
    CONSTRAINT fk_representante_representante
    FOREIGN KEY (representante_id_jefe)
    REFERENCES REPRESENTANTE (representante_id)
);


/* =====================
    Crear tabla pedido
===================== */

CREATE TABLE pedido (
    pedido_id INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_pedido
    PRIMARY KEY,
    fecha_pedido DATETIME2 NOT NULL
    CONSTRAINT df_pedido_fecha_pedido
    DEFAULT SYSDATETIME(),
    cliente_id INT NOT NULL
    CONSTRAINT fk_pedico_cliente
    FOREIGN KEY (cliente_id)
    REFERENCES cliente(cliente_id),
    representante_id INT NOT NULL
    CONSTRAINT fk_pedido_representante
    FOREIGN KEY (representante_id)
    REFERENCES representante(representante_id),
);


/* =====================
    Agregar llave foránea a la tabla cliente
===================== */

ALTER TABLE cliente
ADD CONSTRAINT fk_cliente_representante
FOREIGN KEY (representante_id)
REFERENCES representante(representante_id);


/* =====================
    Crear tabla detalle_pedido
===================== */

CREATE TABLE detalle_pedido(
    pedido_id INT NOT NULL,
    producto_id CHAR(5) NOT NULL,
    fabricante_id CHAR(3) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    created_at DATETIME2 NOT NULL
    CONSTRAINT df_detalle_pedido_created_at
    DEFAULT SYSDATETIME(),
    updated_at DATETIME2 NOT NULL
    CONSTRAINT df_detalle_pedido_updated_at
    DEFAULT SYSDATETIME(),
    CONSTRAINT ck_detalle_pedido_precio
    CHECK (precio > 0.0),
    CONSTRAINT pk_detalle_pedido
    PRIMARY KEY (pedido_id, producto_id, fabricante_id),
    CONSTRAINT fk_detalle_pedido_pedido
    FOREIGN KEY (pedido_id) --foreign key de detalle_pedido que hace referencia a pedido
    REFERENCES pedido(pedido_id),
    CONSTRAINT fk_detalle_pedido_producto
    FOREIGN KEY (producto_id, fabricante_id) --foreign key de detalle_pedido que hace referencia a producto
    REFERENCES producto(producto_id, fabricante_id)
);

SELECT SYSDATETIME()















































/*=========================================
    CREAR BASE DE DATOS
=========================================*/

USE master;
GO

IF DB_ID('LexNova') IS NOT NULL
BEGIN
    ALTER DATABASE LexNova SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE LexNova;
END
GO

CREATE DATABASE LexNova;
GO

USE LexNova;
GO

/*=========================================
    TABLA CLIENTE
=========================================*/

CREATE TABLE Cliente(
    cliente_id INT NOT NULL,
    nombre NVARCHAR(120) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    telefono VARCHAR(20) NULL,
    fecha_registro DATETIME2 NOT NULL,
    activo BIT NOT NULL,

    CONSTRAINT pk_cliente PRIMARY KEY(cliente_id),

    CONSTRAINT uq_cliente_correo UNIQUE(correo),

    CONSTRAINT df_cliente_fecha_registro
        DEFAULT SYSDATETIME() FOR fecha_registro,

    CONSTRAINT df_cliente_activo
        DEFAULT 1 FOR activo
);
GO


/*=========================================
    TABLA ABOGADO
=========================================*/

CREATE TABLE Abogado(
    abogado_id INT NOT NULL,
    clave_empleado CHAR(8) NOT NULL,
    nombre NVARCHAR(120) NOT NULL,
    cedula_profesional VARCHAR(20) NOT NULL,
    correo VARCHAR(120) NOT NULL,
    especialidad NVARCHAR(80),
    activo BIT NOT NULL,

    CONSTRAINT pk_abogado PRIMARY KEY(abogado_id),

    CONSTRAINT uq_abogado_clave
        UNIQUE(clave_empleado),

    CONSTRAINT uq_abogado_cedula
        UNIQUE(cedula_profesional),

    CONSTRAINT uq_abogado_correo
        UNIQUE(correo),

    CONSTRAINT df_abogado_activo
        DEFAULT 1 FOR activo
);
GO
/*=========================================
    TABLA EXPEDIENTE
=========================================*/

CREATE TABLE Expediente(
    expediente_id INT NOT NULL,
    folio VARCHAR(20) NOT NULL,
    cliente_id INT NOT NULL,
    abogado_responsable_id INT NOT NULL,
    tipo_asunto NVARCHAR(60) NOT NULL,
    fecha_apertura DATE NOT NULL,
    fecha_cierre DATE NULL,
    estado VARCHAR(15) NOT NULL,
    monto_honorarios DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_expediente
        PRIMARY KEY (expediente_id),

    CONSTRAINT uq_expediente_folio
        UNIQUE (folio),

    CONSTRAINT fk_expediente_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES Cliente(cliente_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    CONSTRAINT fk_expediente_abogado
        FOREIGN KEY (abogado_responsable_id)
        REFERENCES Abogado(abogado_id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,

    CONSTRAINT df_expediente_estado
        DEFAULT 'Abierto' FOR estado,

    CONSTRAINT ck_expediente_estado
        CHECK (estado IN ('Abierto','EnProceso','Cerrado','Suspendido')),

    CONSTRAINT ck_expediente_honorarios
        CHECK (monto_honorarios > 0),

    CONSTRAINT ck_expediente_fechas
        CHECK (
            fecha_cierre IS NULL
            OR fecha_cierre >= fecha_apertura
        )
);
GO
/*=========================================
    TABLA ACTUACION
=========================================*/

CREATE TABLE Actuacion(
    actuacion_id INT NOT NULL,
    expediente_id INT NOT NULL,
    fecha_actuacion DATETIME2 NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion NVARCHAR(300) NOT NULL,
    costo_adicional DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_actuacion PRIMARY KEY(actuacion_id),

    CONSTRAINT fk_actuacion_expediente
        FOREIGN KEY(expediente_id)
        REFERENCES Expediente(expediente_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT ck_actuacion_costo
        CHECK(costo_adicional >= 0)
);
GO


/*=========================================
    TABLA SEGUIMIENTO
=========================================*/

CREATE TABLE Seguimiento(
    seguimiento_id INT NOT NULL,
    actuacion_id INT NOT NULL,
    abogado_id INT NULL,
    fecha_seguimiento DATETIME2 NOT NULL,
    resultado NVARCHAR(250) NOT NULL,
    confirmado BIT NOT NULL,
    nota_temporal NVARCHAR(100),

    CONSTRAINT pk_seguimiento PRIMARY KEY(seguimiento_id),

    CONSTRAINT fk_seguimiento_actuacion
        FOREIGN KEY(actuacion_id)
        REFERENCES Actuacion(actuacion_id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT fk_seguimiento_abogado
        FOREIGN KEY(abogado_id)
        REFERENCES Abogado(abogado_id)
        ON DELETE SET NULL
        ON UPDATE NO ACTION,

    CONSTRAINT df_seguimiento_confirmado
        DEFAULT 0 FOR confirmado
);
GO
/*=========================================
    CAMBIOS CON ALTER TABLE
=========================================*/

-- Agregar la columna prioridad

ALTER TABLE Expediente
ADD prioridad VARCHAR(10) NOT NULL
CONSTRAINT df_expediente_prioridad DEFAULT 'Media';
GO

-- Ampliar el tamaño del teléfono

ALTER TABLE Cliente
ALTER COLUMN telefono VARCHAR(25) NULL;
GO


/*=========================================
    ELIMINAR COLUMNA
=========================================*/

ALTER TABLE Seguimiento
DROP COLUMN nota_temporal;
GO
