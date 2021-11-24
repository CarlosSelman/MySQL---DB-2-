use curso;
-- ************************************************************
-- LABORATORIO DML
-- Carlos Selman 2018325 IN5BM
-- ************************************************************
-- 01. Consultas a una tabla:
-- ************************************************************
-- 1) Seleccionar todos los datos de las tablas para conocerlas.

	select * from clientes;
    
-- 2) Seleccionar únicamente el campo de razón social de la tabla 
-- clientes.

	select Cli_RazonSocial from clientes;
    
--  3) Seleccionar únicamente el cliente con el id = 5.

	select * from clientes where Cli_id = 5;
    
--  4) Seleccionar los clientes donde el id sea mayor a 10.

	select * from clientes where Cli_id > 10;
    
--  5) Seleccionar todos los productos que su estado sea igual a 0 
-- (inactivos) y su precio sea mayor a 100).

	select * from productos 
	where Prod_Status = 0 and Prod_Precio >= 100;
    
--  6) Utilizando operadores relacionales y paréntesis para dar
-- jerarquía a las operaciones, selecciona los productos que su
-- precio sea mayor a 100 y (el estado sea igual a 0, o (el estado
-- del producto sea igual 1 y el proveedor 97)).

	select * from productos
	where Prod_Precio > 100 and 
	(Prod_Status = 0 or (Prod_Status = 1 and Prod_ProvId = 97));
    
--  7) Selecciona el id del cliente, el total de ventas y la fecha de
-- las ventas de la tabla ventas. Dónde la fecha sea mayor al 3
-- de enero del 2018, y menor al 10 de enero, y además que no
-- sean del cliente 1 ya que es el consumidor final y el total de
-- ventas sea mayor a 1,000.

	select Ventas_CliId, Ventas_Total, Ventas_Fecha from ventas
	where Ventas_Fecha > "2018-01-03" 
	and Ventas_Fecha < "2018-01-18"
	and Ventas_CliId <> 1
	and Ventas_Total > 1000;
    
-- ************************************************************
-- 02. Consultas a múltiples tablas:
-- ************************************************************
--  1) Seleccionar las ventas mostrando la fecha, el número de
-- factura, el total y la razón social del cliente. Utilizar la
-- sintaxis implícita.

	select
    Ventas_Fecha,Ventas_NroFactura,Ventas_Total,Ventas_CliId,
    Cli_Id,Cli_RazonSocial
	from ventas, clientes
	where Ventas_CliId = Cli_Id;
    
--  2) Seleccionar las ventas mostrando la fecha, el número de
-- factura, el total y la razón social del cliente. Utilizar la
-- sintaxis explícita.

	select ventas.Ventas_Fecha,ventas.Ventas_NroFactura,
	ventas.Ventas_Total,ventas.Ventas_CliId,clientes.Cli_Id,
	clientes.Cli_RazonSocial
	from ventas, clientes
	where ventas.Ventas_CliId = clientes.Cli_Id;
    
-- -----------------------------------------------------------------
-- Nota: Sobre utilizar la forma explícita o implícita, depende la
-- nomenclatura definida y utilizada en los nombres de los campos
-- de las tablas de la base de datos que se esté utilizando.
-- -----------------------------------------------------------------

--  3) Selecciona la fecha, numero de venta, el total y el cliente.
-- Utilizando la forma implícita y alias de campos, para que los
-- encabezados sean utilizados en un reporte

	select ventas.Ventas_Fecha,ventas.Ventas_NroFactura,
	ventas.Ventas_Total,ventas.Ventas_CliId,clientes.Cli_Id,
	clientes.Cli_RazonSocial
	from ventas, clientes
	where ventas.Ventas_CliId = clientes.Cli_Id;
    
--  4) Realizar el ejercicio anterior referenciando campos
-- implícitamente, pero utilizando alias de tablas para hacer la
-- unión.

	select Ventas_Fecha as "FECHA",Ventas_NroFactura as "FACTURA",
	Cli_RazonSocial as "CLIENTE", Ventas_Total "TOTAL"
	from ventas as v, clientes as c 
	where v.Ventas_CliId  = c.Cli_Id;
    
--  5) Realiza el ejercicio anterior, utilizando alias de campos y
-- alias de tablas, para referenciar de forma explícita toda la
-- consulta.

	select ventas.Ventas_Fecha as "FECHA",
	ventas.Ventas_NroFactura as "FACTURA",
	clientes.Cli_RazonSocial as "CLIENTE",
	ventas.Ventas_Total "TOTAL"
	from ventas, clientes
	where ventas.Ventas_CliId  = clientes.Cli_Id;
    
--  6) Seleccionar del cliente (código cliente y la descripción) de la
-- venta (id venta, no. de factura, fecha), del producto (código
-- del producto, descripción, color), del detalle de la venta
-- (cantidad, precio) y del proveedor (nombre del proveedor del
-- producto). Utilizar alias tanto de campos como de tablas
-- para realizar la consulta.

	select 
	c.Cli_Id as "CODIGO CLIENTE", c.Cli_RazonSocial as "CLIENTE",
	v.Ventas_Id as "CODIGO DE VENTA",v.Ventas_NroFactura as "FACTURA", v.Ventas_Fecha as "FECHA",
	p.Prod_Id as "CODIGO DE PRODUCTO", p.Prod_Descripcion as "PRODUCTO",
	vd.VD_Cantidad "CANTIDAD", vd.VD_Precio as "IMPORTE",
	pr.Prov_Nombre as "PROVEEDOR"
	from 
    clientes as c, ventas as v, ventas_detalle as vd,
    productos as p,proveedores as pr
	where c.Cli_Id=v.Ventas_CliId and
    v.Ventas_Id = vd.VD_VentasId and  
    vd.VD_ProdId = p.Prod_Id and
    p.Prod_ProvId=pr.Prov_Id;
    
-- ************************************************************
-- 03. Cláusulas Order By, Bewtween y Like:
-- ************************************************************
-- CLAUSULAS ORDER BY
-- -----------------------------------------------------------------
-- 1) Ordenar la tabla clientes de forma ascendente respecto al
-- campo de la razón social utilizando la cláusula Order By.

	select * from clientes order by Cli_RazonSocial asc;
    
-- 2) Ordenar la tabla clientes de forma descendente respecto al
-- campo de la razón social utilizando la cláusula Order By.

	select * from clientes order by Cli_RazonSocial desc;
    
-- 3) Ordenar la tabla productos por la descripción del producto
-- de forma ascendente y el precio descendente, utilizando la
-- cláusula Order By.

	select * from productos order by Prod_Descripcion asc, Prod_Precio desc;
-- -----------------------------------------------------------------
-- CLAUSULAS BETWEEN
-- -----------------------------------------------------------------
-- 4) Mostrar las ventas de un rango de fechas determinado
-- utilizando la cláusula BETWEEN.

	select Ventas_Fecha,Ventas_CliId,Ventas_Total
    from ventas
    where Ventas_Fecha between "2018-01-01" and "2018-01-31";
    
-- 5) Mostrar las ventas a un rango de clientes entre 1 y 60
-- utilizando la cláusula BETWEEN.

    select Ventas_Fecha,Ventas_CliId,Ventas_Total
    from ventas
    where Ventas_CliId between 1 and 60;
-- -----------------------------------------------------------------
-- CLAUSULA LIKE
-- -----------------------------------------------------------------
-- 6) Mostrar todos los productos que terminen con la letra "D"
-- utilizando la cláusula LIKE.

	select Prod_Id,Prod_Descripcion,Prod_Color
	from productos
	where Prod_Descripcion like "%D";
    
-- 7) Mostrar todos los productos que terminen con AD,
-- utilizando la cláusula LIKE. 

	select Prod_Id,Prod_Descripcion,Prod_Color
	from productos
	where Prod_Descripcion like "AD%"; 
    
-- 8) Mostrar todos los productos que contengan AD, en
-- cualquier parte de la descripción, utilizando la cláusula
-- LIKE.

	select Prod_Id,Prod_Descripcion,Prod_Color
	from productos
	where Prod_Descripcion like "%AD%"


