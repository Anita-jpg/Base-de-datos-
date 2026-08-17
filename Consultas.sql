USE GuateinventarioDB;
GO

-- 1. consulta de productos segun su listado con su categoría y proveedor. 
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

-- 2. Productos con stock igual o inferior a 20 unidades (alerta de stock bajo)
SELECT 
    IdProducto,
    NombreProducto,
    Stock
FROM Producto
WHERE Stock <= 20;

-- 3. Total de inventario invertido por categoría
SELECT 
    C.NombreCategoria,
    SUM(P.Stock * P.PrecioUnitario) AS TotalInvertido
FROM Producto P
INNER JOIN Categoria C ON P.IdCategoria = C.IdCategoria
GROUP BY C.NombreCategoria;

-- 4. Historial de entradas con detalle de producto y bodega
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

-- 5. Historial de salidas con detalle de producto y bodega
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

-- 6. Top 5 productos con mayor número de unidades ingresadas (entradas)
SELECT TOP 5
    P.NombreProducto,
    SUM(E.Cantidad) AS TotalIngresado
FROM Entrada E
INNER JOIN Producto P ON E.IdProducto = P.IdProducto
GROUP BY P.NombreProducto
ORDER BY TotalIngresado DESC;

-- 7. Cantidad de productos registrados por cada proveedor
SELECT 
    PR.NombreProveedor,
    COUNT(P.IdProducto) AS TotalProductos
FROM Proveedor PR
LEFT JOIN Producto P ON PR.IdProveedor = P.IdProveedor
GROUP BY PR.NombreProveedor;

-- 8. Resumen general de movimientos por bodega (total entradas y salidas)
SELECT 
    B.NombreBodega,
    ISNULL(SUM(E.Cantidad), 0) AS TotalEntradas,
    ISNULL(SUM(S.Cantidad), 0) AS TotalSalidas
FROM Bodega B
LEFT JOIN Entrada E ON B.IdBodega = E.IdBodega
LEFT JOIN Salida S ON B.IdBodega = S.IdBodega
GROUP BY B.NombreBodega;