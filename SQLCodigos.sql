--Para crear BBDD
create database nameBBDD

--Para eliminar BBDD
drop database nameBBDD

--Para indicar la base que usaremos
use nameBBDD

--Para crear una tabla
create table nameTable(
		tipo1 int, 
		tipo2 varchar(15),
		tipo3 datetime,
		tipo4 datetime2,
		tipo5 float
);

--Para eliminar tablas
drop table nameTable

--Para establecer clave primaria
--1era forma
create table empleados(
	id_empleado int,
	constraint pk_id_empleado primary key(id_empleado)
);
--2da forma
create table rol(
	id_rol int constraint pk_id_rol primary key
);

--Para establecer clave foranea
create table contrato(
--1era forma
	id_empleado int constraint fk_id_empleado foreign key references empleados(id_empleado),
--2da forma
	id_rol int
	constraint fk_id_rol foreign key references rol(id_rol)
);

--Para agregar campos a una tabla
alter table nameTable
add nameCampo varchar(15) not null; --Se¤alar que no es nullo siempre

--Para eliminar una columna o campo de una tabla
alter table nameTable
	drop column nameCampo;
	
--Para eliminar registros (filas)
delete from compra
where fecha is not null

--Para modificar tabla y a¤adir clave primaria a un campo determinado
alter table ejemplo
add constraint pk_id_ejemplo primary key(id_ejemplo); --antes el campo tiene que ser declarado no nulo

--Para modificar tabla y a¤adir clave foranea a un campo determinado
alter table ejemplo
add id_empleado int not null --el campo tiene que ser no nulo
constraint fk1_id_empleado foreign key references empleados(id_empleado);

--Para modificar el tipo de dato de un campo o columna
alter table ejemplo
alter column precio float; --antes precio era "int" ahora es "float" 

--Para modificar los registros o datos de un campo 
update tarifario set tarifa = 300 where cod_tarifario=12

--Configurar la base de datos para hacer el diagrama
--1. Anticlik a la base de datos -> propiedades -> files -> owner(propietario) 3 puntos -> browe -> buscar "sa" 
--2.Guardar cambios

--Para Visualizar grafico
--1.Se va a DataBaseDiagrams -> anticlick -> newDatabaDiagram -> seleccionar todo las tablas -> add
--2. Guardar cambios.


--Para insertar valores o datos a una tabla
--insercion en todos los campos
insert into empleados
values(20,'Gerson');
--insercion en determinados campos (esos campos deben ser nulos o null)
insert into empleados (id_empleado,edad) --aqui se especifica los campos
values(18,3);

--Insertando en una tabla dependiente (contrato_empresa)
insert into empresa
values('1018', 'Hiraoka'); --primero se inserta en la tabla principal
insert into contrato_empresa --luego se inserta en la tabla dependiente
values('101', '1018', 150, 10, 15, '01/01/2022', '10/01/2022', 150.5);

--Para visualizar todos los campos 
select * from empleados; --el * indica todos los campos

--Para visualizar determinados campos
select nombre,edad --campos determinados o escogidos
from empleados --tabla donde se encuentran esos campos

--Ordenamiento por mas de un campo (se ordena por jerarquia, ejm: country absorbe a city)
select customerid, companyname, country, city from customers
order by country asc, city desc; --ordena por mas de un campo

--Funciones de fecha (year,MONTH,DAY)
select orderid, customerid, orderdate, 
year(orderdate) as a¤o, month(orderdate) as mes, day(orderdate) as dia
--indica solo el a¤o, el mes y el dia
from orders; 

--Uso de la clausula DISTINCT (se usa para no repetir los nombres
--solo se reporta registros unicos)
--Ejemplo: 
select distinct city --reporta ciudades unicas
from customers order by city;
--NOTA: Se puede repetir siempre que sea necesario.
--Ejemplo: Mismo pais y ciudad pero diferentes clientes.
select distinct companyname,country, city --repite pais y ciudad pero no cliente
from customers
order by country, city;

--Restricciones (Where) 
--Ejemplo1: Reportar la relaci¢n de productos cuyo precio sea menor a 45
select ProductID, ProductName, UnitPrice from products --determinados campos de products
where UnitPrice < 45; --restriccion
--Ejemplo2: Reportar la relaci¢n de productos
--cuyo precio est‚ comprendido entre 25 y 60
select ProductID, ProductName, UnitPrice from products
where unitprice >= 25 and unitprice <= 60 --restriccion
order by unitprice asc; --ordena de manera ascendente acorde a unitprice
order by unitprice desc; --ordena de manera descendente acorde a unitprice
--Nota: por defecto el "order by" lo ordena de manera ascendente.
--Ejemplo3: Reportar la relaci¢n de clientes que sean de Mexico o Argentina o Brazil
select CustomerID, CompanyName, Country from Customers
where country = 'Mexico' or Country = 'Argentina' or Country = 'brazil' --restriccion
order by Country;
--Ejemplo4: Reportar todos los clientes excepto los de Mexico
select  CustomerID, CompanyName, Country from Customers
where country <> 'mexico' --restriccion 
order by country;
--Nota: tambien se puede usar != como signo de diferente pero es informal
--Ejemplo5: Reportar la relaci¢n de clientes que no sean de Mexico ni Argentina ni Brazil
select  CustomerID, CompanyName, Country from Customers
where Country <> 'Mexico' and country <> 'Brazil' and country <> 'Argentina' --restriccion
order by country;
----Ejemplo6: Reportar todas las ordenes generadas en 1997
select  OrderID, CustomerID, OrderDate from Orders
where year(orderdate) = '1997' --restriccion y uso de las funciones de datetime (year,day,etc)

--Uso de LIKE
--Ejemplo1: Reportar la relaci¢n de clientes cuyo nombre empiece con la letra c
select CustomerID, CompanyName from customers 
where companyname Like 'c%'; --restriccion y uso de LIKE(el % indica todo el resto)
--Ejemplo2: Reportar la relaci¢n de clientes cuyo nombre culmine con la letra s
select CustomerID, CompanyName from customers 
where companyname Like '%s'; --restriccion y uso de LIKE
--Ejemplo3: Reportar la relaci¢n de clientes cuyo nombre contenga en su tercer caracter la letra n
select CustomerID, CompanyName from customers 
where companyname Like '__n%'; --restriccion y uso de LIke(el _ indica cada espacio de caracter)
--Ejemplo4: Reportar la relaci¢n de clientes cuyo nombre no empiece con la letra c
select CustomerID, CompanyName from customers 
where companyname not Like 'c%'; --restriccion y uso de no like(indica lo contrario todo menos eso)

--Uso del BETWEEN
--Ejemplo: Reportar la relaci¢n de productos cuyo precio est‚ comprendido entre 25 y 60
select ProductID, ProductName, UnitPrice from products
where UnitPrice between 25 and 60 --uso del BETWEEN
order by unitprice;

--Uso del IN
--Ejemplo: Reportar la relaci¢n de clientes que sean de Mexico o Argentina o Brazil
select CustomerID, CompanyName, Country from Customers
where country in('Mexico', 'argentina','brazil'); --uso del IN
--Ejemplo2: Reportar la relaci¢n de clientes que no sean de Mexico o Argentina o Brazil
select CustomerID, CompanyName, Country from Customers
where country not in('Mexico', 'argentina','brazil')--uso del NOT IN
order by country;

--Formas de reportar 
--Ejemplo1: Reportar todas las ordenes generadas en agosto de 1996
--forma1
select orderid,CustomerID, OrderDate from orders
where OrderDate >= '08/01/1996' and OrderDate <= '08/31/1996'; 
--forma2
select orderid,CustomerID, OrderDate from orders
where orderdate between '08/01/1996' and '08/31/1996'; --uso del BETWEEN
--forma3
select orderid,CustomerID, OrderDate from orders
where year(orderdate) = '1996' and month(OrderDate) = '08'; --uso de las funciones de datetime

--Ejemplo2: Reportar la relaci¢n de productos que sean de categor¡a Bebida o Condimentos
--forma1
select ProductID, ProductName, CategoryID, UnitPrice from products
where CategoryID in(1,2);
--forma2
select ProductID, ProductName, CategoryID, UnitPrice from products
where categoryid = 1 or CategoryID = 2;
--Para identificar que es 1 y 2
select CategoryID, CategoryName from Categories
where CategoryID in(1,2)

--Uso de alias para el campo de una tabla
select ProductID, ProductName as Nombre from products; --El as indica alias

--Uso de alias para un tabla
select p.ProductID, P.ProductName from products as p; --El as indica alias
--Ejemplo1: Reportar la relaci¢n de productos (campos b sicos) y la categor¡a
select p.ProductID, p.ProductName, c.CategoryID 
from Products as p, Categories as c
where p.CategoryID = c.CategoryID --Evita que los datos se repitan pues en ambas tablas esta el categoryID
--Ejemplo2: Se desea un reporte de los productos vendidos en cada orden.
--al mismo tiempo se desea saber los datos del cliente, pero
--solo para las ordenes de 1996
select p.ProductID, p.ProductName, c.CustomerID, c.CompanyName,o.OrderDate
from orders as o,Customers as c, Products as p, [Order Details] as d
where c.CustomerID = o.CustomerID and year(o.OrderDate) = '1996' and
o.OrderID = d.OrderId and p.ProductID = d.ProductID;

--Para mostrar datos repitiendo los campos
select ProductID, ProductName, ProductID from products

--Uso de operadores aritmeticos (+/-/*/%, etc)
select  UnitPrice, UnitPrice % 10 as NuevoPrecio from Products

--FUNCIONES DE AGRUPAMIENTO
use Northwind
--contar * (todos los datos) de la tabla customers
select count(*) from Customers;

--Contar determinados campos de customers
--Ejemplo: companyName, region
--Nota: Los nullos no los contabiliza
select count(CompanyName) as contador1 from Customers;
select count(region) as contador2 from Customers;

--Contar la cantidad de datos "COUNT"
select count(region) from Customers; 

--Reportar la suma de precios de los productos de categoria bebida "SUM"
select sum(unitprice) 
from products
where categoryid = 1;

--Uso de Group by y avg (agrupar en grupos)
--Ejemplo1:Reportar el promedio de precios por cada categoria
select categoryid, avg(unitprice) --"avg" calcula el promedio
from products
group by CategoryID; --"GROUP by" los agrupa por categoria

select max(unitprice) from Products;
select min(unitprice) from Products;

--Ejemplo2: Reportar la suma de precios por cada categoria con el nombre de categoria
select c.CategoryName, sum(p.unitprice) as sumaPrecio
from products as p, Categories as c
where p.CategoryID = c.CategoryID
group by c.CategoryName;

--Agrupamiento por m s de un campo

--Ejemplo1: Se desea un reporte de cuantos clientes tenemos por pais y 
--al mismo tiempo por ciudad
--El que aboserve(country), el absorbido(city)
select country, city, count(companyname) as NumClientes
from customers
group by country, city
order by country, city;

--Ejemplo2: Se desea saber la suma de precios de productos por cada proveedor
--y por las categor¡as provistas
SELECT s.companyname, c.categoryname, sum(p.unitprice) as SumPrecio
from products as p, suppliers as s, categories as c
where p.supplierid = s.supplierid AND p.categoryid = c.categoryid
group by s.companyname, c.categoryname
order by s.companyname, c.categoryname;

--Ejemplo3: Se desea saber cuantas veces han comprado los clientes por cada a¤o
select c.CompanyName, year(o.orderdate) as a¤o, count(o.orderid) as numCompras
from orders as o, Customers as c
where c.CustomerID = o.CustomerID
group by c.CompanyName, year(o.orderdate)
order by c.CompanyName, year(o.orderdate);

--Ejemplo4: Se desea saber a cuanto asciende el valor de todo lo comprado por cada orden
SELECT d.orderid, sum(d.unitprice * d.quantity) as Total
	from [order details] as d
	group by d.orderid
	order by d.orderid;
	
--Uso del HAVING

--Ejemplo:Cu l es el promedio de productos solicitados (en t‚rmino de cantidad por cada producto solicitado) a trav‚s de las ¢rdenes durante 1997, 
--respectivamente por cada mes y por cada categor¡a. El reporte solo deber  contemplar los agrupamientos mayores a 25.

select month(o.OrderID) as mes, c.CategoryName, avg(d.Quantity) as promedio
from Products as p, [Order Details] as d, orders as o, Categories as c
where o.OrderID = d.OrderID and d.ProductID = p.ProductID and p.CategoryID = c.CategoryID and year(o.OrderDate) = 1997
group by month(o.OrderID),c.CategoryName--(duda del o.ordate y o.orderId de si es lo mismo)
having avg(d.Quantity) > 25 --USO DEL HABING COMO RESTRICCION
order by month(o.OrderID), c.CategoryName, avg(d.Quantity)	
--NOTA: where aplica a campos
--having actua como el where pero para datos agrupados o por grupos
	
--Consulta sobre consulta

--Ejemplo1: Reportar la relaci¢n de productos que sean de 
--categor¡a condimentos
select productid, productname, unitprice
from products 
where categoryid = (select categoryid 
						from categories
					where categoryname = 'Condiments');
					
--Ejemplo2: Reportar la relaci¢n de productos que sean de 
--categor¡a bebida o comida marina o confecciones	
select productid, productname, unitprice
from products
where categoryid = (select categoryid 
		from categories where categoryname = 'seafood') 
	or categoryid = (select categoryid 
		from categories where categoryname = 'confections') 
	or categoryid = (select categoryid 
		from categories where categoryname = 'beverages');
		
--Ejemplo3: Reporte la relaci¢n de productos comprados por  
--el cliente: Island Trading 
--(Haga uso sub consultas y consulta simultanea a multiples tablas)
select ProductName
from products
where ProductID in (
	select distinct ProductID from [Order Details]
		where OrderID in (select OrderID
			from Orders where CustomerID = (select CustomerID 
				from Customers
				where CompanyName = 'Island Trading')));

--Ejemplo4: Reporte todo lo vendido a los clientes provenientes 
--de: Londres, Berlin o Lisboa 
--(haga uso sub consultas y consulta simultanea a multiples tablas)
select ProductID, Productname
from Products
where ProductID in(
	select  distinct ProductID from [Order Details]
					where OrderID in (select OrderID
									from Orders
									where CustomerID in (select CustomerID 
														from customers
														where city in('Berlin', 'London', 'Lisboa'))))

--Clausula is NULL
--Ejemplo: Reportar la relaci¢n de clientes cuya regi¢n este en NULL
select * from customers 
where region is null; --Uso de NULL
--Ejemplo2: Reportar la relaci¢n de clientes cuya regi¢n no este en NULL
select * from Customers
where Region is not null;--USO DE IS NOT NULL


--Uso del RIGHT JOIN (fuerza a mostrar todos los datos de la tabla que este
 --a la derecha, esten o no nulos) 
--Nota: No requiere de claves primarias o secundarias para relacionarlos
-- basta con que tengan un campo en comun para relacionarse.Ejemplo: country.cName = customer.contryName
--Ejemplo: Mostrar la relaci¢n de categor¡as que a la fecha
--no se han usado para el registro de productos
select p.productname, c.categoryname
from products as p right join categories as c--Aqui fuerza a mostrar todo de categories
 ON p.categoryid = c.categoryid --El ON relacionas sus id
	where p.productname is null;--Restringue que el campo p.productname no sea null

--Uso del LEFT JOIN(Fuerza mostrar la tabla que este a la izquierda)
select c.categoryname, p.ProductName
from categories as c left join products as p--Fuerza a mostrar la tabla izquierda(categories)
	ON c.categoryid = p.categoryid--El ON relaciona sus id
	where p.productname is null;--Restringue que el campo p.productname no sea null

--Uso del FULL OUTER JOIN(Muestra datos de ambas tablas y la interseccion)
--Ejemplo: 
select p.productid, p.productname, c.categoryname
from products as p full outer join categories as c--Muestra todo products y categories 
			on p.categoryid = c.categoryid;--Relaciona los id
--Ejemplo2: Mostrar la relaci¢n de categor¡as que a la fecha
--no se han usado para el registro de productos
select c.categoryname
from products as p full outer join categories as c
	ON p.categoryid = c.categoryid--relaciona los id
	where p.productid is null;--Restringue a solo los nulos
 		
--Uso del INNER JOIN para 2 tablas(solo mostrara la interseccion de las tablas que se relacionen)
--Nota: Inner join tambien se usa para relacionar tablas no necesariamente con las claves primarias sino con algo que tengan en comun
--Ejemplo:Reportar datos b sicos de productos y el nombre de la compa¤¡a proveedora
SELECT p.productid, p.productname, s.companyname
from products as p inner join suppliers as s 
ON p.supplierid = s.supplierid;

--Uso del INNER JOIN para aludir a mas de 2 tablas(muestra la interseccion)
--Ejemplo:Reportar datos basicos de productos, el nombre de la compa¤ia proveedora Y
--el nombre de la categor¡a
select p.productid, p.productname, c.categoryname, s.companyname
from products as p inner join categories as c --Inner join actua como un relacionador
ON p.categoryid = c.categoryid inner join suppliers as s --en este caso relaciona products con suppliers
ON p.supplierid = s.supplierid;

--Uso del CREATE VIEW
--Ejemplo: Reportar la relaci¢n de productos 
--campos b sicos y el nombre de la categor¡a
create view vw_productoDeta as --Crea una tabla view donde reflajara(tipo guardar) todo el codigo que selecciona(select)
select p.ProductID,p.ProductName,p.UnitPrice, c.CategoryName
	from products as p inner join Categories as c
	on p.CategoryID = c.CategoryID

select * from vw_productoDeta--Una vez creado el view, se llama al view como una tabla y se le puede aplicar lo mismo que a una tabla
	where CategoryName = 'condiments'

--Ejemplo2: --Elaborar una vista que permita el reporte de todo lo b sico de una orden de venta
--Consignar datos de la venta, cliente, empleado, producto vendido

create view vw_VentaDetalle as
select o.OrderID,d.UnitPrice, d.Quantity,c.CompanyName, e.FirstName,d.ProductID
	from orders as o inner join [Order Details] as d on o.OrderID = d.OrderID
	inner join Customers as c on o.CustomerID = c.CustomerID 
	inner join Employees as e on e.EmployeeID = o.EmployeeID;
	
--Ejemplo3: Elaborar una vista que permita el reporte de todas las ordenes donde
--se haya aplicado descuentos
create view vw_VentasConDesc as
select distinct orderid
	from [order details]
	where discount > 0;--Al view tambien se le pone restricciones como a una tabla
	
--Ejemplo4:Elabore una vista que reporte el total de lo pagado por cada orden. Solo
--se requiere el CodOrden, fecha, cliente, empleado y monto total
create view vw_ReporteOrden as
select o.OrderID, o.OrderDate, c.CompanyName, e.FirstName, 
		(od.UnitPrice*od.Quantity)*(1 - od.Discount) as 'Monto Total'
	from Orders o inner join [Order Details] od on o.OrderID = od.OrderID--el as puede ser obviado, es decir, no se le puede poner
	inner join Employees e on o.EmployeeID = e.EmployeeID
	inner join Customers c on o.CustomerID = c.CustomerID
	
--Uso del Stored Procedures (SP) con paso de parámetros

--Ejemplo1:
create procedure sp_SelCliexCiud @ciudad nvarchar(40) as--nombreProcedimiento-@parametro-tipoDato as
select * from Customers
	where city = @ciudad --city = parametro
go
--Nota: @ciudad nvarchar(40) es la variable y el tipo de variable (parametro)
--Ejecuta el procedimiento creado
exec sp_SelCliexCiud @ciudad = 'Berlin'; --Uso del procedimiento
	
--Ejemplo2:Reportar a través de un SP, en la se pase como parámetro:
--OrderId (tipo entero)
--El Sp debe reportar el nombre del producto, precio unitario, cantidad
--precDesc y el descuento en una última columna el monto descontado

create procedure sp_repXOrderId @orderid int as
select p.ProductName, d.UnitPrice, d.Quantity, d.Discount, (d.UnitPrice*d.Quantity) - d.Discount as monto
	from Products as p inner join [Order Details] as d on p.ProductID = d.ProductID
	where d.OrderID = @orderid--d.OrderId = parametro
go 

execute sp_repXOrderId @orderid = 10249; --enviando parametro (10249)
	
--Ejemplo3:Crear un Sp que reciba como parámetro un par de fechas
--para reportar el país, apellidos y nombres de los empleados que despacharon
--determinadas ordenes en un determinado rango de tiempo (Las fechas)
--Se requiere el monto total de lo se despacho

--Paso 1: Crear un vista para capturar el total despachado por orden
create view vw_totXOrd as 
	select orderid, sum(quantity * unitprice) as montTot
		from [Order Details] 
	group by orderid
go
--Paso 2: Creando el SP vinculando la vista recientemente creada
--con Order y Employees
create procedure sp_repTotxRango @fi datetime, @ff datetime	as
		select o.orderid, e.EmployeeID, e.LastName, v.montTot, o.orderdate
			from employees as e inner join orders as o on o.EmployeeID = e.EmployeeID 
				inner join vw_totXOrd as v on o.OrderID = v.orderid
			where o.orderdate between @fi and @ff			
	go
	
--Ejecutar procedimiento
--Forma1 (mes/dia/yy)
exec sp_repTotxRango @fi = '01/01/1997', @ff = '12/31/1997'
	
	
-------------------------------TAREA
--Elabore una vista en la que se reporte la relaci¢n de empleados
--que participaron cuando se generaron ¢rdenes con descuentos.
--Use la vista vw_VentasConDesc

create view vw_relacionEmpleadosOCD as
select distinct e.FirstName
from orders as o inner join vw_VentasConDesc as vcd on o.OrderID = vcd.OrderID
	inner join Employees as e on e.EmployeeID = o.EmployeeID
	
select * from vw_relacionEmpleadosOCD;

--Comprobacion
select distinct e.FirstName, d.Discount
from [Order Details] as d, Orders as o, Employees as e
where d.OrderID = o.OrderID and e.EmployeeID = o.EmployeeID and d.Discount>0
order by e.firstName;