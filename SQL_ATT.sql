DROP TABLE IF EXISTS ENTREGA ,FORNECEM, FORNECEDORES, CONTEM, INCLUEM, VENDAS, COMPRAM, PRODUTOS, TRABALHAM_NO, SETORES, TEM, Tempo_de_Trabalho, ENDERECO, CLIENTE, FUNCIONARIO ,PESSOA;

CREATE TABLE PESSOA(
	cpf CHAR(11),
    sexo VARCHAR(20),
    nome VARCHAR(50),
    PRIMARY KEY(cpf)
    );

CREATE TABLE FUNCIONARIO(
	cpf_pessoa CHAR(11),
	cargo VARCHAR(50),
    informacoes_de_contrato VARCHAR(100),
    salario REAL,
    PRIMARY KEY(cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CLIENTE(
	cpf_pessoa CHAR(11),
	preferencia VARCHAR(50),
    cadastro VARCHAR(100),
    classe_social VARCHAR(50),
    PRIMARY KEY(cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ENDERECO(
	cpf_pessoa CHAR(11),
	cidade VARCHAR(100),
    rua VARCHAR(100),
    numero INTEGER,
    PRIMARY KEY(cidade, cpf_pessoa),
    FOREIGN KEY(cpf_pessoa) REFERENCES PESSOA(cpf) ON DELETE CASCADE
);

CREATE TABLE Tempo_de_Trabalho(
	cpf_pessoa CHAR(11),
	id INTEGER,
    desde VARCHAR(100),
    ate VARCHAR(100),
    PRIMARY KEY(id),
    FOREIGN KEY(cpf_pessoa) REFERENCES FUNCIONARIO(cpf_pessoa)
);

CREATE TABLE TEM(
	cpf_func CHAR(11),
	id_tempo INTEGER,
    PRIMARY KEY(cpf_func, id_tempo),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa),
	FOREIGN KEY(id_tempo) REFERENCES Tempo_de_Trabalho(id)
);

CREATE TABLE SETORES(
	tipo_de_produto VARCHAR(100),
	nome VARCHAR(50),
    informacoes VARCHAR(100),
    PRIMARY KEY(tipo_de_produto)
);

CREATE TABLE TRABALHAM_NO(
	cpf_func CHAR(11),
	tipo_de_produto VARCHAR(100),
    PRIMARY KEY(tipo_de_produto, cpf_func),
    FOREIGN KEY(tipo_de_produto) REFERENCES SETORES(tipo_de_produto),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa)
);

CREATE TABLE PRODUTOS(
	codigo INTEGER,
    nome VARCHAR(50),
    preco REAL,
    PRIMARY KEY(codigo)
);

CREATE TABLE COMPRAM(
	cpf_cliente CHAR(11),
	codigo_prod INTEGER,
    PRIMARY KEY(cpf_cliente, codigo_prod),
    FOREIGN KEY(cpf_cliente) REFERENCES CLIENTE(cpf_pessoa),
    FOREIGN KEY(codigo_prod) REFERENCES PRODUTOS(codigo)
);

CREATE TABLE VENDAS(
	cpf_func CHAR(11),
	id INTEGER,
    valor REAL,
    detalhes VARCHAR(100),
    PRIMARY KEY(id),
	FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa)
);

CREATE TABLE INCLUEM(
	codigo_produtos INTEGER,
	id_vendas INTEGER,
    qtde INTEGER,
    tipo_de_pagamento VARCHAR(50),
    PRIMARY KEY(codigo_produtos, id_vendas),
    FOREIGN KEY(codigo_produtos) REFERENCES PRODUTOS(codigo),
    FOREIGN KEY(id_vendas) REFERENCES VENDAS(id)
);

CREATE TABLE CONTEM(
	tipo_de_produto VARCHAR(100),
	codigo INTEGER,
    qtde INTEGER,
    PRIMARY KEY(tipo_de_produto, codigo),
    FOREIGN KEY(tipo_de_produto) REFERENCES SETORES(tipo_de_produto),
    FOREIGN KEY(codigo) REFERENCES PRODUTOS(codigo)
);

CREATE TABLE FORNECEDORES(
	cod_forn INTEGER,
	nome VARCHAR(50),
    localizacao VARCHAR(50),
    PRIMARY KEY(cod_forn)
);

CREATE TABLE FORNECEM(
	codigo INTEGER,
	cod_forn INTEGER,
    PRIMARY KEY(codigo, cod_forn),
    FOREIGN KEY(codigo) REFERENCES PRODUTOS(codigo),
	FOREIGN KEY(cod_forn) REFERENCES FORNECEDORES(cod_forn)
);

CREATE TABLE ENTREGA(
	cpf_func CHAR(11),
    id_vendas INTEGER,
    telefone VARCHAR(50),
    tempo_estimado_minutos INTEGER,
    numero_da_entrega INTEGER,
    PRIMARY KEY(numero_da_entrega, id_vendas),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIO(cpf_pessoa),
    FOREIGN KEY(id_vendas) REFERENCES VENDAS(id) ON DELETE CASCADE
);

INSERT INTO PESSOA(cpf, sexo, nome) 
VALUES	('13683347610', 'Masculino', 'Jo??o Figueiredo'), ('11465722321','Feminino', 'Joana Diaz'),
		('10221676213', 'Masculino', 'Bernardo ??vila'),('01226726607','Masculino', 'Cau?? de Souza'),
		('00702029916', 'Feminino', 'Beatriz Pereira'),('09219865515','Masculino', 'Anderson Monteiro'),
		('05018788109','Feminino', 'Maiara Silva'),('11726491202','Masculino', 'Roberto Oliveira'),
		('12092213718','Feminino', 'Bruna Ferreira'),('10792255961','Feminino', 'Jeniffer Rodrigues'),
        ('14687635904', 'Feminino', 'Sabrina Almeida') , ('56389100460', 'Masculino','Marcos Carvalho'),
		('15477219804', 'Feminino', 'Amanda Fernandes'),('11728546613', 'Masculino', 'Carlos Garcia'),
		('10091824766', 'Feminino', 'G??ssica Gomes'),('11020014271', 'Masculino', 'Kalel Lopes'),
		('12996548192', 'Feminino', 'Izadora Ferraz') , ('00312466122', 'Masculino', 'Matheus Mesquita'),
		('14028771655', 'Feminino', 'Mariana Neves'),('15562788114', 'Masculino', 'Gabriel Santana');
        
INSERT INTO FUNCIONARIO(cpf_pessoa, cargo, informacoes_de_contrato, salario)
VALUES	('13683347610', 'Entregador', 'Paraguaio', 1650), ('11465722321', 'Operador de Caixa', 'Brasileira', 1870),
		('10221676213', 'Empacotador', 'Argentino', 1212), ('01226726607', 'Estoquista', 'Argentino', 1450),
		('00702029916', 'Operador de Caixa', 'Brasileira', 1870), ('09219865515','Repositor', 'Peruano', 1450),
        ('05018788109', 'Auxiliar Administrativo', 'Brasileira', 2120), ('11726491202', 'A??ougueiro', 'Argentino', 2000),
		('12092213718', 'Confeiteira/Padeira', 'Brasileira', 1900), ('10792255961', 'Gerente', 'Brasileira', 2800);
        
INSERT INTO CLIENTE(cpf_pessoa, preferencia, cadastro, classe_social)
VALUES  ('13683347610', 'Sim', 'Sim', 'Classe B'), ('11465722321', 'Sim', 'N??o', 'Classe B'),
		('10221676213','Sim', 'Sim', 'Classe D'), ('01226726607', 'Sim', 'Sim', 'CLasse C'),
        ('00702029916', 'N??o', 'Sim', 'Classe E'), ('09219865515', 'N??o', 'N??o', 'Classe C'),
        ('05018788109', 'Sim', 'Sim', 'Classe D'), ('11726491202', 'Sim', 'Sim', 'Classe C'),
        ('12092213718', 'N??o', 'Sim', 'Classe C'), ('10792255961', 'N??o', 'Nao', 'Classe A');

INSERT INTO ENDERECO(cpf_pessoa, cidade, rua, numero)            
VALUES 	('13683347610', 'Quinta do Sol', 'Rua Triangulo Austral', 327), ('11465722321', 'Quinta do Sol', 'Rua Merc??rio', 629),
		('10221676213', 'Quinta do Sol', 'Rua Tr??s Marias', 492), ('01226726607', 'Quinta do Sol', 'Rua Vega', 813),
        ('00702029916', 'Engenheiro Beltr??o', 'Avenida Brasil', 215), ('09219865515', 'Quinta do Sol', 'Avenida Centauro', 339),
        ('05018788109', 'Engenheiro Beltr??o', 'Rua Dom Pedro II', 584), ('11726491202', 'Quinta do Sol', 'Rua Orion', 023),
        ('12092213718', 'Engenheiro Beltr??o', 'Rua Duque de caxias', 1022), ('10792255961', 'Quinta do Sol', 'Avenida Centauro', 637);
        
INSERT INTO Tempo_de_Trabalho(cpf_pessoa, id, desde, ate)
VALUES 	('13683347610', 0001, '12-01-2000', '30-09-2013'), ('11465722321', 0008, '01-05-2003', '01-09-2015'),
		('10221676213', 0009, '28-05-2003','15-04-2016'), ('01226726607', 0013, '09-03-2004','05-02-2016'),
        ('00702029916', 0018, '17-04-2005','18-06-2021'), ('09219865515', 0023, '23-09-2005','31-05-2017'),
        ('05018788109', 0030, '10-05-2006','09-06-2018'), ('11726491202', 0047, '25-11-2007','25-04-2022'),
        ('12092213718', 0050, '16-06-2007','01-08-2019'), ('10792255961', 0057, '02-12-2008','11-09-2020');
        
INSERT INTO TEM(cpf_func, id_tempo)
VALUES 	('13683347610', 0001), ('11465722321', 0008),
		('10221676213', 0009), ('01226726607', 0013),
		('00702029916', 0018), ('09219865515', 0023),
		('05018788109', 0030), ('11726491202', 0047),
		('12092213718', 0050), ('10792255961', 0057);
        
INSERT INTO SETORES(tipo_de_produto, nome, informacoes)
VALUES 	('Bebidas', 'Coca-Cola', 'Compre uma leve duas'), ('Padaria', 'P??o_Franc??s', 'Fresco e feito na hora'),
		('Alimentos_n??o_Perec??veis/Enlatados', 'Arroz', '5 kg'), ('Frios', 'Queijo', 'Peda??o (1kg)'),
        ('Hortifruti', 'Batata', 'Tipo Batata monalisa'), ('Higiene', 'Papel Higi??nico', 'Leve 12 e Pague 11'),
        ('Papelaria', 'Caneta', 'Canetas nas cores azul, preta e vermelha'),('A??ougue', 'Frango', 'Frango Caipira'),
		('Produtos de Limpeza', 'Detergente', 'Marca Limpol'), ('Alimentos Perec??veis/Embalados', 'Ketchup', 'Ketchup Heinz (397g)');

INSERT INTO TRABALHAM_NO(cpf_func, tipo_de_produto)
VALUES 	('13683347610','Bebidas'), ('11465722321','Padaria'), 
		('10221676213','Alimentos_n??o_Perec??veis/Enlatados'), ('01226726607','Frios'),
        ('00702029916','Hortifruti'), ('09219865515','Higiene'), 
        ('05018788109','Papelaria'), ('11726491202','A??ougue'),
        ('12092213718','Produtos de Limpeza'), ('10792255961','Alimentos Perec??veis/Embalados');

INSERT INTO PRODUTOS(codigo, nome, preco) 
VALUES 	(20, 'Coca-cola', 6.40),(189, 'P??o_Franc??s', 1.07),
		(199, 'Arroz', 23.29), (77, 'Queijo', 34.99),
        (50, 'Batata', 1.52),(41, 'Papel Higi??nico', 13.67),
        (32, 'Caneta', 1.50),(382, 'Frango', 15.99),
        (109, 'Detergente', 1.75),(247, 'Ketchup', 7.57);

INSERT INTO COMPRAM(cpf_cliente, codigo_prod)
VALUES 	('13683347610', 20), ('11465722321', 189),
		('10221676213', 199), ('01226726607', 77),
        ('00702029916',50), ('09219865515', 41),
        ('05018788109',32), ('11726491202',382),
        ('12092213718',109), ('10792255961',247);
        
INSERT INTO VENDAS(cpf_func, id, valor, detalhes)
VALUES 	('11465722321', 0029, 225.59, 'Pagamento_Em_Dinheiro'), ('00702029916', 0034, 413.07, 'Pagamento_No_Cart??o_Cr??dito'),
		('00702029916', 0039, 50.99, 'Pagamento_No_Cart??o_D??bito'), ('11465722321', 0046, 67.28, 'Pagamento_Em_Dinheiro'),
		('00702029916', 0047, 509.91, 'Pagamento_No_Cart??o_D??bito'), ('00702029916', 0051, 724.23, 'Pagamento_Em_Dinheiro'),
		('11465722321', 0055, 100.86, 'Pagamento_No_Cart??o_Cr??dito'), ('11465722321', 0063, 26.79, 'Pagamento_No_Cart??o_Cr??dito'),
		('11465722321', 0068, 217.17, 'Pagamento_No_Cart??o_D??bito'), ('00702029916', 0070, 15.66, 'Pagamento_Em_Dinheiro');

INSERT INTO INCLUEM(codigo_produtos, id_vendas, qtde, tipo_de_pagamento)
VALUES 	(20, 0029, 7, 'Dinheiro'), (189, 0034, 14, 'Cart??o'),
		(199, 0039, 2, 'Cart??o'), (77, 0046, 3, 'Dinheiro'),
        (50, 0047, 18, 'Cart??o'), (41, 0051, 25, 'Dinheiro'),
        (32, 0055, 4, 'Cart??o'), (382, 0063, 1,'Cart??o'),
        (109, 0068, 9, 'Cart??o'), (247, 0070, 1, 'Dinheiro');

INSERT INTO CONTEM(tipo_de_produto, codigo, qtde)
VALUES 	('Bebidas', 20, 3600), ('Padaria', 189, 500),
		('Alimentos_n??o_Perec??veis/Enlatados', 247, 520), ('Frios', 77, 1600),
        ('Hortifruti', 50, 1400), ('Higiene', 41, 2000),
        ('Papelaria', 32, 4000), ('A??ougue', 382, 2860),
        ('Produtos de Limpeza', 109, 1700), ('Alimentos Perec??veis/Embalados', 199, 3090);

INSERT INTO FORNECEDORES(cod_forn, localizacao, nome)
VALUES 	(012386, 'Sorocab-SP', 'Bertin'), (098216, 'Jardim Carmela Campo Largo-PR', 'Oesa'),
		(082942, 'Curitiba-PR', 'Maxxi Atacado'),(071652, 'Rio Grande da Serra-SP', 'Seara'),
		(024726, 'Maring??-PR', 'Ceasas'), (050291, 'Vila Cordeiro S??o Paulo-SP', 'Procter & Gamble'),
        (032215, 'Vila Gertrudes-SP', 'Unilever'), (062195, 'Campo Mour??o-PR', 'Alvorada Papelaria'),
        (016543, 'Maring??-PR', 'Assai Atacadista'), (016942, 'Vila Ol??mpia-SP', 'Diageo');

INSERT INTO FORNECEM(codigo, cod_forn)
VALUES 	(20, 012386), (189, 098216),
		(199, 082942), (77, 071652),
        (50, 024726), (41, 050291),
        (32, 032215), (382, 062195),
        (109, 016543), (247, 016942);
        
-- S?? tem apenas um Entregador inserido no SQL
INSERT INTO ENTREGA(cpf_func, id_vendas, telefone, tempo_estimado_minutos, numero_da_entrega)
VALUES 	('13683347610', 0029, '5544984385294', 22 , 010),('13683347610', 0034, '5544984918826', '30', 019),
		('13683347610', 0039, '55449841775829', '40 ', 045),('13683347610', 0046, '5544984291752', '15', 028),
        ('13683347610', 0047, '5544984092751', '60', 080),('13683347610', 0051, '5544984221174', '20', 070),
        ('13683347610', 0055, '5544984175829', '45', 061),('13683347610', 0063, '5544984145723', '50', 090),
        ('13683347610', 0068, '5544984019345', '35', 092),('13683347610', 0070, '5544984427756', '25', 011);