USE GuateinventarioDB;
GO

-- 1. Vista: Catálogo completo de productos con detalles
CREATE VIEW vw_CatalogoProductos AS
SELECT 
    P.IdProducto,
    P.NombreProducto,
    C.NombreCategoria,
    PR.NombreProveedor,
    P.PrecioUnitario,
    P.Stock
FROM Producto P
INNER JOIN Categoria C ON P.IdCategoria = C.IdCategoria
INNER JOIN Proveedor PR ON P.IdProveedor = PR.IdProveedor;
GO

-- 2. Vista: Resumen de Entradas por Producto y Bodega
CREATE VIEW vw_DetalleEntradas AS
SELECT 
    E.IdEntrada,
    E.Fecha,
    P.NombreProducto,
    B.NombreBodega,
    E.Cantidad,
    E.PrecioCompra,
    (E.Cantidad * E.PrecioCompra) AS Subtotal
FROM Entrada E
INNER JOIN Producto P ON E.IdProducto = P.IdProducto
INNER JOIN Bodega B ON E.IdBodega = B.IdBodega;
GO

-- 3. Vista: Resumen de Salidas por Producto y Bodega
CREATE VIEW vw_DetalleSalidas AS
SELECT 
    S.IdSalida,
    S.Fecha,
    P.NombreProducto,
    B.NombreBodega,
    S.Cantidad,
    S.Motivo
FROM Salida S
INNER JOIN Producto P ON S.IdProducto = P.IdProducto
INNER JOIN Bodega B ON S.IdBodega = B.IdBodega;
GO