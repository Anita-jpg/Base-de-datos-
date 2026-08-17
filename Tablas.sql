USE GuateinventarioDB;
GO

-- 1. Tabla Categoria
CREATE TABLE Categoria (
    IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
    NombreCategoria VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- 2. Tabla Proveedor
CREATE TABLE Proveedor (
    IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
    NombreProveedor VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Correo VARCHAR(100)
);

-- 3. Tabla Bodega
CREATE TABLE Bodega (
    IdBodega INT IDENTITY(1,1) PRIMARY KEY,
    NombreBodega VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(200)
);

-- 4. Tabla Producto
CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(100) NOT NULL,
    PrecioUnitario DECIMAL(10,2) CHECK (PrecioUnitario >= 0) NOT NULL,
    Stock INT CHECK (Stock >= 0) NOT NULL,
    IdCategoria INT NOT NULL,
    IdProveedor INT NOT NULL,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
);

-- 5. Tabla Entrada
CREATE TABLE Entrada (
    IdEntrada INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE() NOT NULL,
    IdProducto INT NOT NULL,
    IdBodega INT NOT NULL,
    Cantidad INT CHECK (Cantidad > 0) NOT NULL,
    PrecioCompra DECIMAL(10,2) CHECK (PrecioCompra >= 0) NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    FOREIGN KEY (IdBodega) REFERENCES Bodega(IdBodega)
);

-- 6. Tabla Salida
CREATE TABLE Salida (
    IdSalida INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME DEFAULT GETDATE() NOT NULL,
    IdProducto INT NOT NULL,
    IdBodega INT NOT NULL,
    Cantidad INT CHECK (Cantidad > 0) NOT NULL,
    Motivo VARCHAR(200),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    FOREIGN KEY (IdBodega) REFERENCES Bodega(IdBodega)
);