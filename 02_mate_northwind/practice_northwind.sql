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
SELECT OrderID FROM Orders ORDER BY OrderID;
SELECT ProductID AS Identificador, ProductName AS Producto, Price FROM Products ORDER BY Price DESC;
SELECT EmployeeID AS Identificador, Employees.FirstName FROM Employees ORDER BY LastName;
SELECT CustomerName, City FROM Customers ORDER BY City DESC;
SELECT OrderID AS Identificador_Pedido FROM Orders ORDER BY EmployeeID, OrderDate;

-- FIN ORDER BY

/*
**5. `AND`**

1. Selecciona los pedidos que fueron realizados por el cliente con `CustomerID = 5` y cuyo `OrderDate` sea posterior a "2023-01-01".
2. Muestra los productos que tienen un precio mayor a 50 y pertenecen a la categoría con `CategoryID = 3`.
3. Filtra los empleados que trabajaron después del 1 de enero de 2020 y tienen el apellido "Johnson".
4. Selecciona las órdenes enviadas por el `ShipperID = 2` y cuyo total de productos sea mayor a 10.
5. Muestra todos los clientes que se encuentran en "USA" y cuyo código postal comience con "902".
*/
SELECT Orders.OrderID AS Peddidos FROM Orders WHERE CustomerID = 5 AND OrderDate > 1996-02-10;
SELECT ProductID , ProductName FROM Products WHERE Price > 50 AND CategoryID = 3;
SELECT EmployeeID AS Identificador, FirstName AS Name FROM Employees WHERE LastName  LIKE '%o';
SELECT OrderID FROM Orders WHERE ShipperID = 2 AND EmployeeID = 1 ORDER BY OrderID;
SELECT CustomerName FROM Customers WHERE Country = 'USA' AND PostalCode LIKE '9%';

-- FIN AND

/*
**6. `OR`**

1. Muestra los productos cuyo `Price` sea mayor que 100 o que pertenezcan a la categoría `CategoryID = 2`.
2. Selecciona los pedidos hechos por los clientes con `CustomerID = 3` o `CustomerID = 8`.
3. Filtra los empleados que tengan el apellido "Taylor" o trabajen después de 2019.
4. Muestra los clientes que se encuentran en "USA" o en "Canada".
5. Obtén los productos cuyo nombre comience con "A" o cuyo precio sea menor que 20.
 */
SELECT ProductID AS Identificador ,ProductName FROM Products WHERE Price > 100 OR CategoryID = 2;
SELECT OrderID FROM Orders WHERE CustomerID = 3 OR CustomerID = 8;
SELECT FirstName AS Employee, EmployeeID AS Identificador FROM Employees WHERE LastName LIKE '%r%' OR BirthDate > '1966-01-01 00:00:00' ORDER BY Employee;
SELECT Customers.CustomerName, CustomerID AS Identificador, Country FROM Customers WHERE Country = 'USA' OR Country = 'Canada' ORDER BY Country;
SELECT Products.ProductName FROM Products WHERE ProductName LIKE 'A%' OR Price < 20;
-- FIN OR

/*
**7. `NOT`**

1. Selecciona todos los pedidos donde el `ShipperID` no sea igual a 1.
2. Muestra los productos cuyo nombre no contenga la palabra "chocolate".
3. Filtra los empleados cuyo `EmployeeID` no sea 4.
4. Recupera los clientes cuyo `Country` no sea "Germany".
5. Muestra las órdenes que no fueron realizadas antes de "1996-12-31".
 */
SELECT OrderID FROM Orders WHERE ShipperID <> 1;
SELECT Products.ProductName FROM Products WHERE ProductName NOT LIKE '%chocolate%';
SELECT Employees.FirstName, Employees.LastName FROM Employees WHERE NOT EmployeeID =  4;
SELECT Customers.CustomerName FROM Customers WHERE NOT Country = 'Germany';
SELECT Orders.OrderID FROM Orders WHERE OrderDate > '1996-12-31';
-- FIN NOT

/*
 ### **8. `IN`**

1. Muestra todos los empleados cuyo `EmployeeID` sea 2, 5 o 8.
2. Filtra los productos que pertenecen a las categorías con `CategoryID = 3, 7, 8`.
3. Selecciona los pedidos realizados por los clientes con `CustomerID` en la lista (5, 9, 12).
4. Muestra todos los clientes ubicados en los países "USA", "Canada", o "Mexico".
5. Recupera las órdenes que fueron realizadas en los años 2020, 2021 o 2022.
 */
SELECT EmployeeID, Employees.FirstName, Employees.LastName FROM Employees WHERE EmployeeID IN(2, 5, 8);
SELECT Products.ProductName AS Producto FROM Products WHERE CategoryID IN (3,7,8);
SELECT Orders.OrderID FROM Orders WHERE CustomerID IN (5, 9, 12);
SELECT Customers.CustomerName FROM Customers WHERE Country IN('USA','CANADA','Mexico');
SELECT Orders.OrderID FROM  Orders WHERE YEAR(OrderDate) IN (2020, 2021, 2022);
SELECT Orders.OrderID FROM  Orders WHERE MONTH(OrderDate) IN (01, 04);
SELECT Orders.OrderID FROM  Orders WHERE DAY(OrderDate) IN (11, 24);
-- IN

/*
**9. `NULL` (y `IS NULL`)**

1. Muestra todos los productos cuyo campo `Price` es `NULL` en la tabla `Products`.
2. Filtra los empleados que no tienen una foto registrada.
3. Selecciona los clientes que no tienen un nombre de contacto .
4. Muestra todas las órdenes que no tienen un `ShipperID` asignado.
5. Recupera los productos que no tienen un proveedor asignado .
 */
SELECT Products.ProductID FROM Products WHERE Price IS NULL;
SELECT Employees.FirstName FROM Employees WHERE Photo IS NULL;
SELECT Customers.CustomerName FROM Customers WHERE ContactName IS NULL;
SELECT Orders.OrderID FROM Orders WHERE ShipperID IS NULL;
SELECT Products.ProductName FROM Products WHERE SupplierID is NULL;
-- FIN NULL

/*
**10. `UPDATE`**

1. Actualiza el precio de todos los productos en la categoría `CategoryID = 4` a 75.
2. Cambia el país de todos los clientes con `Country = 'USA'` a "United States of America".
3. Modifica el apellido del empleado con `EmployeeID = 3` a "Robinson".
4. Actualiza el `Phone` de un proveedor con `SupplierID = 10` a "555-1234".
5. Establece el `ShipperID` de las órdenes que fueron enviadas el 01 de enero de 2023 como 3.
 */
UPDATE Products SET Price = 0 WHERE CategoryID BETWEEN 4 AND 75;
UPDATE Customers SET Country = 'United States of America' WHERE Country = 'USA';
UPDATE Employees SET LastName = 'Robinson' WHERE EmployeeID = 3;
UPDATE Suppliers SET Phone = '555-1234' WHERE SupplierID = 10;
UPDATE Orders SET ShipperID = 3 WHERE OrderDate = '2023-01-01';
-- FIN UPDATE

/*
**11. `DELETE`**

1. Elimina todos los registros de clientes cuyo `Country` sea "Germany".
2. Borra todos los productos cuyo precio sea inferior a 10.
3. Elimina las órdenes que fueron realizadas antes del 1 de enero de 2022.
4. Elimina los empleados cuyo `EmployeeID` sea mayor que 10.

 */
DELETE FROM Customers WHERE Country = 'Germany';
DELETE FROM Products WHERE Price <= 10;
DELETE FROM Orders WHERE OrderDate < '2022-01-01';
DELETE FROM Employees WHERE EmployeeID > 10;
-- DELETE FIN

/*
*12. `LIMIT`**

1. Selecciona los primeros 5 productos más caros de la tabla `Products`.
2. Muestra las primeras 10 órdenes realizadas en la tabla `Orders`.
3. Recupera los primeros 3 clientes de la lista `Customers` según el nombre (`CustomerName`).
4. Muestra las 5 categorías con más productos en la tabla `Products`.
5. Recupera los 10 primeros empleados que tengan el apellido "Taylor" de la tabla `Employees`.
 */
SELECT Products.ProductName, Price FROM Products ORDER BY Price DESC LIMIT 5;
SELECT Orders.OrderID FROM Orders LIMIT 10;
SELECT Customers.CustomerName FROM Customers ORDER BY CustomerName LIMIT 5;
SELECT CategoryID, ProductName, COUNT(ProductID) AS Suma_productos
FROM Products
GROUP BY CategoryID
ORDER BY Suma_identificador DESC
LIMIT 5;
SELECT Employees.LastName FROM Employees WHERE LastName = 'Tayler' LIMIT 10;

-- FIN LIMIT

/*
 ### **13. `MAX()`**

1. Muestra el precio más alto entre todos los productos de la tabla `Products`.
2. Recupera la fecha más reciente de un pedido realizado en la tabla `Orders`.
3. Muestra el salario más alto de los empleados (supón que tienes una columna `Salary`).
4. Recupera el `ProductID` del producto con el precio más alto.
5. Obtén el `OrderID` del pedido más reciente realizado.
 */
SELECT Products.ProductName, MAX(Products.Price) FROM Products;
SELECT Orders.OrderDate FROM Orders ORDER BY  OrderDate DESC LIMIT 1;
SELECT Orders.EmployeeID, Employees.FirstName, MAX(Salary) FROM Employees;
SELECT Products.ProductID FROM Products WHERE price = (SELECT MAX(Price) FROM Products);
SELECT Orders.OrderID FROM Orders WHERE OrderDate = (SELECT MAX(Orders.OrderDate) FROM Orders);
SELECT Orders.OrderID FROM Orders ORDER BY  OrderDate DESC LIMIT 1;
-- FIN MAX ()

/*
**14. `COUNT()`**

1. Cuenta cuántos clientes se encuentran en el país "USA".
2. Muestra el número de productos en la categoría con `CategoryID = 5`.
3. Cuenta cuántos empleados hay en la tabla `Employees`.
4. Recupera el número de pedidos realizados por un cliente con `CustomerID = 10`.
5. Cuenta el número de productos cuyo precio es superior a 100.
 */
SELECT COUNT(CustomerID) FROM Customers WHERE Country = 'USA';
SELECT COUNT(Products.ProductID) FROM Products WHERE CategoryID = '5';
SELECT COUNT(EmployeeID) FROM Employees;
SELECT COUNT(Orders.OrderID) FROM Orders WHERE CustomerID= 10;
SELECT COUNT(Products.ProductID) FROM Products WHERE Price > 100;

-- FIN COUNT()

/*
 ### **15. `MIN()`**
1. Muestra el precio más bajo de todos los productos de la tabla `Products`.
2. Recupera la fecha más antigua de un pedido realizado en la tabla `Orders`.
3. Obtén el `ProductID` del producto más barato.
4. Muestra el valor mínimo de `Quantity` de todos los detalles de pedido en la tabla `OrderDetails`.
5. Recupera el `EmployeeID` con la fecha de nacimiento más temprana.
 */
SELECT MIN(price) FROM Products GROUP BY ProductName;
SELECT Orders.OrderDate FROM Orders WHERE OrderDate = (SELECT MIN(OrderDate) FROM Orders);
SELECT Products.ProductID FROM Products WHERE Price = (SELECT MIN(Price) FROM Products) LIMIT 1;
SELECT MIN(OrderDetails.Quantity) FROM OrderDetails;
SELECT OrderID, MIN(OrderDetails.Quantity) AS CANTIDAD_MINIMA FROM OrderDetails GROUP BY OrderID ORDER BY OrderID;

--
/*
**16. `AVG()`**

1. Muestra el precio promedio de todos los productos en la tabla `Products`.
2. Recupera el salario promedio de los empleados.
3. Calcula el número promedio de productos por pedido.
4. Obtén la cantidad promedio de productos por orden en la tabla `OrderDetails`.
*/
SELECT AVG(Price) FROM Products;
SELECT AVG(Salary) FROM Employees;

-- A Clientes por país
SELECT Customers.Country, COUNT(*) AS Numero_Clientes FROM Customers GROUP BY Country;

-- b El pais con más numero de clientes
SELECT Country, COUNT(*) AS Numero_Clientes FROM Customers GROUP BY Country ORDER BY Numero_Clientes DESC LIMIT 1;

-- C Media de clientes per country

SELECT AVG(Media_Clientes) AS Media_Clientes FROM (SELECT Country, COUNT(*) AS Media_Clientes FROM Customers GROUP BY Country) AS Media_Clientes;

-- E

SELECT Customers.Country, COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Country ORDER BY Numero_Clientes DESC
    OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY;

-- F

SELECT Customers.Country, COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Country ORDER BY Numero_Clientes
    FETCH NEXT 1 ROWS WITH TIES;

-- G
(SELECT Customers.Country, COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Country ORDER BY Numero_Clientes DESC
    FETCH NEXT ROWS WITH TIES)
UNION
(SELECT Customers.Country, COUNT(*) AS Numero_Clientes
FROM Customers
GROUP BY Country ORDER BY Numero_Clientes
    FETCH NEXT 1 ROWS WITH TIES);

-- H

SELECT COUNT(CustomerID) AS Customers_With_No_Orders FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- I
UPDATE Products SET Price = Price * 1.1;

-- J
SELECT ProductID, ProductName, Price FROM Products WHERE Price > (
SELECT AVG(Price) FROM Products);

/*
 Consulta que muestra los productos más caros, junto con su nombre y precio,
 de las categorías con CategoryID 2, 3 o 5, pero solo si su precio es mayor a 100, y ordenados por precio en orden descendente
 */
SELECT DISTINCT Products.ProductName, Products.Price FROM Products
WHERE CategoryID IN (2,3,5) AND Price > 100
ORDER BY Price DESC;

/*
 Cuenta cuántos productos tienen un precio superior a 50 y pertenecen a las categorías 1, 3, o 4.
 Devuelve solo el total de productos encontrados
 */

 SELECT COUNT(*) AS precio_superior FROM Products WHERE CategoryID IN (1,2,3,4) AND Price > 50;

/*
 Recupera el CustomerID, el nombre del cliente (CustomerName),
 y el total de productos (en cantidad) que ha comprado un cliente
 */

SELECT
    Customers.CustomerID,
    Customers.CustomerName,
    COUNT(OrderDetails.Quantity) AS TotalProductos
FROM
    Customers, Orders, OrderDetails
WHERE
    Customers.CustomerID = Orders.CustomerID
    AND Orders.OrderID = OrderDetails.OrderID
GROUP BY
    Customers.CustomerID, Customers.CustomerName;

/*
 Muestra todos los productos cuyo nombre contenga las palabras "chocolate" o "vanilla",
 cuyo precio esté entre 10 y 30, y que pertenezcan a la categoría con CategoryID 3.
 */
 SELECT Products.ProductName FROM Products
     WHERE (ProductName LIKE ('%chocolate%') OR ProductName LIKE ('%vanilla%'))
        AND Price BETWEEN  10 AND 30
        AND CategoryID = 3;

/*
 Obtén los OrderID y ProductID de todos los detalles de pedido, cuyo Quantity sea mayor a 10,
 pero solo para los pedidos realizados por los clientes con CustomerID 3, 7, o 10.
 */

SELECT OrderID, ProductID FROM OrderDetails WHERE Quantity > 10 AND OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID IN(3,7,10));

/*
 Muestra el ProductID y el Price de todos los productos que no tienen un proveedor asignado (SupplierID IS NULL),
 pero cuyo precio sea menor a 10. Ordena los resultados por Price en orden ascendente.
 */

SELECT Products.ProductID, Products.Price FROM Products WHERE SupplierID IS NULL AND Price >10 ORDER BY Price;

/*
 Muestra el nombre del cliente,
 la ciudad y el país de aquellos clientes cuyo país sea "USA", "Canada" o "Mexico",
 y cuyo código postal empiece con "902"
 */
 SELECT Customers.CustomerName, Customers.Country, Customers.City FROM Customers
      WHERE Country IN ('USA', 'Canada', 'Mexico')
        AND PostalCode LIKE '902%';

/*
 Recupera los productos con el precio promedio más alto de cada categoría.
 */

 SELECT Products.ProductName, AVG(Products.Price) FROM Products GROUP BY CategoryID;
