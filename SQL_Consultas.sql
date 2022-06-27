-- URL: https://github.com/ElderHenhique/SQL-Consultas.git

-- SQL_CONSULTAS
-- 1 Liste os nomes dos funcionarios de nacionalidade (informacoes_de_contrato) 'Brasileira' ou 'Argentino'
SELECT DISTINCT P.nome
FROM PESSOA P, FUNCIONARIO F
WHERE P.cpf = F.cpf_pessoa AND informacoes_de_contrato = 'Brasileira'
UNION
SELECT nome
FROM PESSOA P, FUNCIONARIO F
WHERE P.cpf = F.cpf_pessoa AND informacoes_de_contrato = 'Argentino';

 -- 2 Liste os nomes e classe social de todos os clientes, menos aqueles clientes que tenha classe social igual à 'Classe A' ou 'Classe D'
 SELECT DISTINCT P.nome, classe_social
 FROM CLIENTE C, PESSOA P
 WHERE P.cpf=C.cpf_pessoa AND P.cpf NOT IN(	SELECT DISTINCT C.cpf_pessoa
											FROM CLIENTE C, PESSOA P
											WHERE P.cpf= C.cpf_pessoa AND classe_social = 'Classe A' OR classe_social = 'Classe D'
											);
								
-- 3 Encontre o Cargo do funcionario que tem salario maior do que '2000'
SELECT cpf_pessoa, cargo, salario
FROM  FUNCIONARIO F
WHERE F.cpf_pessoa IN (SELECT F2.cpf_pessoa
						FROM FUNCIONARIO F2
                        WHERE salario > 2000
                        );                     

-- 4 Liste os produtos que tem o seu preco menor que 2 reais ou maior 20 reais
SELECT nome
FROM PRODUTOS
WHERE preco < 2.00
	UNION
SELECT nome
FROM PRODUTOS
WHERE preco > 20.00;

-- 5 Liste as vendas e seu valor em que o pagamento (detalhes) ocorreu apenas em em cartao, seja ele de crédito ou débito;
SELECT id, valor
FROM VENDAS V
WHERE V.id NOT IN(SELECT I.id_vendas
					FROM INCLUEM I
                    WHERE I.tipo_de_pagamento = 'Dinheiro');
                    
-- 6 Encontre o codigo dos fornecedores de localizacao em 'Maringá-PR' ou de localizacao terminada em 'SP'
SELECT cod_forn
FROM FORNECEDORES
WHERE localizacao = 'Maringá-PR'
UNION
SELECT cod_forn
FROM FORNECEDORES
WHERE localizacao LIKE '%SP';     

-- 7 Liste o nome das pessoas e a rua em que ela reside sem repetição, na qual o número da sua residência seja menor do que '499'
	SELECT DISTINCT P.nome
    FROM PESSOA P, ENDERECO E
    WHERE P.cpf = E.cpf_pessoa AND P.cpf IN(SELECT E.cpf_pessoa
												FROM ENDERECO E
												WHERE numero < 500);               

-- 8 Encontre o id das vendas e o tempo de entrega com a maior tempo estimado
SELECT E1.id_vendas, tempo_estimado_minutos
FROM ENTREGA E1
WHERE E1.tempo_estimado_minutos >= ALL(SELECT E2.tempo_estimado_minutos
									FROM ENTREGA E2);
                                
-- 9 Liste todos os produtos que foram vendidos que seu nome começe pela  sílaba 'C' ou todos os produtos que terminam com a letra 'O'  
SELECT P.nome
FROM PRODUTOS P, COMPRAM C
WHERE P.codigo = C.codigo_prod AND P.nome LIKE 'c%'
UNION
SELECT P2.nome
FROM PRODUTOS P2, COMPRAM C2
WHERE P2.codigo = C2.codigo_prod AND P2.nome LIKE '%o';                                           

-- 10 Conte quantas pessoas do sexo masculino são Funcionarios que trabalham como 'Entregador' ou que trabalham como 'Operador de Caixa'
SELECT COUNT(*) AS TOTAL
FROM PESSOA P, FUNCIONARIO F
WHERE P.cpf=F.cpf_pessoa AND P.sexo = 'Masculino' AND F.cargo = 'Entregador'
UNION
SELECT COUNT(*) AS TOTAL
FROM PESSOA P, FUNCIONARIO F
WHERE P.cpf=F.cpf_pessoa AND F.cargo = 'Operador de Caixa';