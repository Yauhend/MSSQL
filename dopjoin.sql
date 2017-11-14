
----1.	вывести перечень заказов (с детальной информацией о товаре) клиента 'Village Toys'
--select Orders.order_num,  OrderItems.quantity, OrderItems.item_price, Products.* from Customers
--join Orders on Customers.cust_id = Orders.cust_id 
--join OrderItems on Orders.order_num = OrderItems.order_num
--join Products on OrderItems.prod_id = Products.prod_id
--where Customers.cust_name = 'Village Toys'


----2.	какое количество заказов отправлено в штаты с индексом, начинающимся с 4 
--select COUNT(*) as kolvo_zakazov from Orders
--join Customers on Orders.cust_id = Customers.cust_id
--where Customers.cust_zip like '4%'

----3.	Вывести список всех производителей и самых дорогих товаров этих производителей

--select  Vendors.vend_name, p1.prod_name, p1.prod_price from Products p1
--join Vendors on p1.vend_id = Vendors.vend_id
--join (select Products.vend_id, MAX(prod_price) as price from Products 
--		group by vend_id) as p2 
--		on p2.vend_id = p1.vend_id AND p2.price = p1.prod_price



----4.	вывести информацию о товарах стоимость которых менее 5, с указанием  того, сколько заказчиков их заказано.




--select Products.prod_name, Products.prod_price, y.kolvo from Products
--join (
--	select prod_id, count (*) as kolvo from (
--		select distinct cust_id, OrderItems.prod_id from Orders
--		join OrderItems on OrderItems.order_num = Orders.order_num
--		join Products on Products.prod_id = OrderItems.prod_id
--		where Products.prod_price < 5)as x
--	group by prod_id)
--as y on y.prod_id = Products.prod_id




----5.	вывести информацию о товарах стоимость которых более 7, с указанием того, сколько единиц этого  товара было заказано.


--select Products.prod_name, Products.prod_price, y.kolvo from Products
--join (
--	select OrderItems.prod_id, SUM(OrderItems.quantity) as kolvo from Orders
--		join OrderItems on OrderItems.order_num = Orders.order_num
--		join Products on Products.prod_id = OrderItems.prod_id
--		where Products.prod_price > 7
--	group by OrderItems.prod_id)
--as y on y.prod_id = Products.prod_id




----6.	вывести наименование товаров производимых не в USA
--select prod_name, vend_country from Vendors
--join Products on Products.vend_id = Vendors.vend_id
--where vend_country <> 'USA'

----7.	 найти количество товаров производимых в USA 
--select COUNT(*) as kolvo from Vendors
--join Products on Products.vend_id = Vendors.vend_id
--where vend_country = 'USA'

--8.	вывести  перечень заказчиков которые совершили заказ на суму более 300
--9.	вывеси перечень заказчиков с указанием итоговой суммы всех заказов
--10.	Вывести список заказов с указанием числа производителей в каждом заказе
--11.	Найти заказчика который совершил заказ с наибольшим числом товаров разных производителей.  
