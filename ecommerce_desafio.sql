create database ecommerce_final;

use ecommerce_final;

create table clients(
idClient int auto_increment primary key,
Fname varchar(10),
Minit char(3),
Lname varchar(20),
CPF char(11) not null,
Address varchar(60),
constraint unique_cpf_client unique (CPF)
 );
create table product(
idProduct int auto_increment primary key,
Pname varchar(20),
classification_kids bool default false,
category enum('Eletrônico', 'Vestimenta','Brinquedos','Alimentos','Móveis') not null,
avaliação float default 0,
size varchar(10)
 );
 
create table payments(
idClientP int,
id_payment int,
id_productP int,
typePayment enum('Boleto', 'Cartão Crédito', 'Cartão Débito') default 'Boleto',
primary key(idClientP, id_payment, id_productP),
constraint fk_pay_order foreign key (id_payment) references orders(idOrder),
constraint fk_pay_idClient foreign key (idClientP) references clients(idClient),
constraint fk_pay_prod foreign key (id_productP) references product(idProduct)
 );
create table orders (
idOrder int auto_increment primary key,
idOrderClient int,
orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
orderDescription varchar(255),
sendValue float default 10,
paymentCash boolean default false,
foreign key (idOrderClient) references clients(idClient)
);
create table productStorage (
idprodStorage int auto_increment primary key,
storageLocation varchar(255),
quantityy int default 0
);
create table productSupplier(
idPsSupplier int,
idPsProduct int,
quantity int not null,
primary key (idPsSupplier, idPsProduct),
constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);
create table supplier (
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact varchar(11) not null,
constraint unique_supplier unique (CNPJ)
);
create table seller (
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15),
AbstName varchar(255),
CPF char(15),
location varchar(255),
contact varchar(11) not null,
constraint unique_supplier unique (CNPJ),
constraint unique_cpf_seller unique (CPF)
);
create table productSeller(
idPseller int,
idPproduct int,
prodQuantity int default 1,
primary key (idPseller, idPproduct),
constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
create table productOrder(
idPOproduct int,
idPOorder int,
poQuantity int default 1,
poStatus enum('Disponível','Sem estoque') default 'Disponível',
primary key (idPOproduct, idPOorder),
constraint fk_productorder_seller foreign key (idPOproduct) references seller(idPOproduct),
constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);
create table storageLocation(
idLproduct int,
idLstorage int,
location varchar(255) not null,
primary key (idLproduct, idLstorage),
constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

-- Queries
select * from client as c where c.id=1;

select concat(c.Fname, ' ', c.Lname) as Client_name, pa.id_payment, 
pa.idClientP, pa.id_productP from payments as pa
inner join clients as c 
where pa.id_payment = c.idClient;


select concat(c.Fname, ' ', c.Lname) as Client_name, p.Pname as Product, pa.typePayment
from clients as c join payments pa on c.idClient = idClientP
join product as p on pa.id_productP = p.idProduct
order by pa.id_payment;


select concat(c.Fname, ' ', c.Lname) as Client_name, 
concat('00', pa.id_payment) as id_pay, p.Pname as Product, 
pa.typePayment, o.quantityProdOrder as quantity_pruduct , concat('R$ ',o.sendValue) send_value, 
concat('R$ ', round(o.sendValue * quantityProdOrder, 2)) as Final_value
from clients c join payments pa on c.idClient = idClientP
join product p on pa.id_productP = p.idProduct
join orders o on o.idOrder = idClientP
group by pa.id_payment;

	
-- Inserindo dados
insert into clients (Fname, Minit, Lname, CPF, Address)
values	('Carlos','C','Filho', 25896374158,'Rua 7, Jaú - Bahia'),
		('Camila','H','Abreu', 12345678910,'Avenida 10, Dominos - São Paulo'),
		('Jean','K','Ferreira', 57896321458,'Alameda 20, Hortências - Araraquara'),
		('Pedro','A','Junior', 14789632503,'Avenida Feijó, 200 Centro - Araraquara');
                         
                         
 insert into product (Pname, classification_kids, category, avaliação, size) 
 values	('Celular',false,'Eletrônico','4',null),
		('Mouse',true,'Eletrônico','3',null),
        ('Camiseta',true,'Vestimenta','5','M');
                        
insert into orders(idOrderClient, orderStatus, orderDescription, sendValue, quantityProdOrder) 
values	(1, default, 'entregar em 15 dias', 20.20,10),
        (2, 'Cancelado','a vista', 50.90,2),
        (3, 'Confirmado', null, 6.99, 1);
                            
insert into productStorage (storageLocation, quantity) 
values	('Bahia',30),
        ('São Paulo', 400),
        ('Minas Gerais', 410);
        
insert into productsupplier (idPsSupplier, idPsProduct, quantity) 
values	(1,1,100),
        (2,2,400),
        (3,4,90),
        (1,3,100),
        (2,5,2);
        
insert into supplier (SocialName, CNPJ, contact) 
values	('Americanas',003578584510001,'963587412'),
        ('Lojas mil',578963254789652,'587965412'),
        ('100% vc', 457896541236547, '12345879');
        
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) 
values	('Ave',null,968556789456321,null,'São Paulo',1147855147),
        ('Pharma', null, null, 658756783, 'Bahia', 887458965),
        ('Match', null, 478589123654485, null, 'Rio de Janeiro', 2147896247);       

insert into productSeller (idPseller, idPproduct, prodQuantity) 
values (1,3,09),
       (2,5,23);
       
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) 
values	(1,1,2,default),
        (2,1,1,default),
        (3,2,1,default);
                         
                         
insert into storagelocation (idLproduct, idLstorage, location) 
values	(1,2,'BA'),
        (2,5,'SP');