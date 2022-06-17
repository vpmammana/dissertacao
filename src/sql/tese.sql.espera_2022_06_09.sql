DELIMITER //
DROP PROCEDURE IF EXISTS mostra_trilha_da_arvore_descricao_concatenada
//
CREATE PROCEDURE mostra_trilha_da_arvore_descricao_concatenada(IN no_de_busca varchar(20))
BEGIN
	SELECT group_concat(T.nomcat SEPARATOR "-") from (
	SELECT parent.descricao as nomcat 
	FROM secoes AS node,
	        secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	        AND node.nome_categoria = no_de_busca
	ORDER BY parent.lft) as T;
END
//
DROP PROCEDURE IF EXISTS mostra_trilha_da_arvore_codigo_concatenado
//
CREATE PROCEDURE mostra_trilha_da_arvore_codigo_concatenado(IN no_de_busca varchar(20))
BEGIN
	SELECT group_concat(T.nomcat SEPARATOR "-") from (
	SELECT parent.nome_categoria as nomcat
	FROM secoes AS node,
	        secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	        AND node.nome_categoria = no_de_busca
	ORDER BY parent.lft) as T;
END
//
DROP PROCEDURE IF EXISTS mostra_trilha_da_arvore
//
CREATE PROCEDURE mostra_trilha_da_arvore(IN no_de_busca varchar(20))
BEGIN
	SELECT parent.nome_categoria
	FROM secoes AS node,
	        secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	        AND node.nome_categoria = no_de_busca
	ORDER BY parent.lft;
END
//
DROP PROCEDURE IF EXISTS retorna_filho_a_direita_tipos_secoes
//
CREATE PROCEDURE retorna_filho_a_direita_tipos_secoes(IN nome_no_pai varchar(100), OUT saida_no varchar(100))
busca:BEGIN

	SELECT @numero:=count(*) from nested_tipos_secoes where nome_nested_tipo_secao = nome_no_pai;

	IF @numero = 0 THEN
		SET saida_no = '';
		LEAVE busca;		
	END iF;

	SELECT @no_filho_encontrado:=node.nome_nested_tipo_secao, (COUNT(parent.nome_nested_tipo_secao) - (MAX(sub_tree.depth) + 1)) AS depth
	FROM nested_tipos_secoes AS node,
	        nested_tipos_secoes AS parent,
	        nested_tipos_secoes AS sub_parent,
	        (
	                SELECT node.nome_nested_tipo_secao, (COUNT(parent.nome_nested_tipo_secao) - 1) AS depth
	                FROM nested_tipos_secoes AS node,
	                        nested_tipos_secoes AS parent
	                WHERE node.lft BETWEEN parent.lft AND parent.rgt
	                        AND node.nome_nested_tipo_secao = nome_no_pai
	                GROUP BY node.nome_nested_tipo_secao
	                ORDER BY MAX(node.lft)
	        )AS sub_tree
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	        AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	        AND sub_parent.nome_nested_tipo_secao = sub_tree.nome_nested_tipo_secao
	GROUP BY node.nome_nested_tipo_secao
	HAVING depth = 1
	ORDER BY MAX(node.lft) DESC LIMIT 1;
	#SELECT concat("INterno ", @no_filho_encontrado);
	SET saida_no = @no_filho_encontrado;
	SELECT saida_no;
END
//
DROP PROCEDURE IF EXISTS retorna_filho_a_direita
//
CREATE PROCEDURE retorna_filho_a_direita(IN nome_no_pai varchar(100), OUT saida_no varchar(100))
busca:BEGIN

	SELECT @numero:=count(*) from secoes where nome_categoria = nome_no_pai;

	IF @numero = 0 THEN
		SET saida_no = '';
		LEAVE busca;		
	END iF;

	SELECT @no_filho_encontrado:=node.nome_categoria, (COUNT(parent.nome_categoria) - (MAX(sub_tree.depth) + 1)) AS depth
	FROM secoes AS node,
	        secoes AS parent,
	        secoes AS sub_parent,
	        (
	                SELECT node.nome_categoria, (COUNT(parent.nome_categoria) - 1) AS depth
	                FROM secoes AS node,
	                        secoes AS parent
	                WHERE node.lft BETWEEN parent.lft AND parent.rgt
	                        AND node.nome_categoria = nome_no_pai
	                GROUP BY node.nome_categoria
	                ORDER BY MAX(node.lft)
	        )AS sub_tree
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	        AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
	        AND sub_parent.nome_categoria = sub_tree.nome_categoria
	GROUP BY node.nome_categoria
	HAVING depth = 1
	ORDER BY MAX(node.lft) DESC LIMIT 1;
	#SELECT concat("INterno ", @no_filho_encontrado);
	SET saida_no = @no_filho_encontrado;
	SELECT saida_no;
END
//
DROP PROCEDURE IF EXISTS insere_a_direita_dos_filhos_tipos_secoes
//
CREATE PROCEDURE insere_a_direita_dos_filhos_tipos_secoes(IN nome_no_pai varchar(200), IN no_para_inserir varchar(200), IN no_descricao varchar(1000))
funcao:BEGIN

	CALL retorna_filho_a_direita_tipos_secoes(nome_no_pai, @no_filho_a_direita);
	#SELECT concat("Retornou da chamada: ", @no_filho_a_direita);
	IF @no_filho_a_direita = '' THEN
		SELECT "Não foi possível encontrar o no!";
		LEAVE funcao;
	END IF;

	IF @no_filho_a_direita = nome_no_pai THEN
		#SELECT "Insere abaixo";
		SELECT @myLeft := lft FROM nested_tipos_secoes
		
		WHERE nome_nested_tipo_secao = nome_no_pai;
		
		UPDATE nested_tipos_secoes SET rgt = rgt + 2 WHERE rgt > @myLeft;
		UPDATE nested_tipos_secoes SET lft = lft + 2 WHERE lft > @myLeft;
		
		INSERT INTO nested_tipos_secoes(nome_nested_tipo_secao, descricao, lft, rgt) VALUES(no_para_inserir, no_descricao,   @myLeft + 1, @myLeft + 2);
	ELSE
		#SELECT concat("Insere do lado - pai: ",nome_no_pai," a inserir ",no_para_inserir, "retorno da funcao ", @no_filho_a_direita); 
		#SELECT concat("O filho a direita é: ", @no_filho_a_direita);
		
		SELECT @myRight := rgt FROM nested_tipos_secoes
		WHERE nome_nested_tipo_secao = @no_filho_a_direita;
		
		UPDATE nested_tipos_secoes SET rgt = rgt + 2 WHERE rgt > @myRight;
		UPDATE nested_tipos_secoes SET lft = lft + 2 WHERE lft > @myRight;
		
		INSERT INTO nested_tipos_secoes(nome_nested_tipo_secao, descricao,  lft, rgt) VALUES(no_para_inserir, no_descricao,  @myRight + 1, @myRight + 2);
	END IF;

END
//
DROP PROCEDURE IF EXISTS insere_a_direita_dos_filhos
//
CREATE PROCEDURE insere_a_direita_dos_filhos(IN nome_no_pai varchar(100), IN no_para_inserir varchar(100), IN no_descricao varchar(1000), IN no_link varchar(300), IN tipo_secao int)
funcao:BEGIN

	CALL retorna_filho_a_direita(nome_no_pai, @no_filho_a_direita);
	#SELECT concat("Retornou da chamada: ", @no_filho_a_direita);
	IF @no_filho_a_direita = '' THEN
		SELECT "Não foi possível encontrar o no!";
		LEAVE funcao;
	END IF;

	IF @no_filho_a_direita = nome_no_pai THEN
		#SELECT "Insere abaixo";
		SELECT @myLeft := lft FROM secoes
		
		WHERE nome_categoria = nome_no_pai;
		
		UPDATE secoes SET rgt = rgt + 2 WHERE rgt > @myLeft;
		UPDATE secoes SET lft = lft + 2 WHERE lft > @myLeft;
		
		INSERT INTO secoes(nome_categoria, descricao, lnk, lft, rgt, id_tipo_secao) VALUES(no_para_inserir, no_descricao, no_link,  @myLeft + 1, @myLeft + 2, tipo_secao);
	ELSE
		#SELECT concat("Insere do lado - pai: ",nome_no_pai," a inserir ",no_para_inserir, "retorno da funcao ", @no_filho_a_direita); 
		#SELECT concat("O filho a direita é: ", @no_filho_a_direita);
		
		SELECT @myRight := rgt FROM secoes
		WHERE nome_categoria = @no_filho_a_direita;
		
		UPDATE secoes SET rgt = rgt + 2 WHERE rgt > @myRight;
		UPDATE secoes SET lft = lft + 2 WHERE lft > @myRight;
		
		INSERT INTO secoes(nome_categoria, descricao, lnk, lft, rgt, id_tipo_secao) VALUES(no_para_inserir, no_descricao, no_link, @myRight + 1, @myRight + 2, tipo_secao);
	END IF;

END
//
DROP PROCEDURE IF EXISTS mostra_arvore_tipos_secoes
//
CREATE PROCEDURE mostra_arvore_tipos_secoes()
BEGIN
	SELECT CONCAT( REPEAT('   ', COUNT(parent.nome_nested_tipo_secao) - 1), node.nome_nested_tipo_secao) AS nome_tipo_secao
	FROM nested_tipos_secoes AS node,
	        nested_tipos_secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	GROUP BY node.nome_nested_tipo_secao
	ORDER BY MAX(node.lft);
END
//
DROP PROCEDURE IF EXISTS mostra_arvore
//
CREATE PROCEDURE mostra_arvore()
BEGIN
	SELECT CONCAT( REPEAT('   ', COUNT(parent.nome_categoria) - 1), node.nome_categoria) AS nome_secao
	FROM secoes AS node,
	        secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	GROUP BY node.nome_categoria
	ORDER BY MAX(node.lft);
END
//
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_tipos_secoes
//
CREATE PROCEDURE mostra_arvore_niveis_tipos_secoes()
BEGIN
	SELECT COUNT(parent.nome_nested_tipo_secao) - 1 as nivel, node.nome_nested_tipo_secao AS nome_secao_tipo_secao, node.id_chave_nested_tipo_secao as id_tipo_secao
	FROM nested_tipos_secoes AS node,
	        nested_tipos_secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	GROUP BY node.nome_nested_tipo_secao, node.id_chave_nested_tipo_secao
	ORDER BY MAX(node.lft);
END
//
DROP PROCEDURE IF EXISTS mostra_arvore_niveis
//
CREATE PROCEDURE mostra_arvore_niveis()
BEGIN
	SELECT COUNT(parent.nome_categoria) - 1 as nivel, node.nome_categoria AS nome_secao
	FROM secoes AS node,
	        secoes AS parent
	WHERE node.lft BETWEEN parent.lft AND parent.rgt
	GROUP BY node.nome_categoria
	ORDER BY MAX(node.lft);
END
//
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_pais
//
CREATE PROCEDURE mostra_arvore_niveis_pais()
BEGIN
	SELECT 
		T_filho.niveis as nivel, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo 
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.filho as filho, ST.esquerda, ST.direita 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita 
					from 
						(
							SELECT 
								node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt
						) as T group by T.filho, T.esquerda, T.direita
				) as ST
		) as T_filho 
			left join 
				(
					SELECT 
						ST2.niveis as niveis, ST2.filho as filho, ST2.esquerda, ST2.direita 
					from 
						(
							SELECT 
								COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita 
							from 
								(
									SELECT 
										node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita 
									from 
										secoes as node, secoes as parent 
											where node.lft BETWEEN parent.lft AND parent.rgt
								) as T group by T.filho, T.esquerda, T.direita
						) as ST2
				) as T_pai 
					on T_filho.niveis - T_pai.niveis <2 
						where (T_filho.niveis - T_pai.niveis > 0 AND T_filho.esquerda BETWEEN T_pai.esquerda AND T_pai.direita) OR (T_filho.niveis=0 AND T_filho.filho = T_pai.filho) ORDER BY T_filho.esquerda;
END
//
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_pais_seleciona_tipos_com_filhos
//
CREATE PROCEDURE mostra_arvore_niveis_pais_seleciona_tipos_com_filhos(IN tipo_secao varchar(200))
BEGIN
SELECT FINAL.nivel, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.filho, T.esquerda, T.direita
				) as ST
		) as T_filho 
			left join 
				(
					SELECT 
						ST2.niveis as niveis, ST2.filho as filho, ST2.esquerda, ST2.direita 
					from 
						(
							SELECT 
								COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita 
							from 
								(
									SELECT 
										node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita 
									from 
										secoes as node, secoes as parent 
											where node.lft BETWEEN parent.lft AND parent.rgt 

 
								) as T group by T.filho, T.esquerda, T.direita
						) as ST2
				) as T_pai 
					on T_filho.niveis - T_pai.niveis <2 
						where (T_filho.niveis - T_pai.niveis > 0 AND T_filho.tfilhoesquerda BETWEEN T_pai.esquerda AND T_pai.direita) OR (T_filho.niveis=0 AND T_filho.filho = T_pai.filho) ORDER BY T_filho.tfilhoesquerda) AS FINAL WHERE FINAL.idtiposecao IN 
(
SELECT parent.id_chave_nested_tipo_secao
FROM nested_tipos_secoes AS node,
        nested_tipos_secoes AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
        AND node.nome_nested_tipo_secao = tipo_secao
ORDER BY parent.lft

) ORDER BY FINAL.tfilho_esquerda;
END
//
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_pais_seleciona_tipos_com_filhos
//
CREATE PROCEDURE mostra_arvore_niveis_pais_seleciona_tipos_com_filhos(IN tipo_secao varchar(200))
BEGIN
SELECT FINAL.nivel, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.filho, T.esquerda, T.direita
				) as ST
		) as T_filho 
			left join 
				(
					SELECT 
						ST2.niveis as niveis, ST2.filho as filho, ST2.esquerda, ST2.direita 
					from 
						(
							SELECT 
								COUNT(T.pai) - 1 as niveis, T.filho as filho, T.esquerda as esquerda, T.direita as direita 
							from 
								(
									SELECT 
										node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita 
									from 
										secoes as node, secoes as parent 
											where node.lft BETWEEN parent.lft AND parent.rgt 

 
								) as T group by T.filho, T.esquerda, T.direita
						) as ST2
				) as T_pai 
					on T_filho.niveis - T_pai.niveis <2 
						where (T_filho.niveis - T_pai.niveis > 0 AND T_filho.tfilhoesquerda BETWEEN T_pai.esquerda AND T_pai.direita) OR (T_filho.niveis=0 AND T_filho.filho = T_pai.filho) ORDER BY T_filho.tfilhoesquerda) AS FINAL WHERE FINAL.idtiposecao IN 
(
SELECT DISTINCT T1.id from (SELECT parent.id_chave_nested_tipo_secao as id FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao in (SELECT T.nome FROM (SELECT node.nome_nested_tipo_secao as nome, (COUNT(parent.nome_nested_tipo_secao) - (min(sub_tree.depth) + 1)) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent, nested_tipos_secoes AS sub_parent, ( SELECT node.nome_nested_tipo_secao, (COUNT(parent.nome_nested_tipo_secao) - 1) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao = tipo_secao GROUP BY node.nome_nested_tipo_secao ORDER BY max(node.lft) ) AS sub_tree WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt AND sub_parent.nome_nested_tipo_secao = sub_tree.nome_nested_tipo_secao GROUP BY node.nome_nested_tipo_secao HAVING depth <= 1 ORDER BY max(node.lft)) as T where T.depth>0)  ORDER BY parent.lft) as T1
) ORDER BY FINAL.tfilho_esquerda;
END
//
DELIMITER ;


DROP TABLE IF EXISTS instancias_propriedades; # a ordem é importante por causa do foreign key
DROP TABLE IF EXISTS valores_discretos; # a ordem é importante por causa do foreign key
DROP TABLE IF EXISTS propriedades; # a ordem é importante por causa do foreign key
DROP TABLE IF EXISTS secoes; # a ordem é importante por causa do foreign key
DROP TABLE IF EXISTS nested_tipos_secoes; # a ordem é importante por causa do foreign key


CREATE TABLE propriedades (
	id_chave_propriedade INT AUTO_INCREMENT PRIMARY KEY,
	nome_propriedade VARCHAR(100),
	UNIQUE(nome_propriedade)
);

INSERT INTO propriedades (nome_propriedade) VALUES ("alinhamento");
INSERT INTO propriedades (nome_propriedade) VALUES ("tamanho_fonte");
INSERT INTO propriedades (nome_propriedade) VALUES ("tipo_fonte");
INSERT INTO propriedades (nome_propriedade) VALUES ("posicao_vert");
INSERT INTO propriedades (nome_propriedade) VALUES ("tipo_numeracao");

CREATE TABLE valores_discretos (
	id_chave_valor_discreto INT AUTO_INCREMENT PRIMARY KEY,
	nome_valor_discreto varchar(100),
	id_propriedade INT,
	FOREIGN KEY (id_propriedade) REFERENCES propriedades(id_chave_propriedade)

);

INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("normal",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("italico",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("bold",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("sublinhado",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_fonte"));

INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("direita",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "alinhamento"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("esquerda",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "alinhamento"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("centro",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "alinhamento"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("justificado",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "alinhamento"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("0.7",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("0.8",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("0.9",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.0",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.1",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.2",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.3",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.4",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.5",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.6",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.7",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.8",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("1.9",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.0",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.1",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.2",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.3",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.4",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.5",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.6",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.7",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.8",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("2.9",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.0",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.1",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.2",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.3",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.4",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("3.5",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tamanho_fonte"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("cima",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "posicao_vert"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("baixo",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "posicao_vert"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("centro",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "posicao_vert"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("letra_i",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_numeracao"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("letra_a",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_numeracao"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("letra_I",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_numeracao"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("romana",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_numeracao"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("algarismo",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "tipo_numeracao"));


CREATE TABLE nested_tipos_secoes (
        id_chave_nested_tipo_secao INT AUTO_INCREMENT PRIMARY KEY,
        nome_nested_tipo_secao VARCHAR(200) NOT NULL,
	descricao varchar(1000),
        lft INT NOT NULL,
        rgt INT NOT NULL
);

INSERT INTO nested_tipos_secoes VALUES(1,'raiz','Rais dos Tipos de Secao',1,2);
#,(2,'topico',2,15),(3,'paragrafo',3,4), (4,'imagem',5,6),(5,'grafico',7,8),(6,'tabela',9,10),(7,'lista',11,14),(8,'item',12,13);

call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"capa",						"Capa do documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"titulo",					"Titulo Principal do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"sub_titulo",					"Sub-Titulo do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"autor",					"Autor do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"orientador",					"Orientador do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"agradecimento",				"Agradecimentos");
call insere_a_direita_dos_filhos_tipos_secoes("agradecimento",			"paragrafo_agradecimento", 			"Parágrafos do agradecimentos");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"resumo",					"Resumo");
call insere_a_direita_dos_filhos_tipos_secoes("resumo",				"paragrafo_resumo", 				"Paragrafos do Resumo");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"abstract",					"Abstract");
call insere_a_direita_dos_filhos_tipos_secoes("abstract",			"paragrafo_abstract", 				"Parágrafos do Abstract");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"lista_de_tab_fig",				"Listas genéricas do começo da tese, incluindo glossário");
call insere_a_direita_dos_filhos_tipos_secoes("lista_de_tab_fig",		"item_lista_de_tab_fig", 			"Itens das listas de tabelas, figuras, etc.");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"indice",					"Índice");
call insere_a_direita_dos_filhos_tipos_secoes("indice",				"item_indice", 					"Itens do Índice");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"topico",					"Tópicos ou Seções incluindo capítulos");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"paragrafo",					"Parágrafos dos tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("paragrafo",			"chama_ref",					"Chamada de referência em parágrafos dos tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"citacao",					"Citacao por extenso em itálico, dentro de tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("citacao",			"ref_citacao",					"Origem (referência) da citacao presente em itálico nos tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"imagem",					"Imagens dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("imagem",				"legenda_imagem",				"Legenda de Imagens dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"grafico",					"Gráficos dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("grafico",			"legenda_grafico",				"Legenda de gráficos dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"tabela",					"Tabelas dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("tabela",				"legenda_tabela",				"Legenda de tabela dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("legenda_tabela",			"ref_legenda_tabela",				"Referência_Legenda de tabela dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"lista_numerada",				"Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("lista_numerada",			"item_lista_num",				"Item de Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("item_lista_num",			"chama_ref_item_list_num",			"Chamada de Referência de Item de Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"lista_nao_numerada",				"Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("lista_nao_numerada",		"item_lista_nao_num",				"Item de Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("item_lista_nao_num",		"chama_ref_item_list_nao_num",			"Chamada de Referência de Item de Lista não Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"referencia",					"Referências da Tese");
call insere_a_direita_dos_filhos_tipos_secoes("referencia",			"item_de_referencia", 				"Itens da seção de referências");

CREATE TABLE instancias_propriedades (
	id_chave_instancia_propriedade INT AUTO_INCREMENT PRIMARY KEY,
	valor_continuo varchar(50),
	id_propriedade INT,
	id_valor_discreto INT,
	id_nested_tipo_secao INT,
	UNIQUE(id_propriedade, id_valor_discreto, id_nested_tipo_secao),
	FOREIGN KEY (id_propriedade) REFERENCES propriedades(id_chave_propriedade),
	FOREIGN KEY (id_valor_discreto) REFERENCES valores_discretos(id_chave_valor_discreto),
	FOREIGN KEY (id_nested_tipo_secao) REFERENCES nested_tipos_secoes(id_chave_nested_tipo_secao)
); 


INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "2.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "2.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "bold"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "italico"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));


INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="imagem"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="grafico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = @ AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="tabela"));


CREATE TABLE secoes (
        id_chave_categoria INT AUTO_INCREMENT PRIMARY KEY,
        nome_categoria VARCHAR(100) NOT NULL,
	descricao varchar(3000),
	lnk varchar(300),
        lft INT NOT NULL,
        rgt INT NOT NULL,
	id_tipo_secao int,
	unique(nome_categoria),
	FOREIGN KEY (id_tipo_secao) REFERENCES nested_tipos_secoes(id_chave_nested_tipo_secao)
);


# importante -> nao pode usar traço no primary key do nome_categoria



insert into secoes values (1,'corpo_tese','raiz','',1,2, (SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="raiz"));


call insere_a_direita_dos_filhos("corpo_tese", "capa_da_tese", "Capa da Tese" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "capa"));
call insere_a_direita_dos_filhos("capa_da_tese", "titulo_da_tese", "CARACTERIZAÇÃO DO PROGRAMA Workshop Aficionados por Software e Hardware (WASH)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "titulo"));
call insere_a_direita_dos_filhos("capa_da_tese", "sub_titulo_da_tese", "HISTÓRIA, MÉTODOS E RESULTADOS" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "sub_titulo"));
call insere_a_direita_dos_filhos("capa_da_tese", "autor_da_tese", "Elaine da Silva Tozzi" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "autor"));
call insere_a_direita_dos_filhos("capa_da_tese", "orientador_da_tese", "Paulo Sérgio Camargo" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "orientador"));
call insere_a_direita_dos_filhos("corpo_tese", "resumo_da_tese", "RESUMO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "resumo"));
call insere_a_direita_dos_filhos("corpo_tese", "estrutura_do_texto", "ESTRUTURA DO TEXTO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_1", "Este trabalho busca utilizar a forma mais canônica de estruturação de um texto científico [XXX Oftalmo DOI: 10.5935/0034-7280.20140055]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "lista_IMRD", "Lista Numerada" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "lista_numerada"));
call insere_a_direita_dos_filhos("lista_IMRD", "item_1_lista_IMRD", "introdução" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD", "item_2_lista_IMRD", "métodos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD", "item_3_lista_IMRD", "resultados" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD", "item_4_lista_IMRD", "discussão" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_2", "A referência [XXX Oftalmo DOI: 10.5935/0034-7280.20140055] busca identificar o caráter principal de cada um dos elementos acima por meio de uma pergunta, como segue:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "lista_IMRD_perg", "Lista Numerada com Perguntas" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "lista_numerada"));
call insere_a_direita_dos_filhos("lista_IMRD_perg", "item_1_lista_IMRD_perg", "Introdução - que pergunta foi feita?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_perg", "item_2_lista_IMRD_perg", "Métodos - como ela foi estudada?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_perg", "item_3_lista_IMRD_perg", "Resultados - o que foi achado?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_perg", "item_4_lista_IMRD_perg", "Discussão - o que estes achados significam?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("item_4_lista_IMRD_perg", "ref_item_4_lista_IMRD_perg", "(fonte: [XXX Oftalmo DOI: 10.5935/0034-7280.20140055]:)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref_item_list_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_3", "Uma forma diferente de expressar esses mesmos conceitos é atribuir a pergunta “por que fiz? à Introdução, atribuir a pergunta “como fiz? aos Métodos e atribuir a pergunta “o que obtive? aos Resultados, de forma que a pesquisa empregada permita observar o mesmo objeto em estudo por meio de 3 dimensões que se complementam." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_4", "A estrutura indicada acima pode ter variantes mais completas como a descrita em [XXX How to Write a Paper in Scientific Journal Style and Format]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "lista_IMRD_completa", "Lista Numerada com Perguntas completa" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "lista_numerada"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_1_lista_IMRD_completa", "Resumo - O que eu fiz de uma forma bem sintética (“in a nutshell)?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_2_lista_IMRD_completa", "Introdução - Qual é o problema?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_3_lista_IMRD_completa", "Materiais e Métodos - Como eu resolvi o problema?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_4_lista_IMRD_completa", "Resultados - O que eu achei?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_5_lista_IMRD_completa", "Agradecimentos (opcional) - Quem me ajudou a fazer?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_6_lista_IMRD_completa", "Literatura citada - Quais trabalhos eu usei como referência?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lista_IMRD_completa", "item_7_lista_IMRD_completa", "Apêndices - Informação Extra" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("item_5_lista_IMRD_completa", "ref_item_5_lista_IMRD_completa", "(tradução livre de [XXX How to Write a Paper in Scientific Journal Style and Format])" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref_item_list_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_5", "A variante acima, embora voltada para publicações curtas, é válida para outros tipos de registros científicos e também é baseada na ideia das 3 dimensões descrita acima: “por que?, “como? e “o que?." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_6", "De forma mais completa ainda, mas com a mesma estrutura básica:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("paragrafo_6", "ref_paragrafo_6", "S.A.Meo [XXX Anatomy and physiology of a scientific paper] propõe o “MEO’s Fish Bone Model" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "imagem_1", "/var/www/html/tese/dados/imagens/MEOS-Fish-Bone-Model-Basic-components-of-a-scientific-paper.png" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "imagem"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "legenda_imagem_1", "Fig 1. - A estrutura de “espinha de peixe de S.A. MEOs (fonte: S.A.Meo [XXX Anatomy and physiology of a scientific paper])" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "legenda_imagem"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_7", "Uma vez que a Fig. 1 é um pouco “congestionada no sentido da densidade de informações apresentadas, cabe uma descrição de cada “costela da espinha-de-peixe de MEOs, transcrita aqui na forma de uma tabela:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "tabela_1", "/var/www/html/tese/dados/tabelas/tabela_estrutura_de_texto.html" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "tabela"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_8", "As 3 estruturas exemplificadas [XXX MEO, How to Write e Oftalmo] acima tratam, principalmente, de papers científicos, em que a concisão é especialmente necessária. Mas papers cientificos não são o único formato disponível para realizar uma comunicação científica." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_9", "Existem formatos mais extensos para documentação, tais como: relatórios, teses, comunicações rápidas. Alaide Mammana também explora estas nuances, muito embora a estrutura básica seja sempre “Introdução, Métodos, Resultados e Discussão, como já reforçado aqui." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("paragrafo_9", "ref_paragrafo_9", "[XXX Alaide Mammana, Documentação científicas]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_10", "O presente texto, por se tratar de uma dissertação, pode se valer desses formatos mais extensos, uma vez que se trata da “defesa para obtenção de um título (mestrado), em que a presente candidata tem que demonstrar erudição nos temas abordados. O formato menos conciso permite à esta candidata expor melhor a sua busca por uma erudição, dado que comporta a revisão de conhecimentos já existentes de forma mais estendida." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Introducao", "Descrição da Introdução" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_11", "Seguindo as sugestões presentes em S. MEO, optou-se por uma introdução curta, leve e objetiva. A introdução é estruturada para culminar, por meio de seus últimos parágrafos, na descrição do objeto de estudo. O caminho percorrido é o de descrever esse objeto do mais geral até o específico." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("paragrafo_11", "ref_paragrafo_11", "[citar XXX]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_12", "Para que que pudesse se expressar de forma organizada, buscando demonstrar sua erudição, sem perder a objetividade da “Introdução, a presente candidata acatou a sugestão do orientador de incluir um capítulo de “Fundamentação Teórica, no qual os temas pincelados na “Introdução pudessem ser mais profundamente descritos, sem prejuízo para um formato “leve e balanceado para a apresentação da literatura na introdução, um aspecto que, segundo S.A. Meo, e.g., deve ser perseguido pelo redator de textos científicos. Assim, a exposição na “Introdução busca ser o mais sintética possível, com direcionamento para a “Fundamentação Teórica sempre que for necessário aprofundar em algum conceito." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_13", "Para facilitar a leitura, a presente candidata optou, também, por colocar em subseções da “Introdução a exposição dos problemas, hipóteses, das questões e dos objetos de interesse." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Materiais_e_Metodos", "Descrição de Materiais e Métodos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Materiais_e_Metodos", "paragrafo_14", "Uma vez que a presente pesquisa tem por objeto a caracterização do Projeto WASH quanto à sua história (trajetória), métodos e resultados, a descrição do método do WASH deve ser considerada como resultado do método da pesquisa. Em outras palavras, uma das dimensões do método aqui empregado refere-se a caracterizar o método do WASH. Portanto, a pesquisa se baseia num método de caracterização de métodos. Assim, a descrição do método do WASH deve ser considerada uma decorrência da aplicação do método da pesquisa desta dissertação e, por esse motivo, encontra-se no capítulo de “Resultados e não no capítulo de “Materiais e Métodos." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Resultados_e_Discussoes", "Resultados e Discussões" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Resultados_e_Discussoes", "paragrafo_15", "A candidata optou por juntar em um único capítulo os resultados e as discussões (“Resultados e Discussões). Esta opção visa garantir uma melhor fluidez, dado que permite apresentar as opções de análise que levaram à proposta de melhorias no método do WASH, o produto final desta dissertação." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Produto_Tecnologico", "Produto Tecnológico" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Produto_Tecnologico", "paragrafo_16", "A presente dissertação, por se tratar de um Mestrado Tecnológico, deve culminar com a apresentação de um “produto de caráter prático, que no presente caso será uma revisão do Documento de Referência do Projeto WASH  constante do anexo da  Portaria CTI 178/2018). Por esse motivo foi acrescentado à estrutura do documento um capítulo de “Produto Tecnológico. Biblioteca Cidadã Paulo Freire" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "Introducao", "INTRODUÇÃO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_17", "Aos olhos de jovens observadores contemporâneos, parece natural a relativa desenvoltura com que as pessoas utilizam os computadores e os celulares nos dias de hoje. Já estão bastante difundidos os serviços de governo eletrônico, os sites de comércio eletrônico, os  aplicativos de entrega, as plataformas de ensino, de reuniões, a busca por  trabalho, oportunidades, voto eletrônico, banco e caixa eletrônico, por exemplo." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("paragrafo_17", "ref_paragrafo_17", "[XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_18", "Essas ferramentas são continuadamente revistas e melhoradas, assim como não param de se multiplicar para atender e se adaptar aos desafios impostos pela evolução da convivência em sociedade. Um exemplo dessa necessidade de adaptação foi recentemente evidenciado pela forma como a sociedade respondeu às imposições sanitárias relativas à pandemia de 2020, quando os cidadãos tiveram que se adaptar ao isolamento e encontrar formas para continuarem produtivos por meios das redes digitais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("paragrafo_18", "ref_paragrafo_18", "[XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_19", "É possível afirmar que as pessoas têm usado com frequência e com relativa facilidade as ferramentas digitais instaladas em computadores e em celulares, sejam aplicativos de mensagens, buscadores (browsers), correio eletrônico, redes sociais, entre outras. Esse uso dá-se em vários contextos: profissional, educacional, de entretenimento, de interação social, além dos serviços de governo eletrônico." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_20", "As novas gerações precisam, no entanto, saber que não foi sempre assim. Muito embora a percepção corrente de que o uso de computadores e celulares é indispensável para o convívio na sociedade, a rigor seu uso é relativamente recente." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_21", "É possível identificar a evolução das telecomunicações a partir do século passado como origem das transformações tecnológicas que disponibilizaram tecnologias digitais em larga escala. Esse fato foi identificado, por exemplo, por PIERRE LEVY, em Cibercultura," , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "citacao_1", "durante uma entrevista nos anos 50, Albert Einstein (1879-1955) declarou que três grandes bombas haviam  explodido durante o século XX: a bomba demográfica, a bomba atômica e a bomba das telecomunicações. Esta última ‘bomba’ foi chamada por Roy Ascott ( pioneiro e teórico das artes em rede) de Segundo Dilúvio, o das informações. As telecomunicações geram esse novo dilúvio por conta da natureza exponencial, explosiva e caótica do seu crescimento. A quantidade de dados e links se multiplica, acelera, aumento de links, banco de dados, hipertextos nas redes, contos transversais, etc." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("citacao_1", "ref_citacao_1", "[1]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "ref_citacao"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_22", "Ainda, segundo Pierre Levy," , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "citacao_2", "“O segundo dilúvio não terá fim. Não há nenhum fundo sólido sob o oceano de informações. Devemos aceitá-lo como nossa nova condição. Temos que ensinar nossos filhos a nadar, a flutuar, talvez a navegar." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_23", "Para desenvolver e dar acesso a estes recursos tecnológicos,  governos tiveram que prover a infraestrutura de ciência e tecnologia, comunicações e de redes digitais e os meios de acesso a essas redes, algumas vezes com a participação da iniciativa privada. Na outra ponta, tiveram que promover projetos, formular políticas públicas de C&T para o desenvolvimento e  disseminação do uso das tecnologias da informação e comunicação e para a capacitação dos cidadãos através de programas de caráter educacional e de formação profissional. No Brasil, a gênese desse esforço foi deflagrada pelo Estado no início da década de 60 [2], sendo que suas ações perduram até os dias de hoje. Uma revisão essa trajetória brasileira será apresentada no capítulo de “Fundamentação Teórica." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_24", "Se para alguns as redes digitais tinham o objetivo de atender os indivíduos em suas necessidade de relacionamento com o governo, afinal a própria internet nasceu no contexto governamental [XXX], elas foram mais longe, e alcançaram todas as demais dimensões do cidadão, tais como: consumidor, beneficiário de serviços de saúde, educando, trabalhador, empreendedor, contribuinte, eleitor, entre outras.  Essa expansão se deu como resultado de várias ações, mas sua universalização foi resultado principalmente do surgimento de novas formas de relacionamento social representadas pelas redes sociais digitais, que tornaram mais acessíveis novas ferramentas de apoio ao ensino em sala de aula, o ensino à distância, o comércio eletrônico, a eleição eletrônica, os “market-places, os aplicativos de transporte, etc." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_25", "Estas transformações tiveram impactos econômicos e sociais profundos, inclusive nas relações de trabalho, seja na criação ou extinção de posto de trabalho, bem como em suas formas de contratação, jornada, remuneração, inclusive com a precarização dos direitos trabalhistas. Elas estão muito bem descritas  no relatório da Unesco  de 2004 “Social Transformation in an Information Society: Rethinking Access to You and the World [3]. A amplitude destas  transformações por que passa a sociedade humana é sintetizada no que se chama  Sociedade da Informação ou  Era Digital ou Era da Informação. Uma breve revisão sobre esse conceito  é apresentada na fundamentação teórica." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_26", "O efeito destas transformações no emprego vem exigindo dos governos, das empresas e dos cidadãos uma constante e rápida readaptação  das relações do trabalho, comerciais, industriais e da produção de novos saberes e competências. Aqueles cidadãos que não se adaptam correm o risco constante de ficarem sem sustento. Inicialmente tais transformações eram associadas principalmente à substituição do trabalho humano decorrente da automação industrial. Mas a radicalização no uso de soluções digitais, inclusive de inteligência artificial, associadas ao aumento da conectividade, vêm substituindo capacidades “cognitivas que antes eram exclusivas de humanos[4]. Uma das consequências mais radicais é o surgimento de novos meios de exploração humana, representados pela “Gigs Economy [XXX], ou “Economia do Bico, que precariza as relações trabalhistas por meio de plataformas que as impessoaliza a ponto de camuflar a exploração [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_27", "Vários países têm buscado uma melhor preparação para enfrentar essas transformações, dotando o cidadão de meios cognitivos, de conhecimento e culturais para se readaptar. Para isso, têm procurado remodelar seus sistemas educacionais, uma vez que “ficar para trás em relação aos demais países pode afetar a prosperidade de suas populações, sua autonomia e liberdade [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_28", "Mais do que simplesmente treinar o cidadão quanto ao uso  de serviços digitais, a educação tem um papel fundamental para preparar os cidadãos para sua inserção autônoma e digna na sociedade transformada pelas tecnologias de informação e comunicação. O Estado tem o desafio de estabelecer políticas públicas e prover infraestrutura para que o cidadão possa ter acesso e se beneficiar, de forma autônoma, dos recursos digitais e de comunicação." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_29", "A percepção da importância da educação para a prosperidade da sociedade é muito antiga e, no caso americano, remonta aos primórdios da independência americana." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_30", "No capítulo “Fundamentação Teórica revisaremos as origens do conceito de “Science, Technology, Engineering and Mathematics (STEM), mostrando que já em 1790 o  presidente George Washington, em seu primeiro discurso do “Estado da União promovia a ciência e literatura como uma base da “felicidade pública [XXX citar fonte]. Essa percepção de valor perdurou por toda a existência americana, estimulada, inclusive, como resposta às ameaças externas muito posteriores, tais como o sucesso soviético no programa espacial, representado pelo pioneirismo do lançamento do satélite Sputnik no final da década de 50, por exemplo. É no cenário da Guerra Fria que a política de educação em STEM e alfabetização  científica e tecnológica  é vista como bem comum para o Estado, mesmo muito antes do uso desse acrônimo de forma oficial. ( Relatório CRS para o Congresso, www.crs.gov, 2012)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));


#call insere_a_direita_dos_filhos("corpo_tese","Estrutura_do_Texto","Estrutura do Texto", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("corpo_tese","Introducao","Introdução", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Introducao","Paragrafo_1", "Parágrafo 1","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="paragrafo"));
#call insere_a_direita_dos_filhos("Introducao","Objetivo", "Objetivo","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Introducao","Hipoteses", "Hipóteses","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Introducao","Problema", "Problema","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Introducao","Justificativa", "Justificativa","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Objetivo", "Objetivo_Geral","Objetivo Geral", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Objetivo", "Objetivos_Especificos","Objetivos Específicos","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Objetivos_Especificos","Caracterizar_WASH","Caracterizar WASH","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#
#call insere_a_direita_dos_filhos("corpo_tese","Fundamentacao_Teorica","Fundamentação Teórica", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("corpo_tese","Materiais_e_Metodos","Materiais e Métodos", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Materiais_e_Metodos","Base_Relacional", "Base_Relacional","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("Materiais_e_Metodos","Metodo_Historiografico", "Método Historiográfico","",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#
#call insere_a_direita_dos_filhos("corpo_tese","Resultados_e_Analise","Resultados e Análise", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));
#call insere_a_direita_dos_filhos("corpo_tese","Conclusoes","Conclusões", "",(SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="topico"));

call mostra_arvore();
call mostra_arvore_niveis();
call mostra_arvore_niveis_pais();
call mostra_arvore_niveis_pais_segrega_tipo("paragrafo");

call mostra_arvore_niveis_pais_seleciona_tipo("paragrafo");
call mostra_arvore_niveis_pais_seleciona_tipo("raiz");
call mostra_arvore_niveis_pais_seleciona_tipo("topico");


SELECT parent.nome_nested_tipo_secao, parent.id_chave_nested_tipo_secao
FROM nested_tipos_secoes AS node,
        nested_tipos_secoes AS parent
WHERE node.lft BETWEEN parent.lft AND parent.rgt
        AND node.nome_nested_tipo_secao = 'item'
ORDER BY parent.lft;

call mostra_arvore_tipos_secoes();
call mostra_arvore_niveis_tipos_secoes();

