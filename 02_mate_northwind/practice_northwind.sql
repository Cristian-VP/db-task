/*
**1. `SELECT`**

1. Selecciona todos los campos de la tabla `Customers`.
2. Muestra los nombres de los productos y sus precios de la tabla `Products`.
3. Recupera las columnas `EmployeeID`, `LastName`, y `FirstName` de la tabla `Employees`.
4. Muestra el nombre del cliente y la fecha de pedido de la tabla `Orders`.
5. Recupera todos los datos de las tablas `Customers`, `Employees` y `Orders`.
*/
SELECT * FROM Customers;
SELECT ProductName, Price FROM Products;
SELECT Employees.EmployeeID, Employees.LastName, Employees.FirstName FROM Employees;
SELECT Customers.CustomerName, Orders.OrderDate FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Orders;

-- FIN SELECT

/*
**2. `SELECT DISTINCT`**

1. Obtén los nombres de los clientes distintos de la tabla `Customers`.
2. Muestra los países distintos de los clientes de la tabla `Customers`.
3. Recupera las categorías únicas de la tabla `Products`.
4. Obtén los valores únicos de `ShipperID` de la tabla `Orders`.
5. Muestra las diferentes unidades de medida que se utilizan en los productos de la tabla `Products`.
*/

SELECT DISTINCT CustomerName FROM Customers;
SELECT DISTINCT Country FROM Customers ;
SELECT COUNT(DISTINCT Products.CategoryID) FROM Products;
SELECT DISTINCT ShipperID FROM Orders;
-- EXTRA
SELECT ShipperID AS Envio_ID, OrderID AS Pedido_ID  FROM Orders WHERE ShipperID = 1;
SELECT DISTINCT Unit FROM Products;
-- FIN SELECT DISTINCT

/*
**3. `WHERE`**

1. Selecciona todos los clientes cuyo país sea "USA" de la tabla `Customers`.
2. Muestra todos los pedidos realizados después del 1 de enero de 2023.
3. Filtra los productos cuyo precio sea mayor que 50 en la tabla `Products`.
4. Recupera los empleados cuyo apellido es "Smith".
5. Muestra todos los productos que no pertenecen a la categoría con `CategoryID = 2`.
*/

SELECT CustomerID, CustomerName FROM Customers WHERE Country = 'USA';
SELECT OrderID AS Numero_pedido FROM Orders WHERE OrderDate > '2023-01-01';
SELECT ProductID AS Identificador, ProductName FROM Products WHERE Price > 50;
SELECT EmployeeID AS Identificador, FirstName FROM Employees WHERE LastName = 'Smith';
SELECT ProductName FROM Products WHERE CategoryID <> 2;
-- FIN WHERE

/*
**4. `ORDER BY`**

1. Ordena los pedidos por fecha de manera ascendente en la tabla `Orders`.
2. Muestra los productos ordenados por su precio en orden descendente.
3. Ordena los empleados por su `LastName` en orden ascendente.
4. Recupera los nombres de los clientes y sus ciudades, ordenados por `City` en orden descendente.
5. Muestra las órdenes, ordenadas primero por `EmployeeID` y luego por `OrderDate` de forma ascendente.
 */


-- FIN ORDER BY