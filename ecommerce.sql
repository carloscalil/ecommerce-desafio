-- criação do banco de dados para o cenário de E-ccomerce
-- drop table eccomerce;
-- show tables;
create database ecommerce;
use eccomerce;

 -- criar tabelas cliente
 create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(60),
    constraint unique_cpf_client unique (CPF)
 );
 
 alter table clients auto_increment=1;
 
 -- criar tabela produto
  create table product(
	idProduct int auto_increment primary key,
    Pname varchar(20),
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    avaliação float default 0,
    size varchar(10)
 );
 
 -- criar tabela pagamentos
 
create table payments(
idclient int,
id_payment int,
typePayment enum('Boleto','Cartão','Dois cartôes'),
limitAvailable float,
primary key(idClient,id_payment)
);
-- criar tabela pedidos
create table orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    quantityProdOrder int not null,
	foreign key (idOrderClient) references clients(idClient)
);

-- criar tabela estoque produto
create table productStorage (
	idprodStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor produto

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product (idProduct)
);

-- criar tabela fornecedor
                  
create table supplier (
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact varchar(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor

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

-- criar tabela vendedor produto

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- criar tabela ordem de pedido

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references seller(idPOproduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- criar tabela local estoque

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

                            
                            
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
                         