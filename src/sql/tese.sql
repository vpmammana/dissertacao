# VPM (2022-06-09) - nesta versao temos todos os elementos de topicos (presente na arvore da tabela nested_tipos_secoes) no mesmo nivel hierarquico
# VPM (2022-06-19) - criado versionamento atraves da tabela versoes.
# VPM (2022-06-19) - tentativa de pegar id_chave da tabela secoes nos stored procedures mostra_arvore_niveis_pais_seleciona_tipo*
# VPM (2022-06-19) - tentativa de obter campo trecho e nome_versao da tabela versoes.
# VPM (2022-06-22) - criando forma de ver o documento inteiro, no mesmo visualizador de niveis pela criacao da stored procedure mostra_documento_completo
# VPM (2022-06-28) - preparacao para criar um sistema de mudanca de subarvore dentro da arvore
# VPM (2022-06-29) - criacao das funcoes de insercao de novos nós, antes e depois do atual
# VPM (2022-07-02) - criacao de procedure para gravar trecho quando insere novo filho insere_a_direita_dos_filhos_com_trecho
# VPM (2022-07-10) - cria procedure que faz mostra_documento_completo mostrar niveis para geracao de Latex -> mostra_documento_completo_niveis
DELIMITER //
DROP PROCEDURE IF EXISTS retorna_valores_de_propriedades_do_tipo_secao
//
CREATE PROCEDURE retorna_valores_de_propriedades_do_tipo_secao(IN tipo_secao varchar(200))
BEGIN
select nome_propriedade, nome_valor_discreto, nome_nested_tipo_secao from instancias_propriedades as A, propriedades, valores_discretos, nested_tipos_secoes where A.id_propriedade = id_chave_propriedade and id_valor_discreto=id_chave_valor_discreto and id_nested_tipo_secao = id_chave_nested_tipo_secao and nome_nested_tipo_secao = tipo_secao order by nome_nested_tipo_secao ;
END
//
DROP PROCEDURE IF EXISTS mostra_trilha_da_arvore_descricao_concatenada
//
# a procedure abaixo estaria com problemas? coloca o nivel 2 por ultimo. Ainda bem que eu nao uso
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
# a procedure abaixo estaria com problemas? coloca o nivel 2 por ultimo. Ainda bem que eu nao uso
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
# este estah funcionando.
DROP PROCEDURE IF EXISTS mostra_trilha_da_arvore
//
CREATE PROCEDURE mostra_trilha_da_arvore(IN no_de_busca varchar(100))
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
CREATE PROCEDURE insere_a_direita_dos_filhos_tipos_secoes(IN nome_no_pai varchar(200), IN no_para_inserir varchar(200), IN no_descricao varchar(10000))
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
CREATE PROCEDURE insere_a_direita_dos_filhos(IN nome_no_pai varchar(100), IN no_para_inserir varchar(100), IN no_descricao varchar(10000), IN no_link varchar(300), IN tipo_secao int)
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
# insere antes (a esquerda) do no atual
DROP PROCEDURE IF EXISTS insere_abaixo_do_atual
//
CREATE PROCEDURE insere_abaixo_do_atual(IN nome_no_pai VARCHAR(100), IN nome_do_tipo_de_secao VARCHAR(200), IN in_trecho VARCHAR(3000))
funcao:BEGIN
	call insere_a_direita_dos_filhos(nome_no_pai, CONCAT("automatico_",CURRENT_TIMESTAMP(6)), in_trecho,'', (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = nome_do_tipo_de_secao));
	INSERT INTO versoes(id_secao, trecho) VALUES (LAST_INSERT_ID(), in_trecho);
END
//
# insere antes (a esquerda) do no atual
DROP PROCEDURE IF EXISTS insere_a_esquerda_do_atual
//
CREATE PROCEDURE insere_a_esquerda_do_atual(IN nome_no VARCHAR(100), IN id_do_tipo_de_secao INT, IN in_descricao VARCHAR(3000))
funcao:BEGIN
	SELECT @tmp_esq:= lft from secoes where nome_categoria = nome_no;
	SELECT @time_stampa :=  CURRENT_TIMESTAMP(3);
	SELECT @time_stampa_short :=  CURRENT_TIMESTAMP;
	
	#cria novo espaco
	UPDATE secoes set lft = lft + 2 where lft >= @tmp_esq;
	UPDATE secoes set rgt = rgt + 2 where rgt >= @tmp_esq;
	#cria novo no
 	INSERT INTO secoes(nome_categoria, descricao, lnk, lft, rgt, id_tipo_secao) VALUES(CONCAT("automatico_", @time_stampa), in_descricao, "",  @tmp_esq, @tmp_esq + 1, id_do_tipo_de_secao);
	INSERT INTO versoes(id_secao, trecho) VALUES (LAST_INSERT_ID(), in_descricao);

END
//
# insere depois (a direita) do no atual
DROP PROCEDURE IF EXISTS insere_a_direita_do_atual
//
CREATE PROCEDURE insere_a_direita_do_atual(IN nome_no VARCHAR(100), IN id_do_tipo_de_secao INT, IN in_descricao VARCHAR(3000))
funcao:BEGIN
	SELECT @tmp_dir:= rgt from secoes where nome_categoria = nome_no;
	SELECT @time_stampa :=  CURRENT_TIMESTAMP(3);
	SELECT @time_stampa_short :=  CURRENT_TIMESTAMP;
	
	#cria novo espaco
	UPDATE secoes set lft = lft + 2 where lft > @tmp_dir;
	UPDATE secoes set rgt = rgt + 2 where rgt > @tmp_dir;
	#cria novo no
 	INSERT INTO secoes(nome_categoria, descricao, lnk, lft, rgt, id_tipo_secao) VALUES(CONCAT("automatico_", @time_stampa), in_descricao, "",  @tmp_dir + 1, @tmp_dir + 2, id_do_tipo_de_secao);
	INSERT INTO versoes(id_secao, trecho) VALUES (LAST_INSERT_ID(), in_descricao);

END
//
DROP PROCEDURE IF EXISTS transpoe_subarvore
//
CREATE PROCEDURE transpoe_subarvore(IN nome_no_para_transpor varchar(100), IN nome_no_onde_inserir varchar(100))
funcao:BEGIN
	SELECT @tmp_esq:= lft from secoes where nome_categoria = nome_no_para_transpor;
	SELECT @tmp_dir:= rgt from secoes where nome_categoria = nome_no_para_transpor;
 
	SELECT @largura_do_no:=rgt - lft + 1 from secoes where nome_categoria = nome_no_para_transpor;
	
	SELECT @esq_da_insercao:=lft from secoes where nome_categoria = nome_no_onde_inserir;

	SELECT @distancia_para_insercao:=lft - @tmp_esq + 1 from secoes where nome_categoria = nome_no_onde_inserir; 

	#cria novo espaco
	UPDATE secoes set lft = lft + @largura_do_no where lft > @esq_da_insercao;
	UPDATE secoes set rgt = rgt + @largura_do_no where rgt > @esq_da_insercao;
	#move subtree
	UPDATE secoes set lft = lft + @distancia_para_insercao, rgt = rgt + @distancia_para_insercao where lft >= @tmp_esq AND rgt <= @tmp_dir;
	#apaga espaco da subtree original
        UPDATE secoes set lft = lft - @largura_do_no where lft > @tmp_dir;
	UPDATE secoes set rgt = rgt - @largura_do_no where rgt > @tmp_dir; 

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
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_tipos_secoes_com_pai
//
CREATE PROCEDURE mostra_arvore_niveis_tipos_secoes_com_pai()
BEGIN
	SELECT 
		COUNT(parent.nome_nested_tipo_secao) - 1 as nivel, 
		@nome:=node.nome_nested_tipo_secao AS nome_secao_tipo_secao, 
		node.id_chave_nested_tipo_secao as id_tipo_secao,
		(
			select 
				nome_nested_tipo_secao 
			from 
				nested_tipos_secoes 
			where 
				lft < (select lft from nested_tipos_secoes where nome_nested_tipo_secao=@nome) and rgt > (select rgt from nested_tipos_secoes where nome_nested_tipo_secao=@nome) 
			order by lft DESC limit 1
		) as pai 
	FROM 
		nested_tipos_secoes AS node, nested_tipos_secoes AS parent  
	WHERE 
		node.lft BETWEEN parent.lft AND parent.rgt 
	GROUP BY 
		node.nome_nested_tipo_secao, node.id_chave_nested_tipo_secao 
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
# cria funcao para mostrar todos os niveis como se fossem nivel 1, para mostrar o documento integral
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_pais_seleciona_tipo
//
CREATE PROCEDURE mostra_arvore_niveis_pais_seleciona_tipo(IN tipo_secao varchar(200))
BEGIN

SELECT POS_FINAL.nivel, POS_FINAL.id_chave_filho, POS_FINAL.id_filho, POS_FINAL.id_pai, POS_FINAL.titulo, POS_FINAL.id_nested_tipo_secao, POS_FINAL.nome_nested_tipo_secao, POS_FINAL.esq, POS_FINAL.dir, POS_FINAL.tem_filho, (SELECT trecho from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as ultima_versao,(SELECT nome_versao from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as data, (SELECT count(*) from versoes where id_secao = POS_FINAL.id_chave_filho) as conta_versoes     FROM
(
SELECT FINAL.nivel, FINAL.id_chave_filho, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda as esq, FINAL.tfilho_direita as dir, CASE WHEN (FINAL.tfilho_direita - FINAL.tfilho_esquerda = 1) THEN "NAO_TEM_FILHO" ELSE "TEM_FILHO" END as tem_filho   FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.id_chave_filho as id_chave_filho, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda, T_filho.tfilhodireita as tfilho_direita
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.id_chave_filho as id_chave_filho, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita as tfilhodireita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.id_chave_filho as id_chave_filho, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.id_chave_categoria as id_chave_filho, node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.id_chave_filho, T.filho, T.esquerda, T.direita
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

) ORDER BY FINAL.tfilho_esquerda) AS POS_FINAL order by POS_FINAL.esq;
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
#alteracao em elaboracao -> buscar versao na tabela versoes - busca da ultima versao da secao bem sucedida (2022-06-19)
#busca do numero de versoes da secao (2022-06-20)
DROP PROCEDURE IF EXISTS mostra_arvore_niveis_pais_seleciona_tipos_com_filhos_esq_dir
//
CREATE PROCEDURE mostra_arvore_niveis_pais_seleciona_tipos_com_filhos_esq_dir(IN tipo_secao varchar(200))
BEGIN
SELECT POS_FINAL.nivel, POS_FINAL.id_chave_filho, POS_FINAL.id_filho, POS_FINAL.id_pai, POS_FINAL.titulo, POS_FINAL.id_nested_tipo_secao, POS_FINAL.nome_nested_tipo_secao, POS_FINAL.esq, POS_FINAL.dir, POS_FINAL.tem_filho, (SELECT trecho from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as ultima_versao,(SELECT nome_versao from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as data, (SELECT count(*) from versoes where id_secao = POS_FINAL.id_chave_filho) as conta_versoes   FROM
(SELECT FINAL.nivel, FINAL.id_chave_filho, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda as esq, FINAL.tfilho_direita as dir, CASE WHEN (FINAL.tfilho_direita - FINAL.tfilho_esquerda = 1) THEN "NAO_TEM_FILHO" ELSE "TEM_FILHO" END as tem_filho FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.id_chave_filho as id_chave_filho, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda, T_filho.tfilhodireita as tfilho_direita
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.id_chave_filho as id_chave_filho, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita as tfilhodireita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.id_chave_filho as id_chave_filho, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.id_chave_categoria as id_chave_filho, node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.id_chave_filho, T.filho, T.esquerda, T.direita
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
) ORDER BY FINAL.tfilho_esquerda) AS POS_FINAL order by POS_FINAL.esq;
END
//
DROP PROCEDURE IF EXISTS mostra_documento_completo
//
CREATE PROCEDURE mostra_documento_completo(IN tipo_secao varchar(200))
BEGIN
SELECT CASE WHEN (POS_FINAL.nivel=0) THEN 0 ELSE 1 END as nivel, POS_FINAL.id_chave_filho, POS_FINAL.id_filho, (select "corpo_tese"), POS_FINAL.titulo, POS_FINAL.id_nested_tipo_secao, POS_FINAL.nome_nested_tipo_secao, POS_FINAL.esq, POS_FINAL.dir, POS_FINAL.tem_filho, (SELECT trecho from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as ultima_versao,(SELECT nome_versao from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as data, (SELECT count(*) from versoes where id_secao = POS_FINAL.id_chave_filho) as conta_versoes   FROM
(SELECT FINAL.nivel, FINAL.id_chave_filho, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda as esq, FINAL.tfilho_direita as dir, CASE WHEN (FINAL.tfilho_direita - FINAL.tfilho_esquerda = 1) THEN "NAO_TEM_FILHO" ELSE "TEM_FILHO" END as tem_filho FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.id_chave_filho as id_chave_filho, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda, T_filho.tfilhodireita as tfilho_direita
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.id_chave_filho as id_chave_filho, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita as tfilhodireita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.id_chave_filho as id_chave_filho, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.id_chave_categoria as id_chave_filho, node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.id_chave_filho, T.filho, T.esquerda, T.direita
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
SELECT DISTINCT T1.id from (SELECT parent.id_chave_nested_tipo_secao as id FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao in (SELECT T.nome FROM (SELECT node.nome_nested_tipo_secao as nome, (COUNT(parent.nome_nested_tipo_secao) - (min(sub_tree.depth) + 1)) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent, nested_tipos_secoes AS sub_parent, ( SELECT node.nome_nested_tipo_secao, (COUNT(parent.nome_nested_tipo_secao) - 1) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao = tipo_secao GROUP BY node.nome_nested_tipo_secao ORDER BY max(node.lft) ) AS sub_tree WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt AND sub_parent.nome_nested_tipo_secao = sub_tree.nome_nested_tipo_secao GROUP BY node.nome_nested_tipo_secao HAVING depth <= 2 ORDER BY max(node.lft)) as T where T.depth>0)  ORDER BY parent.lft) as T1
) ORDER BY FINAL.tfilho_esquerda) AS POS_FINAL order by POS_FINAL.esq;
END
//
DROP PROCEDURE IF EXISTS mostra_documento_completo_niveis
//
CREATE PROCEDURE mostra_documento_completo_niveis(IN tipo_secao varchar(200))
BEGIN
SELECT POS_FINAL.nivel as nivel, POS_FINAL.id_chave_filho, POS_FINAL.id_filho, (select "corpo_tese"), POS_FINAL.titulo as primeira_versao, POS_FINAL.id_nested_tipo_secao, POS_FINAL.nome_nested_tipo_secao, POS_FINAL.esq, POS_FINAL.dir, POS_FINAL.tem_filho, (SELECT trecho from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as ultima_versao,(SELECT nome_versao from versoes where id_secao = POS_FINAL.id_chave_filho order by nome_versao DESC LIMIT 1) as data, (SELECT count(*) from versoes where id_secao = POS_FINAL.id_chave_filho) as conta_versoes   FROM
(SELECT FINAL.nivel, FINAL.id_chave_filho, FINAL.id_filho, FINAL.id_pai, FINAL.titulo, FINAL.idtiposecao as id_nested_tipo_secao, (select nome_nested_tipo_secao from nested_tipos_secoes where id_chave_nested_tipo_secao = id_nested_tipo_secao) as nome_nested_tipo_secao, FINAL.tfilho_esquerda as esq, FINAL.tfilho_direita as dir, CASE WHEN (FINAL.tfilho_direita - FINAL.tfilho_esquerda = 1) THEN "NAO_TEM_FILHO" ELSE "TEM_FILHO" END as tem_filho FROM
(
	SELECT 
		T_filho.niveis as nivel, T_filho.id_chave_filho as id_chave_filho, T_filho.filho as id_filho, T_pai.filho as id_pai, (SELECT descricao from secoes where nome_categoria = T_filho.filho) as titulo, T_filho.id____tipo____secao as idtiposecao, T_filho.tfilhoesquerda as tfilho_esquerda, T_filho.tfilhodireita as tfilho_direita
	from 
		(
			SELECT 
				ST.niveis as niveis, ST.id_chave_filho as id_chave_filho, ST.filho as filho, ST.esquerda as tfilhoesquerda, ST.direita as tfilhodireita, ST.id___tipo___secao as id____tipo____secao 
			from 
				(
					SELECT 
						COUNT(T.pai) - 1 as niveis, T.id_chave_filho as id_chave_filho, T.filho as filho, T.esquerda as esquerda, T.direita as direita, T.id__tipo__secao as id___tipo___secao
					from 
						(
							SELECT 
								node.id_chave_categoria as id_chave_filho, node.nome_categoria as filho, parent.nome_categoria as pai, node.lft as esquerda, node.rgt as direita, node.id_tipo_secao as id__tipo__secao 
							from 
								secoes as node, secoes as parent 
									where node.lft BETWEEN parent.lft AND parent.rgt 
						) as T group by T.id_chave_filho, T.filho, T.esquerda, T.direita
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
SELECT DISTINCT T1.id from (SELECT parent.id_chave_nested_tipo_secao as id FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao in (SELECT T.nome FROM (SELECT node.nome_nested_tipo_secao as nome, (COUNT(parent.nome_nested_tipo_secao) - (min(sub_tree.depth) + 1)) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent, nested_tipos_secoes AS sub_parent, ( SELECT node.nome_nested_tipo_secao, (COUNT(parent.nome_nested_tipo_secao) - 1) AS depth FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.nome_nested_tipo_secao = tipo_secao GROUP BY node.nome_nested_tipo_secao ORDER BY max(node.lft) ) AS sub_tree WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt AND sub_parent.nome_nested_tipo_secao = sub_tree.nome_nested_tipo_secao GROUP BY node.nome_nested_tipo_secao HAVING depth <= 2 ORDER BY max(node.lft)) as T where T.depth>0)  ORDER BY parent.lft) as T1
) ORDER BY FINAL.tfilho_esquerda) AS POS_FINAL order by POS_FINAL.esq;
END
//

DELIMITER ;

DROP TABLE IF EXISTS versoes;
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
INSERT INTO propriedades (nome_propriedade) VALUES ("eh_paragrafo");
INSERT INTO propriedades (nome_propriedade) VALUES ("margem_simetrica");

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

INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("10%",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "margem_simetrica"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("15%",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "margem_simetrica"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("20%",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "margem_simetrica"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("25%",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "margem_simetrica"));

INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("sim",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "eh_paragrafo"));
INSERT INTO valores_discretos (nome_valor_discreto, id_propriedade) VALUES ("nao",(SELECT id_chave_propriedade FROM propriedades WHERE nome_propriedade = "eh_paragrafo"));


CREATE TABLE nested_tipos_secoes (
        id_chave_nested_tipo_secao INT AUTO_INCREMENT PRIMARY KEY,
        nome_nested_tipo_secao VARCHAR(200) NOT NULL,
	descricao varchar(10000),
        lft INT NOT NULL,
        rgt INT NOT NULL
);

INSERT INTO nested_tipos_secoes VALUES(1,'raiz','Rais dos Tipos de Secao',1,2);
#,(2,'topico',2,15),(3,'paragrafo',3,4), (4,'imagem',5,6),(5,'grafico',7,8),(6,'tabela',9,10),(7,'lista',11,14),(8,'item',12,13);

call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"capa",						"Capa do documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"titulo",					"Titulo Principal do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"titulo_abstract",				"Titulo do abstract em inglês");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"sub_titulo",					"Sub-Titulo do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"autor",					"Autor do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"autor_abr",					"Abreviatura do Autor do Documento (e.g. SILVA, J.)");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"autor_ficha",					"Autor do Documento para Ficha Catalográfica (e.g. Silva, José da)");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"orientador",					"Orientador do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"orientador_ficha",				"Abreviatura do Orientador para Ficha Catalográfica (e.g. Silva, José da)");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"coorientador",					"Coorientador do Documento");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"programa_pos",					"Nome do programa de pós-graduação");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"programa_pos_maiuscula",			"Nome do programa de pós-graduação em maiusculas");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"curso",					"Curso onde autor está matriculado");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"curso_maiuscula",				"Curso onde autor está matriculado em maiúsculas");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"mestre_ou_doutor",				"Escreva Mestre ou Doutor");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"titulo_pos",					"Descrever o titulo alcançado: Mestre em Engenharia, etc.");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"universidade",					"Nome da Universidade");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"universidade_maiuscula",			"Nome da Universidade em maiúsculas");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"unidade_faculdade",				"Nome da unidade ou faculdade dentro da Universidade");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"unidade_faculdade_maiuscula",			"Nome da unidade ou faculdade dentro da Universidade em maiúscula");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"localidade",					"Nome da cidade onde fica a universidade");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"ano",						"Ano da defesa da tese");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"palavras_chave",				"Palavras-chave da tese ou dissertação");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"epigrafe",					"Frase que dá o mote da obra.");
call insere_a_direita_dos_filhos_tipos_secoes("capa",				"dedicatoria",					"Frase de dedicatória.");
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
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"chama_ref",					"Chamada de referência em parágrafos dos tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"citacao",					"Citacao por extenso em itálico, dentro de tópicos ou das sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"imagem",					"Imagens dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"legenda_imagem",				"Legenda de Imagens dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"grafico",					"Gráficos dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"legenda_grafico",				"Legenda de gráficos dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"tabela",					"Tabelas dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"legenda_tabela",				"Legenda de tabela dos tópicos ou sessões");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"item_lista_num",				"Item de Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("topico",				"item_lista_nao_num",				"Item de Lista Numerada");
call insere_a_direita_dos_filhos_tipos_secoes("raiz",				"referencia",					"Referências da Tese");
call insere_a_direita_dos_filhos_tipos_secoes("referencia",			"item_de_referencia", 				"Itens da seção de referências");

CREATE TABLE instancias_propriedades (
	id_chave_instancia_propriedade INT AUTO_INCREMENT PRIMARY KEY,
	valor_continuo varchar(50),
	id_propriedade INT,
	id_valor_discreto INT,
	id_nested_tipo_secao INT,
	UNIQUE(id_propriedade, id_nested_tipo_secao),
	FOREIGN KEY (id_propriedade) REFERENCES propriedades(id_chave_propriedade),
	FOREIGN KEY (id_valor_discreto) REFERENCES valores_discretos(id_chave_valor_discreto),
	FOREIGN KEY (id_nested_tipo_secao) REFERENCES nested_tipos_secoes(id_chave_nested_tipo_secao)
); 


INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "2.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="capa"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="agradecimento"));


INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="resumo"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="abstract"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="lista_de_tab_fig"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="indice"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "bold"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="topico"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "sim"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "normal"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="paragrafo"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "sim"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "justificado"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "1.0"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tipo_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tipo_fonte" AND B.nome_valor_discreto = "italico"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="citacao"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="imagem"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="imagem"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="grafico"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="grafico"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="tabela"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "centro"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="tabela"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "esquerda"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_num"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_num"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="tamanho_fonte"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "tamanho_fonte" AND B.nome_valor_discreto = "0.8"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_num"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="margem_simetrica"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "margem_simetrica" AND B.nome_valor_discreto = "20%"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_num"));

INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="alinhamento"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "alinhamento" AND B.nome_valor_discreto = "esquerda"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_nao_num"));
INSERT INTO instancias_propriedades (valor_continuo,id_propriedade, id_valor_discreto, id_nested_tipo_secao) VALUES ("",(SELECT id_chave_propriedade FROM propriedades where nome_propriedade="eh_paragrafo"),(SELECT id_chave_valor_discreto FROM propriedades as A, valores_discretos as B WHERE B.id_propriedade = A.id_chave_propriedade AND A.nome_propriedade = "eh_paragrafo" AND B.nome_valor_discreto = "nao"),(SELECT id_chave_nested_tipo_secao FROM nested_tipos_secoes where nome_nested_tipo_secao ="item_lista_nao_num"));

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

CREATE TABLE versoes(
	id_chave_versao int not null auto_increment PRIMARY KEY,
	nome_versao TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP(6),
	id_secao int,
	trecho varchar(15000),
	unique (id_secao, nome_versao),
	FOREIGN KEY (id_secao) REFERENCES secoes(id_chave_categoria) 
);

# importante -> nao pode usar traço no primary key do nome_categoria


insert into secoes values (1,'corpo_tese','raiz','',1,2, (SELECT id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao="raiz"));


call insere_a_direita_dos_filhos("corpo_tese", "capa_da_tese", "Capa da Tese" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "capa"));
call insere_a_direita_dos_filhos("capa_da_tese", "titulo_da_tese", "CARACTERIZAÇÃO DO PROGRAMA Workshop Aficionados por Software e Hardware (WASH)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "titulo"));
call insere_a_direita_dos_filhos("capa_da_tese", "sub_titulo_da_tese", "HISTÓRIA, MÉTODOS E RESULTADOS" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "sub_titulo"));
call insere_a_direita_dos_filhos("capa_da_tese", "autor_da_tese", "Elaine da Silva Tozzi" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "autor"));
call insere_a_direita_dos_filhos("capa_da_tese", "autor_abreviatura", "Tozzi, E.S." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "autor_abr"));
call insere_a_direita_dos_filhos("capa_da_tese", "autor_ficha_catalografica", "Tozzi, Elaine da Silva" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "autor_ficha"));
call insere_a_direita_dos_filhos("capa_da_tese", "titulo_do_abstract", "Characterization of the Hardware and Software for Geeks Program " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "titulo_abstract"));
call insere_a_direita_dos_filhos("capa_da_tese", "orientador_da_tese", "Paulo Sérgio Camargo" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "orientador"));
call insere_a_direita_dos_filhos("capa_da_tese", "orientador_ficha_catalografica", "Camargo, Paulo Sérgio" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "orientador_ficha"));
call insere_a_direita_dos_filhos("capa_da_tese", "programa_de_pos_graduacao", "Programa de Pós-Graduação da UTFPR" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "programa_pos"));
call insere_a_direita_dos_filhos("capa_da_tese", "programa_de_pos_graduacao_maiusculas", "PROGRAMA DE PÓS-GRADUAÇÃO DA UTFPR" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "programa_pos_maiuscula"));
call insere_a_direita_dos_filhos("capa_da_tese", "curso_matriculado", "Curso de Pós-Graduação em Licenciatura" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "curso"));
call insere_a_direita_dos_filhos("capa_da_tese", "curso_matriculado_maiuscula", "CURSO DE PÓS-GRADUAÇÃO EM LICENCIATURA" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "curso_maiuscula"));
call insere_a_direita_dos_filhos("capa_da_tese", "indique_mestre_ou_doutor", "Mestre" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "mestre_ou_doutor"));
call insere_a_direita_dos_filhos("capa_da_tese", "titulo_da_pos_graduacao", "Mestre em Licenciatura" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "titulo_pos"));
call insere_a_direita_dos_filhos("capa_da_tese", "nome_da_universidade", "Universidade Tecnológica Federal do Paraná" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "universidade"));
call insere_a_direita_dos_filhos("capa_da_tese", "nome_da_universidade_maiuscula", "UNIVERSIDADE TECNOLÓGICA FEDERAL DO PARANÁ" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "universidade_maiuscula"));
call insere_a_direita_dos_filhos("capa_da_tese", "nome_da_unidade", "Faculdade de Educação" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "unidade_faculdade"));
call insere_a_direita_dos_filhos("capa_da_tese", "nome_da_unidade_maiuscula", "FACULDADE DE EDUCAÇÃO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "unidade_faculdade_maiuscula"));
call insere_a_direita_dos_filhos("capa_da_tese", "nome_da_localidade", "Londrina" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "localidade"));
call insere_a_direita_dos_filhos("capa_da_tese", "lista_palavras_chave", "Papert, STEAM, STEM, WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "palavras_chave"));
call insere_a_direita_dos_filhos("capa_da_tese", "frase_epigrafe", "Ciência é a compreensão que o outro constrói sobre o conhecimento de alguém." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "epigrafe"));
call insere_a_direita_dos_filhos("capa_da_tese", "frase_dedicatoria", "Dedico esta dissertação aos meus pais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "dedicatoria"));
call insere_a_direita_dos_filhos("capa_da_tese", "ano_de_defesa", "2022" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "ano"));
call insere_a_direita_dos_filhos("corpo_tese", "agradecimento_da_tese", "Agradecimentos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "agradecimento"));
call insere_a_direita_dos_filhos("agradecimento_da_tese", "paragrafo_agradecimento_1", "Gostaria de agradecer meus pais por tudo que me propiciaram." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo_agradecimento"));
call insere_a_direita_dos_filhos("corpo_tese", "resumo_da_tese", "RESUMO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "resumo"));
call insere_a_direita_dos_filhos("resumo_da_tese", "paragrafo_res_1", "Neste trabalho o Programa Workshop de Aficcionados em Software e Hardware será caracterizado quanto à sua história, métodos e resultados." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo_resumo"));
call insere_a_direita_dos_filhos("corpo_tese", "estrutura_do_texto", "ESTRUTURA DO TEXTO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_1", "Este trabalho busca utilizar a forma mais canônica de estruturação de um texto científico [XXX Oftalmo DOI: 10.5935/0034-7280.20140055]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_1_lista_IMRD", "introdução" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_2_lista_IMRD", "métodos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_3_lista_IMRD", "resultados" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_4_lista_IMRD", "discussão" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_2", "A referência [XXX Oftalmo DOI: 10.5935/0034-7280.20140055] busca identificar o caráter principal de cada um dos elementos acima por meio de uma pergunta, como segue:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_1_lista_IMRD_perg", "Introdução - que pergunta foi feita?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_2_lista_IMRD_perg", "Métodos - como ela foi estudada?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_3_lista_IMRD_perg", "Resultados - o que foi achado?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_4_lista_IMRD_perg", "Discussão - o que estes achados significam? " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "ref_item_4_lista_IMRD_perg", "(fonte: [XXX Oftalmo DOI: 10.5935/0034-7280.20140055]:)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_3", "Uma forma diferente de expressar esses mesmos conceitos é atribuir a pergunta \"por que fiz? à Introdução, atribuir a pergunta \"como fiz? aos Métodos e atribuir a pergunta \"o que obtive? aos Resultados, de forma que a pesquisa empregada permita observar o mesmo objeto em estudo por meio de 3 dimensões que se complementam. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_4", "A estrutura indicada acima pode ter variantes mais completas como a descrita em [XXX How to Write a Paper in Scientific Journal Style and Format]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_1_lista_IMRD_completa", "Resumo - O que eu fiz de uma forma bem sintética (\"in a nutshell)?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_2_lista_IMRD_completa", "Introdução - Qual é o problema?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_3_lista_IMRD_completa", "Materiais e Métodos - Como eu resolvi o problema?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_4_lista_IMRD_completa", "Resultados - O que eu achei?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_5_lista_IMRD_completa", "Agradecimentos (opcional) - Quem me ajudou a fazer?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_6_lista_IMRD_completa", "Literatura citada - Quais trabalhos eu usei como referência?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "item_7_lista_IMRD_completa", "Apêndices - Informação Extra" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "ref_item_8_lista_IMRD_completa", "(tradução livre de [XXX How to Write a Paper in Scientific Journal Style and Format])" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_5", "A variante acima, embora voltada para publicações curtas, é válida para outros tipos de registros científicos e também é baseada na ideia das 3 dimensões descrita acima: \"por que?, \"como? e \"o que?. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_6", "De forma mais completa ainda, mas com a mesma estrutura básica: " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "ref_paragrafo_6", "S.A.Meo [XXX Anatomy and physiology of a scientific paper] propõe o \"MEO’s Fish Bone Model" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "imagem_1", "/var/www/html/tese/dados/imagens/MEOS-Fish-Bone-Model-Basic-components-of-a-scientific-paper.png" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "imagem"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "legenda_imagem_1", "Fig 1. - A estrutura de \"espinha de peixe de S.A. MEOs (fonte: S.A.Meo [XXX Anatomy and physiology of a scientific paper])" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "legenda_imagem"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_7", "Uma vez que a Fig. 1 é um pouco \"congestionada no sentido da densidade de informações apresentadas, cabe uma descrição de cada \"costela da espinha-de-peixe de MEOs, transcrita aqui na forma de uma tabela:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "tabela_1", "/var/www/html/tese/dados/tabelas/tabela_estrutura_de_texto.html" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "tabela"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_8", "As 3 estruturas exemplificadas [XXX MEO, How to Write e Oftalmo] acima tratam, principalmente, de papers científicos, em que a concisão é especialmente necessária. Mas papers cientificos não são o único formato disponível para realizar uma comunicação científica. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_9", "Existem formatos mais extensos para documentação, tais como: relatórios, teses, comunicações rápidas. Alaide Mammana também explora estas nuances, muito embora a estrutura básica seja sempre \"Introdução, Métodos, Resultados e Discussão, como já reforçado aqui." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "ref_paragrafo_9", "[XXX Alaide Mammana, Documentação científicas]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "paragrafo_10", "O presente texto, por se tratar de uma dissertação, pode se valer desses formatos mais extensos, uma vez que se trata da \"defesa para obtenção de um título (mestrado), em que a presente candidata tem que demonstrar erudição nos temas abordados. O formato menos conciso permite à esta candidata expor melhor a sua busca por uma erudição, dado que comporta a revisão de conhecimentos já existentes de forma mais estendida." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Introducao", "Descrição da Introdução" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_11", "Seguindo as sugestões presentes em S. MEO, optou-se por uma introdução curta, leve e objetiva. A introdução é estruturada para culminar, por meio de seus últimos parágrafos, na descrição do objeto de estudo. O caminho percorrido é o de descrever esse objeto do mais geral até o específico. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "ref_paragrafo_11", "[citar XXX]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_12", "Para que que pudesse se expressar de forma organizada, buscando demonstrar sua erudição, sem perder a objetividade da \"Introdução\", a presente candidata acatou a sugestão do orientador de incluir um capítulo de \"Fundamentação Teórica, no qual os temas pincelados na \"Introdução pudessem ser mais profundamente descritos, sem prejuízo para um formato \"leve e balanceado para a apresentação da literatura na introdução, um aspecto que, segundo S.A. Meo, e.g., deve ser perseguido pelo redator de textos científicos. Assim, a exposição na \"Introdução busca ser o mais sintética possível, com direcionamento para a \"Fundamentação Teórica sempre que for necessário aprofundar em algum conceito. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Introducao", "paragrafo_13", "Para facilitar a leitura, a presente candidata optou, também, por colocar em subseções da \"Introdução a exposição dos problemas, hipóteses, das questões e dos objetos de interesse." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Materiais_e_Metodos", "Descrição de Materiais e Métodos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Materiais_e_Metodos", "paragrafo_14", "Uma vez que a presente pesquisa tem por objeto a caracterização do Projeto WASH quanto à sua história (trajetória), métodos e resultados, a descrição do método do WASH deve ser considerada como resultado do método da pesquisa. Em outras palavras, uma das dimensões do método aqui empregado refere-se a caracterizar o método do WASH. Portanto, a pesquisa se baseia num método de caracterização de métodos. Assim, a descrição do método do WASH deve ser considerada uma decorrência da aplicação do método da pesquisa desta dissertação e, por esse motivo, encontra-se no capítulo de \"Resultados e não no capítulo de \"Materiais e Métodos. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Resultados_e_Discussoes", "Descricao de Resultados e Discussões" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Resultados_e_Discussoes", "paragrafo_15", "A candidata optou por juntar em um único capítulo os resultados e as discussões (\"Resultados e Discussões). Esta opção visa garantir uma melhor fluidez, dado que permite apresentar as opções de análise que levaram à proposta de melhorias no método do WASH, o produto final desta dissertação. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("estrutura_do_texto", "estrutura_do_texto_Produto_Tecnologico", "Produto Tecnológico" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estrutura_do_texto_Produto_Tecnologico", "paragrafo_16", "A presente dissertação, por se tratar de um Mestrado Tecnológico, deve culminar com a apresentação de um \"produto de caráter prático, que no presente caso será uma revisão do Documento de Referência do Projeto WASH  constante do anexo da  Portaria CTI 178/2018). Por esse motivo foi acrescentado à estrutura do documento um capítulo de \"Produto Tecnológico. Biblioteca Cidadã Paulo Freire" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "Introducao", "INTRODUÇÃO" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_17", "Aos olhos de jovens observadores contemporâneos, parece natural a relativa desenvoltura com que as pessoas utilizam os computadores e os celulares nos dias de hoje. Já estão bastante difundidos os serviços de governo eletrônico, os sites de comércio eletrônico, os  aplicativos de entrega, as plataformas de ensino, de reuniões, a busca por  trabalho, oportunidades, voto eletrônico, banco e caixa eletrônico, por exemplo." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "ref_paragrafo_17", "[XXX]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_18", "Essas ferramentas são continuadamente revistas e melhoradas, assim como não param de se multiplicar para atender e se adaptar aos desafios impostos pela evolução da convivência em sociedade. Um exemplo dessa necessidade de adaptação foi recentemente evidenciado pela forma como a sociedade respondeu às imposições sanitárias relativas à pandemia de 2020, quando os cidadãos tiveram que se adaptar ao isolamento e encontrar formas para continuarem produtivos por meios das redes digitais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "ref_paragrafo_18", "[XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_19", "É possível afirmar que as pessoas têm usado com frequência e com relativa facilidade as ferramentas digitais instaladas em computadores e em celulares, sejam aplicativos de mensagens, buscadores (browsers), correio eletrônico, redes sociais, entre outras. Esse uso dá-se em vários contextos: profissional, educacional, de entretenimento, de interação social, além dos serviços de governo eletrônico." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_20", "As novas gerações precisam, no entanto, saber que não foi sempre assim. Muito embora a percepção corrente de que o uso de computadores e celulares é indispensável para o convívio na sociedade, a rigor seu uso é relativamente recente." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_21", "É possível identificar a evolução das telecomunicações a partir do século passado como origem das transformações tecnológicas que disponibilizaram tecnologias digitais em larga escala. Esse fato foi identificado, por exemplo, por PIERRE LEVY, em Cibercultura, " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "citacao_1", "durante uma entrevista nos anos 50, Albert Einstein (1879-1955) declarou que três grandes bombas haviam  explodido durante o século XX: a bomba demográfica, a bomba atômica e a bomba das telecomunicações. Esta última ‘bomba’ foi chamada por Roy Ascott ( pioneiro e teórico das artes em rede) de Segundo Dilúvio, o das informações. As telecomunicações geram esse novo dilúvio por conta da natureza exponencial, explosiva e caótica do seu crescimento. A quantidade de dados e links se multiplica, acelera, aumento de links, banco de dados, hipertextos nas redes, contos transversais, etc." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("Introducao", "ref_citacao_1", "[1]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "chama_ref"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_22", "Ainda, segundo Pierre Levy," , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "citacao_2", "\"O segundo dilúvio não terá fim. Não há nenhum fundo sólido sob o oceano de informações. Devemos aceitá-lo como nossa nova condição. Temos que ensinar nossos filhos a nadar, a flutuar, talvez a navegar." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_23", "Para desenvolver e dar acesso a estes recursos tecnológicos,  governos tiveram que prover a infraestrutura de ciência e tecnologia, comunicações e de redes digitais e os meios de acesso a essas redes, algumas vezes com a participação da iniciativa privada. Na outra ponta, tiveram que promover projetos, formular políticas públicas de C&T para o desenvolvimento e  disseminação do uso das tecnologias da informação e comunicação e para a capacitação dos cidadãos através de programas de caráter educacional e de formação profissional. No Brasil, a gênese desse esforço foi deflagrada pelo Estado no início da década de 60 [2], sendo que suas ações perduram até os dias de hoje. Uma revisão essa trajetória brasileira será apresentada no capítulo de \"Fundamentação Teórica." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_24", "Se para alguns as redes digitais tinham o objetivo de atender os indivíduos em suas necessidade de relacionamento com o governo, afinal a própria internet nasceu no contexto governamental [XXX], elas foram mais longe, e alcançaram todas as demais dimensões do cidadão, tais como: consumidor, beneficiário de serviços de saúde, educando, trabalhador, empreendedor, contribuinte, eleitor, entre outras.  Essa expansão se deu como resultado de várias ações, mas sua universalização foi resultado principalmente do surgimento de novas formas de relacionamento social representadas pelas redes sociais digitais, que tornaram mais acessíveis novas ferramentas de apoio ao ensino em sala de aula, o ensino à distância, o comércio eletrônico, a eleição eletrônica, os \"market-places, os aplicativos de transporte, etc. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_25", "Estas transformações tiveram impactos econômicos e sociais profundos, inclusive nas relações de trabalho, seja na criação ou extinção de posto de trabalho, bem como em suas formas de contratação, jornada, remuneração, inclusive com a precarização dos direitos trabalhistas. Elas estão muito bem descritas  no relatório da Unesco  de 2004 \"Social Transformation in an Information Society: Rethinking Access to You and the World [3]. A amplitude destas  transformações por que passa a sociedade humana é sintetizada no que se chama  Sociedade da Informação ou  Era Digital ou Era da Informação. Uma breve revisão sobre esse conceito  é apresentada na fundamentação teórica. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_26", "O efeito destas transformações no emprego vem exigindo dos governos, das empresas e dos cidadãos uma constante e rápida readaptação  das relações do trabalho, comerciais, industriais e da produção de novos saberes e competências. Aqueles cidadãos que não se adaptam correm o risco constante de ficarem sem sustento. Inicialmente tais transformações eram associadas principalmente à substituição do trabalho humano decorrente da automação industrial. Mas a radicalização no uso de soluções digitais, inclusive de inteligência artificial, associadas ao aumento da conectividade, vêm substituindo capacidades \"cognitivas que antes eram exclusivas de humanos[4]. Uma das consequências mais radicais é o surgimento de novos meios de exploração humana, representados pela \"Gigs Economy [XXX], ou \"Economia do Bico, que precariza as relações trabalhistas por meio de plataformas que as impessoaliza a ponto de camuflar a exploração [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_27", "Vários países têm buscado uma melhor preparação para enfrentar essas transformações, dotando o cidadão de meios cognitivos, de conhecimento e culturais para se readaptar. Para isso, têm procurado remodelar seus sistemas educacionais, uma vez que \"ficar para trás em relação aos demais países pode afetar a prosperidade de suas populações, sua autonomia e liberdade [XXX]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_28", "Mais do que simplesmente treinar o cidadão quanto ao uso  de serviços digitais, a educação tem um papel fundamental para preparar os cidadãos para sua inserção autônoma e digna na sociedade transformada pelas tecnologias de informação e comunicação. O Estado tem o desafio de estabelecer políticas públicas e prover infraestrutura para que o cidadão possa ter acesso e se beneficiar, de forma autônoma, dos recursos digitais e de comunicação.." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_29", "A percepção da importância da educação para a prosperidade da sociedade é muito antiga e, no caso americano, remonta aos primórdios da independência americana. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_30", "No capítulo \"Fundamentação Teórica revisaremos as origens do conceito de \"Science, Technology, Engineering and Mathematics (STEM), mostrando que já em 1790 o  presidente George Washington, em seu primeiro discurso do \"Estado da União promovia a ciência e literatura como uma base da \"felicidade pública [XXX citar fonte]. Essa percepção de valor perdurou por toda a existência americana, estimulada, inclusive, como resposta às ameaças externas muito posteriores, tais como o sucesso soviético no programa espacial, representado pelo pioneirismo do lançamento do satélite Sputnik no final da década de 50, por exemplo. É no cenário da Guerra Fria que a política de educação em STEM e alfabetização  científica e tecnológica  é vista como bem comum para o Estado, mesmo muito antes do uso desse acrônimo de forma oficial. ( Relatório CRS para o Congresso, www.crs.gov, 2012) " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_31", "Não obstante esta permanente percepção pública da importância e do valor da ciência, nos anos 90 foram identificadas fragilidades nas estruturas em educação STEM americana, as quais prejudicavam a prosperidade, o \"poderio nacional, a inserção de seus cidadãos no novo mundo do trabalho, do empreendedorismo, de forma autônoma, soberana  e próspera. Essas fragilidades foram evidenciadas pelo recorrente e relativamente baixo desempenho de adolescentes americanos no Programme for International Student Assessment (PISA) [XXX Catterall]. Com isso, o governo federal americano teve que mobilizar ações para atualizar as competências curriculares, visando manter uma inserção hegemônica na economia do século XXI. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_32", "Segundo o Relatório CRS para o Congresso, do Serviço de Pesquisa do Congresso, mais de 200 projetos de Lei contendo o termo \" educação científica \" foram introduzidos nos 20 anos entre os 100 ( 1987-1988) e 110 (2007-2008). Sendo que 13 agências federais conduzem programas ou atividades de educação STEM. (Pag.2 do Relatório). " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_33", "[YYY precisa melhorar esse parágrafo]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_34", "Faltava aos EUA uma política nacional uniforme e inclusiva de ensino de ciências, pois identificavam-se diferentes ênfases sobre o assunto no vasto sistema educacional americano [XXX Catterall]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_35", "Mas existia também o reconhecido pioneirismo da comunidade acadêmica americana nos métodos voltados para o aprendizado de temas relacionados ao STEM, ainda que não identificados sob esse acrônimo ou mesmo que não amplamente disseminados em seu sistema educacional, como viriam a reconhecer os relatórios do congresso americano [XXX citar]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_36_a", "Seymour Papert, matemático sul-africano radicado nos EUA, do Laboratório de Inteligência Artificial do Massachusetts Institute of Technology (MIT), foi um  cientista, educador que acreditava  no  uso do computador como forma de revolucionar o sistema  educacional  desde os anos 60. Esse pesquisador, que vivenciou a guerra fria, colaborou na estruturação do Departamento de  [YYY - tá faltando algo aqui]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_36_b", "Ele foi o \"filósofo dos pioneiros a pensar a aprendizagem de crianças de forma diferente. Em 1968 escreveu o artigo \" Teaching Children Thinking \"  em que abordava  o tema sobre crianças, educação e computadores: " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "citacao_3", "\"Tinhamos  a certeza de que quando os computadores se tornassem tão comuns quanto ao lápis a educação mudaria tão rápida e profundamente quanto as transformações pelas quais vivíamos nos direitos civis e nas relações sociais e sexuais. [XXX colocar a citação aqui]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_37", "Papert formulou esse pensamento quando os computadores dos anos 70 ainda não eram acessíveis ou disponíveis para uso doméstico ou no sistema educacional. Naquele tempo não existia o conceito de \"micro-computadores e computadores com poder de processamento milhares de vezes inferior ao de um notebook de hoje ocupavam andares inteiros de prédios [XXX lei de moore]. Os custos eram muito altos, o acesso era muito restrito e havia dúvidas sobre se algum dia seriam amplamente acessíveis [XXX referência]. Mas mesmo na forma de mainframes centralizados (computadores de grande porte) com as limitações indicadas acima, foi possível a Papert realizar incursões pioneiras no campo da aprendizagem para crianças utilizando computadores, mesmo que restrita a uma elite, sem, ainda, a possibilidade de uma grande disseminação no sistema educacional [XXX é possível encontrar referências?].  Portanto, foi um visionário ao sugerir que a criança teria, um dia, amplo acesso ao computador, a ponto de ficar no comando do computador durante a aprendizagem e não o contrário [XXX citar a fi]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_38", "Toda uma geração de educadores foi formada em torno das ideias de Papert, que defendia que a aprendizagem de linguagem de programação de computadores, já no ensino fundamental, poderia ter um papel importante no aprendizado de muitas outras disciplinas tradicionais, tais como matemática, ciências e linguagem. A proposta de Papert, até por enfatizar o aprendizado de crianças, não tinha qualquer ambição de capacitação profissional e, por si só, não visava diretamente fazer frente aos desafios do \"mundo do trabalho, que foram sendo introduzidos pelas transformações inerentes à Sociedade da Informação nas décadas subsequentes. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_39", "Diferentemente de um simples treinamento para usar computadores, o método de Papert representava uma mudança em paradigmas educacionais, focalizando a aprendizagem em detrimento do ensino [XXX Brasil Plan ou outra citação do Papert nesse sentido]. A ideia era \"aprender o que se precisa e não \"aprender o que se deve [XXX verificar outras citações melhores de Papert para colocar aqui]. Outro ponto importante era buscar a ludicidade no aprendizado [XXX citar a fonte - YYY - falta complementar aqui]. O capítulo de Fundamentação Teórica traz um aprofundamento sobre o pensamento de Papert." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_40", "O caráter estritamente educacional e a peculiar abordagem das propostas de Papert são apontados em \"Brazil Plan [XXX] (aliás, muito a posteriori por seus colegas) como uma alternativa para a inserção do indivíduo na \"era digital (digital age). " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_41", "Não obstante conceitualmente diferentes, uma vez que \"Sociedade da Informação tem um viés sociológico [XXX citar fonte] e a \"Era Digital identifica as transformações tecnológicas, referem-se ao mesmo período que culmina com o \"dilúvio de informações já mencionado por Levy. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_42", "Portanto é razoável assumir que os conceitos educacionais de Papert são reconhecidos por seus discípulos [XXX Brazil Plan] também como uma caminho natural para uma melhor inserção dos indivíduos na Sociedade da Informação." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_43", "Da mesma forma, é razoável assumir que uma parte das iniciativas educacionais mundiais em torno de STEM basearem-se em trabalhos como os de Papert, que propunham uma educação despojada de formalismos, voltada para a resolução de problemas, ao invés da histórica obsessão por conteúdos. Esse tipo de abordagem inspirou boa parte dos conceitos subjacentes à \"pedagogia orientada a projeto[XXX], ao \"problem solving learning[XXX], ao \"design thinking, à \"maker culture, entre outros [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_44", "As já mencionadas [XXX citar onde foi mencionado] preocupações com o relativo baixo desempenho em STEM, que se aprofundavam nos EUA nos anos 90, alcançaram o resto do mundo e propostas começaram a surgir para tentar promover a qualificação da educação em países em desenvolvimento por meio do uso intensivo de computadores, nos moldes do que enxergará Papert em seus trabalhos seminais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_45", "O Projeto \"One Laptop Per Child [XXX Brazil Plan] foi uma das iniciativas mais completas e robustas neste sentido, tendo saído  do próprio MIT, especificamente concebido por discípulos de Papert, os quais estabeleceram planos para regiões específicas do mundo, a exemplo do documento \"Brazil Plan, direcionado à \"Brazilian Task Force e compartilhado com governo brasileiro em 2004-2005 [XXX Brazil Plan]. O OLPC era explicitamente apoiado por Papert, quando ainda estava vivo. Isso pode ser comprovado pela sua presença ativa e eloquente nas reuniões de apresentação do OLPC ao Governo Brasileiro [XXX acervo de VPM], inclusive numa visita ao presidente Lula [XXX colocar foto do Lula com Papert, Negroponte]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_46", "Nicholas Negroponte, o líder da iniciativa do OLPC, era um destacado \"gurú de chefes de estado, a exemplo de Miterrand, que na década de 80 o convidara a integrar o Conselho do \"Center Mondiale [XXX procurar referências]. Coincidentemente, era irmão de John Negroponte, então Secretário de Estado do Governo Bush, figura influente nos meios políticos, na comunidade de informação, em outras áreas estratégicas e de defesa daquele país. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_47", "Nicholas transitava com desenvoltura entre líderes como Kofi Anan [XXX acervo de VPM], Presidente da Índia, Presidente Americano, entre outros [XXX achar comprovação dessa informação por meio de fotos]. Em 2004, conseguiu uma audiência com o Presidente Lula, quando este participava do Fórum  Econômico  em Davos. Foi nesse momento em que o Projeto OLPC foi apresentado, pela primeira vez, ao conhecimento do governo Brasileiro [XXX Brazil Plan]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_48", "A proposta era ousada e atraente no que tange à transformação dos métodos pedagógicos. Por outro lado, era também exigente em termos de recursos, uma vez que preconizava a aquisição de milhões de notebooks como forma de empoderamento dos estudantes [XXX Brazil Plan]. Em termos orçamentários, a adesão à proposta de Negroponte representava um valor significativo do orçamento do Ministério da Educação e, para que fosse viabilizada, precisaria passar por um escrutínio da sociedade brasileira." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_49", "Ciente do risco que representava uma adesão voluntariosa a um programa tão disruptivo, a Presidência da República da época decidiu constituir um grupo de avaliação  daquela proposta, o  qual foi constituído por universidades e centros de pesquisa. Foram chamados o Centro de Tecnologia da Informação Renato Archer (CTI), a Escola Politécnica da USP e a Universidade Federal de Santa Catarina [XXX tentar encontrar os documentos da época]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_50", "As instituições mencionadas avaliaram o projeto em vários aspectos [XXX Paper de Cubatão]: proposta pedagógica, modelo de negócios, sustentabilidade, redes, política industrial, software, ergonomia e conteúdo. A proposta previa a aquisição de um \"laptop por estudante brasileiro, ou seja, perto de 30 a 40 milhões de unidades." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_51", "Segundo a visão trazida pelo MIT [XXX Brazil Plan] ao governo brasileiro, a disponibilização em larga escala de acesso à internet alteraria da relação aluno-professor, promovendo formas de aprendizagem alternativas ao conteudismo tradicional, reformulando também o formato lousa-giz inerente ao sistema educacional brasileiro [XXX Paper Cubatão]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_52", "Um dos aspectos principais do projeto apresentado ao governo, do ponto de vista das ferramentas de software, era a disponibilização de uma ferramenta de programação mais intuitiva e lúdica do que o próprio LOGO, linguagem de programação desenvolvida por Papert na década de 60 e muito difundida no contexto educacional a partir daquela época [XXX trazer referência do LOGO - não esquecer de citar os outros 2 autores do LOGO]. Como alternativa ao já serôdio Logo, estava em fase final de desenvolvimento o Scratch, linguagem criada por Mitchel Resnick que compartilhava alguns de seus conceitos [XXX trazer referência]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_53_a", "Das 3 instituições envolvidas na avaliação do OLPC, esta candidata  teve acesso à avaliação do CTI [XXX paper cubatão], que ficou encarregado da:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "item_1_lista_CTI", "avaliação de características de ergonomia postural, por meio da captura de movimento;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_2_lista_CTI", "avaliação de características de ergonomia sensorial, por meio de técnicas relacionadas à área de mostradores de informação;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_3_lista_CTI", "avaliação da funcionalidade dos \"laptops, principalmente em termos de redes, processamento, memória e baterias;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_4_lista_CTI", "avaliação do emprego dos dispositivos no âmbito da escola pública;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_5_lista_CTI", "avaliação da percepção dos professores sobre o projeto;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_6_lista_CTI", "análise da infraestrutura das escolas, visando verificar a viabilidade de implantação do projeto;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_7_lista_CTI", "acompanhamento de pilotos de avaliação em escolas públicas brasileiras." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "item_8_lista_CTI", "visitas a pilotos nos Estados Unidos." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_53_b", "Do ponto de vista da aquisição de \"laptops em larga escala, o CTI identificou uma série de dificuldades nas seguintes áreas: apropriação pela escola brasileira, produção dos laptops, restrições orçamentárias, problemas ergonômicos e, principalmente, obsolescência dos equipamentos [XXX Paper Cubatão]. Estes aspectos demonstraram que a ideia de aquisição de milhões de laptops representava um risco muito grande para o sistema educacional brasileiro." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_54", "O estudo apontava, também, que o sistema educacional poderia se beneficiar de alguns aspectos da proposta, mas que qualquer iniciativa disruptiva no sistema educacional brasileiro requereria mais investimentos em recursos humanos do que em hardware ou software, ao contrário do que propunha o Projeto OLPC, que focaliza a aquisição dos computadores. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_55", "Esta percepção de que o Projeto OLPC era desfocalizado nascia da própria definição de educação empregada pelo CTI em sua análise: \"Educação é a inserção do indivíduo em sua própria cultura através da interação com outros indivíduos [XXX achar fonte]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_56", "A definição que norteava a avaliação colocava interação entre indivíduos no centro do processo e, portanto, qualquer esforço de qualificação da escola brasileira precisaria passar por uma ênfase no investimento em \"pessoas, mais do que em software ou hardware." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_57", "O Projeto WASH nasceu [XXX paper de Cubatão] como uma proposta alternativa ao OLPC, com custo inferior, que não exigia a aquisição de milhões de equipamentos, mas que se inspirava nos mesmos métodos exitosos de Papert presentes no OLPC." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_58", "Assim [XXX paper cubatão], o Projeto WASH buscou centrar-se na criação de espaços de interação no contexto de valores do método científico, buscando estabelecer meios para estimular, inicialmente, as disciplinas de STEM e, posteriormente, incluindo arte na lista, como tantos outros autores fizeram naquele período [XXX James Catterall, Yakman, Mammana, etc… etc.. ]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_59", "A avaliação do Projeto OLPC proporcionou uma resignificação para a proposta, permitindo compreender mais profundamente os desafios do uso intensivo de tecnologia da informação no contexto da escola pública brasileira e, com isso, propor uma alternativa." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_60", "O WASH se constitui em atividades em grupo, realizadas no contraturno, desvinculadas do currículo tradicional da escola formal, cujos valores principais se alicerçam no método científico. O WASH não é um curso, mas se constitui em espaços de interação humana para experimentação e convivência entre indivíduos, no contexto do desenvolvimento de projetos de vários níveis de complexidade." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_61", "Pela forma como os pilotos do WASH acabaram sendo implementados no contexto do CTI Renato Archer, houve a consolidação da visão de que instituições de P&D têm um papel a desempenhar no contexto da educação informal no contraturno, estabelecendo uma ponte direta entre centros de excelência e a escola pública brasileira." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_62", "Hoje o Projeto WASH tem seu método descrito por meio de um documento de referência, a Portaria CTI 178/2018, que estabelece uma \"liturgia [XXX citar uma paper nosso que usa esse termo] de realização de oficinas, os papeis de cada participante e a forma de operação. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_63", "Neste trabalho será feita caracterização do projeto Workshop Aficionados em Software e Hardware (WASH), que declaradamente por seus criadores, foi inspirado pela proposta OLPC. Por curioso, não obstante tenham se inspirado nos conceitos pedagógicos presentes na proposta americana, também se posicionaram contra a aquisição dos notebooks [XXX citar paper de Cubatão] pelo governo brasileiro, em razão de outros aspectos do projeto que mostravam-se inviáveis, principalmente no campo orçamentário, industrial, ergonômico, inclusivo e de logística [XXX citar os relatórios do OLPC]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "paragrafo_64_a", "A abordagem adotada na presente dissertação se encaixa no método de \"Estudo de Caso e buscará contar toda essa trajetória que se inicia no que foi descrito aqui, bem como identificar o método do Projeto WASH e seus resultados. O documento fundamental a ser usado para permitir a caracterização do projeto é a Portaria CTI 178 e outros registros, tais como publicações, relatórios, planos de trabalho, produção audiovisual, entre outras." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "Objeto_Introducao", "Objeto" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Objeto_Introducao", "paragrafo_64_b", "Este trabalho tem por objeto de estudo o  Projeto WASH." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "Objetivo_Introducao", "Objetivo" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Objetivo_Introducao", "paragrafo_65", "Este trabalho tem por objetivo caracterizar  o Projeto Workshop de Aficionados em Software e Hardware (WASH) quanto à sua trajetória (história), os métodos e os resultados, com vistas a propor uma melhoria em suas práticas, por meio da revisão do  Documento de Referência constante no anexo da  Portaria CTI 178/2018." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "Hipoteses_Introducao", "Hipóteses" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Objetivo_Introducao", "paragrafo_66", "O presente trabalho tem como hipóteses:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_1_lista_Hipoteses", "o Projeto WASH teve como origem as experiências do Projeto GESAC [XXX], da avaliação do OLPC [XXX] e da Avaliação do PIDs [XXX]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_2_lista_Hipoteses", "o Projeto carrega elementos dos métodos de Seymour Papert, combinando-os com outros, tais como" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_3_lista_Hipoteses", "o Projeto WASH pode ser identificado como \"educação  formal e não-formal" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_4_lista_Hipoteses", "o caráter presencial das oficinas do WASH, declarado no documento de referência, representou uma barreira que resultou em um atraso para a adaptação do projeto às restrições da pandemia, requerendo uma revisão" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_5_lista_Hipoteses", "meios alternativos de realização do projeto (e.g. produção audiovisual, oficinas síncronas e assíncronas) foram a formas encontradas para enfrentar, de forma emergencial, as barreiras indicadas acima" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_6_lista_Hipoteses", "o WASH resultou, ao longo de seus 9 anos de existência, em uma vasta produção de conhecimentos e aprendizados" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Hipoteses_Introducao", "item_7_lista_Hipoteses", "podemos medir  esses aprendizados " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("Introducao", "Problema_Introducao", "Problema" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Problema_Introducao", "paragrafo_67", "O Programa WASH tem 9 anos de existência tendo atendido milhares de crianças em dezenas de cidades brasileiras. Inicialmente desenhado a partir das conclusões da avaliação dos Projetos OLPC, PIDs, recebeu influências das práticas do GESAC. Esses conhecimentos foram consolidados no anexo à Portaria CTI 178/2018, o qual estabelece formalmente seu método de realização, explicitando o caráter presencial do programa. Com a Pandemia a sociedade aprendeu e passou a aceitar melhor o papel de atividades remotas na educação. Muito embora as diretrizes gerais do projeto presentes no anexo à Portaria CTI 178/2018 permaneçam válidas, a nova realidade requer uma adequação de aspectos do programa. Novas práticas foram criadas e precisam ser caracterizadas, para que as melhorias possam ser introduzidas no documento de formalização da metodologia." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("Introducao", "Justificativa_Introducao", "Justificativa" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("Justificativa_Introducao", "paragrafo_68", "A aceitação do método do Projeto WASH pelas instituições de educação, documentado por dezenas de instrumentos legais de adesão (portarias), permite vislumbrar a transformação do projeto em política pública, o que tem estimulado chamar o projeto como \"proto-política, ou seja, política pública em construção. Para que o projeto atinja esse estágio, é preciso fazer uma revisão em seu documento de referência e, para isso, é preciso caracterizá-lo em 3 dimensões: história, método e resultados." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "fundamentacao_teorica", "FUNDAMENTAÇÃO TEÓRICA " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "paragrafo_69_a", "Neste capítulo serão aprofundados aspectos levantados na Introdução." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "historiografia", "Historiografia" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("historiografia", "paragrafo_69_b", "Descrição da evolução do método de historiografia. Alguns parágrafos sobre a evolução do método e como ele chegou nos métodos atuais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "organizacao_de_dados", "Organização de dados: uma visão muito simples do modelo relacional" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("organizacao_de_dados", "paragrafo_69_c", "Mostrar a Hierarquia e relacional" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "sociedade_da_informacao", "Sociedade da Informação" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("sociedade_da_informacao", "paragrafo_70", "Segundo Sérgio Amadeu em [XXX Tudo Sobre Todos], os primórdios da ideia de conhecimento como um recurso econômico fundamental estão relacionados com o trabalho \"The Production and Distribution of Knowledge in the United States [XXX MACHLUP, Fritz. The Production and Distribution of Knowledge in the United States. Princeton, Nova Jersey: Princeton University Press, 1962.], do economista Fritz Machlup, no qual o conceito de Sociedade da Informação teria aparecido pela primeira vez. A construção do conceito pode ter se iniciado na década de 30, quando Machlup estudava o efeito das patentes na pesquisa [XXX buscar fonte primária]. O nascimento do conceito é atribuído, também, a Daniel Bell, professor de Harvard, que a partir do texto \"The Coming of Post Industrial Society [XXX BELL, Daniel. The Coming of Post-industrial Society. Nova York: Basic Books, 1973] teria trazido, segundo Frank Webster [XXX Duff Journal of Information Science, 24(6) 1998, pp. 373-393], \"a teoria mais influente sobre a ‘a sociedade da informação’. No texto, Bell indicava que os serviços e as atividades relacionadas ao fluxo de informações tinham atingido um patamar de geração de empregos maior do que as atividades industriais. Em outras palavras, \"as máquinas reprodutoras da força física e ampliadoras da velocidade estavam perdendo espaço para tecnologias que armazenam, processam e distribuem informações [Sérgio Amadeu, tudo sobre todos]. Para Duff [XXX JIS, 24(6)] ] o emprego de uma metodologia de análise \"reputacional poderia colocar Bell entre os 10 pensadores no topo da elite intelectual americana, em tradução livre, \"ao lado de figuras públicas como m Chomsky, John Kenneth Galbraith and Norman Mailer, não cabe a este texto validar ou refutar estas afirmações, senão registrar que existe um reconhecimento sobre o papel de Bell na literatura. Dentre as contribuições mais notáveis de Bell [XXX Duff] estariam a identificação ta transformação pós-industrial da força de trabalho, o fluxo de informações e a consequente \"explosão da informação e a \"revolução da tecnologia da informação. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("sociedade_da_informacao", "paragrafo_71", "Ainda no intento de identificar as origens do conceito, há que se falar do papel de Manuel Castells, com sua relevante \"A era da informação: economia, sociedade e cultura, de " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("sociedade_da_informacao", "paragrafo_72", "Sérgio Amadeu sintetiza com propriedade uma definição de sociedade da informação: " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("sociedade_da_informacao", "citacao_4", "\"As sociedades informacionais são sociedades pós-industriais que têm a economia fortemente baseada em tecnologias que tratam informações como seu principal produto. Portanto, os grandes valores gerados nessa economia não se originam principalmente na indústria de bens materiais, mas na produção de bens imateriais, aqueles que podem ser transferidos por redes digitais. Também é possível constatar que as sociedades informacionais se estruturam a partir de tecnologias cibernéticas, ou seja, tecnologias de comunicação e de controle, as quais apresentam consequências sociais bem distintas das tecnologias analógicas, tipicamente industriais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "descricao_do_wash", "Descrição do Programa WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("descricao_do_wash", "paragrafo_73", "Aqui vc pode fazer uma resenha rápida das várias publicações que já fizemos. Pode falar da portaria aqui também, como fundamentação teórica… " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "estudo_de_caso", "O que é um Estudo de Caso" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("estudo_de_caso", "paragrafo_74", "Estudo de caso é uma área tal e tal. Aqui vem a colinha… " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "base_pedagogica", "Base pedagógica" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("base_pedagogica", "paragrafo_75", "Lista e discussão de todas as correntes pedagógicas pertinentes" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("base_pedagogica", "paragrafo_76", "Provavelmente vc vai se concentrar no Papert" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "oque_eh_stem", "O que é STEM?" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_77", "Vários autores [XXX Catterall, Heather Gonzalez e  Tahlea Jankoski, Rodger Bybee] indicam a década de 90 do século passado como o início do uso estruturado do conceito de Science, Technology, Engineering and Mathematics em currículos escolares, mas o acrônimo para representá-lo teve alterações ao longo dos anos. Segundo post de Tahlea Jankoski em [XXX https://blog.stemscopes.com/stem-a-rebranded-idea-of-the-past], inicialmente o conceito era representado pela sigla SMET, mas a similaridade de pronúncia com a palavra \"smut (que significa obscenidade, em inglês) sugeriu a mudança da sigla para METS e depois para STEM, em 2001 [XXX Tahlea Jankoski e Enciclopedia Brittanica]. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_78", "Autores mencionam a confusão que este termo gera, uma vez que em inglês pode se referir a células tronco, com tronco de árvore ou com o pedestal de um copo de vinho [XXX Rodger Bybee, ]. Para evitar esse tipo de confusão, é possível identificar uma recorrência da forma \"STEM Education nas publicações. Neste trabalho será usada a forma STEM, em maiúsculas, para se fazer referência ao movimento de revisão curricular associado às disciplinas de \"Science, Technology, Engineering and Mathematics.  " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_79", "Os Estados Unidos sempre deram importância para a educação de ciências como política pública. Uma evidência disso pode ser encontrada nas atas da Convenção Constitucional de 1787, a exemplo do que se extrai da \"Notes of Debates in the Federal Convention of 1787 [XXX apud Heather Gonzalez]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "citacao_5", "\"to establish seminaries for the promotion of literature and the arts and the sciences." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_80", "Outra evidência pode ser extraída do primeiro discurso do Estado da União do Presidente George Washington [XXX achar data]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "citacao_6", "\"Nor am I less persuaded that you will agree with me in opinion that there is nothing which can better deserve your patronage than the promotion of science and literature. Knowledge is in every country the surest basis of public happiness. In one in which the measures of government receive their impressions so immediately from the sense of the community as in ours it is proportionably [sic] essential. 2 (First State of Union Address - President George Washington)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_81", "Da mesma forma, observadores [XXX Heather Gonzales] traçam o lançamento do satélite Sputnik, em 1950, como um divisor de águas para o ensino de STEM nos Estados Unidos [XXX Heather Gonzalez]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_82", "O movimento pelo STEM, nos Estados Unidos, tem evidente motivação econômica, estratégica e de manutenção da hegemonia americana. Uma evidência disso é a citação à fala do Presidente da Lockheed Martin, Norm Augustine, em outubro de 2012, presente em [XXX James Catterall - deve ser o pai da LG Catterall]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "citacao_7", "\"... industry and government to promote more STEM education in the U.S. ‘Failure to do so... will undermine the U.S. economy, security and place as a world leader.’ Competing with knowledge-based resources will be one way that the U.S. can recover and retain primacy in the global marketplace (Twittweb, 2012)." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_83", "Mas em termos recentes, foi em meados da década de 90 que o baixo desempenho comparativo em STEM dos estudantes americanos ganhou notoriedade na imprensa, pela constatação de uma sequência de notas medíocres no Programme for International Student Assessment (PISA) [XXX citar Catteral]. O PISA é um exame internacional promovido pela Organização para a Cooperação e Desenvolvimento Econômico (OCDE), que busca estabelecer um padrão global de avaliação, que permita comparar o desempenho de estudantes de diferentes países [XXX citar documento que explique o PISA]. Nos dias de hoje, estudantes de cerca de 65 países participam do exame, que é considerado um instrumento importante para planejar melhorias nos sistemas educacionais ao redor do mundo." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_84", "Em 1998, através de um relatório apresentado ao Congresso Americano pelo Committee on Equal Opportunities in Science and Engineering da National Science Foundation, este importante organismo, que seria o equivalente ao nosso CNPq, alerta para a importância do ensino de STEM nas escolas fundamentais americanas para que os EUA mantenham sua liderança global [XXX https://www.nsf.gov/pubs/2000/ceose991/ceose991.html]:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "citacao_8", "\"In order to maintain its global leadership, America must ensure our citizens can meet the demands of a more scientifically- and technologically-centered world. The National Science Foundation (NSF) has a key role in creating and maintaining the science, mathematics, engineering, and technology (SMET) capacity in this nation. The Committee on Equal Opportunities in Science and Engineering (CEOSE) has been charged by Congress with advising NSF in assuring that all individuals are empowered and enabled to participate fully in the science, mathematics, engineering, and technology (SMET) enterprise." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "citacao"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_85", "Nesse relatório o NSF usa ainda o acrônimo SMET, que em 2001, segundo a enciclopédia Britânica teria sido alterado para STEM [XXX https://www.britannica.com/topic/STEM-education]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_86", "As áreas em que os estudantes americanos não conseguiam se sobressair, em relação aos demais países desenvolvidos, eram as de ciências, tecnologia e matemática [XXX Catterall]. Essa situação passou a representar incômodo para os gestores educacionais do país, dado que não refletia a sua imagem própria de potência internacional [XXX citar Catterall], principalmente no campo da ciência e tecnologia. Foi nesse momento que as iniciativas educacionais em \"science, technology, engineering and mathematics se destacaram e o acrônimo SMET surgiu, posteriormente substituído por STEM [XXX  Catterall]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_87", "Segundo a interpretação da época, o baixo desempenho americano em STEM tinha relação com a falta de equidade no acesso ao STEM, dentro da realidade das escolas americanas [XXX Catterall]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_88", "Dentre as respostas do governo americano se destacaram o programa \"Nenhuma Criança Deixada para Trás, em tradução livre de \"No Child Left Behind Act, uma iniciativa de 2002, e o \"Todo Estudante terá Sucesso, em tradução livre de \"Every Student Succeeds, de 2015 [XXX Catterall]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("oque_eh_stem", "paragrafo_89", "Mas as respostas americanas não ficaram restritas às esferas de governo, havendo também as que foram conduzidas por organizações não-governamentais [XXX], universidades[XXX], think-tanks, entre outras [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("fundamentacao_teorica", "governo_eletronico", "Governo Eletrônico" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_90", "Foi no século XIX que os primeiros conceitos de programação começaram a ser desenvolvidos. O mecânico francês Joseph-Marie Jacquard (1752-1854) inventou o primeiro tear automatizado, utilizando a inovação dos cartões perfurados. Outros contribuintes foram Charles Baggage (1791-1871) e Ada Lovelace (1815-1852), com o desenvolvimento do conceito de máquina analítica, embora a máquina, propriamente dita, não tenha sido efetivamente construída. No entanto, mesmo assim, seus esforços são considerados basilares para o desenvolvimento dos primeiros computadores. Ada Lovelace foi considerada a primeira pessoa efetivamente a se valer do conceito de programação na História. Interessante observar que essas iniciativas do século XIX surgiram como demandas de um mecânico e um banqueiro [XXX quem são?] que buscavam resolver questões práticas." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_91", "O empresário norte americano Herman Hollerith (1860-1929) desenvolveu um sistema capaz de computar dados. Seu desenvolvimento se deu no contexto de uma demanda de Governo. Desde 1880, o governo americano fazia o censo demográfico e demorava 8 anos para contabilizar os dados. Hollerith criou uma máquina capaz de computar as informações coletadas durante o censo de 1890 [XXX], também a partir de cartões perfurados, diminuindo assim o tempo de cálculo para apenas dois anos e meio. Esse exemplo talvez seja uma das primeiras formas de emprego de uma tecnologia digital primitiva numa atividade de governo. Mas não era uma tecnologia voltada para disponibilizar serviços diretamente para o cidadão, um conceito que veio a se concretizar muitas décadas depois." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_92", "A partir desta iniciativa, Hollerith vendeu suas máquinas para governos e empresas, tendo sido, também, um dos fundadores da IBM, hoje uma das maiores empresas de computação do mundo [XXX]. Dentre os serviços prestados pela IBM está o apoio ao Holocausto nazista contra judeus e outras minorias, durante o Terceiro Reich Alemão [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_93", "Atualmente os computadores são ferramentas indispensáveis para o desenvolvimento do mundo e funcionamento das sociedades modernas, bem como do conhecimento científico. Em suma, a história da computação e das máquinas remonta a tempos antigos, que vão desde as ferramentas de cálculo, passando pela revolução industrial e suas tentativas de se criar computadores mecânicos, os computadores eletrônicos analógicos [trabalho de Vannevar Bush XXX], até chegar à forma dos computadores eletrônicos digitais conhecidas hoje." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_94", "Como se vê pela história, o uso de tecnologias da informação e comunicação pelos governos é tão antigo quanto a própria existência da computação." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_95", "No Brasil, a utilização da tecnologia da informação na administração pública teve início na década de 1960 pelas empresas estatais [XXX livro da vera dantas]. Naquele tempo os engenheiros brasileiros formados na área tinham duas perspectivas: trabalhar no governo ou nas estatais, comprando equipamentos, ou nas multinacionais, vendendo equipamentos para o Governo [XXX frase da época]. Isto se dava porque o Brasil não tinha uma cultura de desenvolvimento no mundo digital e esse tipo de atividade era desestimulada pelas potências estrangeiras. Um esforço muito grande foi instituído no país, principalmente a partir da década de 60, para reverter essa situação [XXX]. Esse esforço permitiu a gênese de uma comunidade de profissionais, estabelecendo as bases para a constituição de uma \"cultura digital que veio a se expressar mais amplamente a partir da década de 90 [XXX citar coisas de cultura digital aqui]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_96", "As pressões internacionais por um estado \"gerencial e empreendedor, intensificaram o movimento conhecido por reforma da gestão pública (Bresser-Pereira, 2002) ou new public management (Ferlie etal., 1996). Este movimento teve como cerne a \"busca da excelência e a orientação aos serviços ao cidadão." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_97", "Nos primórdios do emprego de tecnologias digitais em atividades de governo, a menção a \"IT in Government (\"Tecnologia da Informação no Governo, em tradução livre) se referia exclusivamente ao uso da tecnologia no interior dos governos. Portanto não era uma tecnologia voltada para disponibilizar serviços diretamente para o cidadão ." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_98", "Assim, com essa visão gerencial, em sua gênese o conceito de governo eletrônico buscava tratar o indivíduo mais como \"cliente, ou como \"pagador de impostos [resenha acima], do que necessariamente um cidadão com direitos civis." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_99", "Em que pese esse início bastante vinculado às controversas ideologias da época, em particular à noção de \"empreendedorismo de Estado, há que se reconhecer que tais iniciativas prepararam a sociedade para as transformações tecnológicas vindouras, que alteraram a relação do Estado com seus cidadãos." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_100", "A ideia de governo eletrônico difere-se de um simples uso de \"IT in Government, porque trata do acesso direto ao governo por meios digitais pelo próprio cidadão, sem intermediários. Portanto, só se tornou viável a partir da disseminação em grande escala das tecnologias de informação e comunicação." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_101", "É comum atribuírem ao advento do WebBrowser [XXX referencias sobre o Mosaic], ou seja, ao próprio advento da internet como se conhece hoje, o pioneirismo para a disseminação das tecnologias digitais." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_102", "Mas, por justiça histórica, é preciso reconhecer que antes mesmo desse marco, já existia na França uma tecnologia que oferecia serviços de todo tipo para os cidadãos: o MINITEL [XXX], que no Brasil era conhecido como Vídeo Texto. Muito antes do HTML, em meados da década de 80, o MINITEL e suas versões locais (Suécia, Irlanda, África do Sul, Canadá, Brasil, etc)[XXX} já eram extensivamente usadas. Na cidade de São Paulo o vídeo texto da Telesp chegou a ter cerca de 70 mil assinantes [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_103", "O Judiciário brasileiro inaugurou os serviços digitais para atendimento ao cidadão, já no início da década de noventa. Este pioneirismo se deu com o uso de códigos de barra para identificação de eleitores, por exemplo. Aliás, muito antes das ações do executivo, houve o desenvolvimento da Urna Eletrônica, uma iniciativa totalmente estatal, com a participação de unidades de pesquisa federais (CTI em 1990 e INPE em 1994). As ações do executivo brasileiro em direção ao governo eletrônico remontam ao início da década de 90, sempre com a participação do SERPRO [precisa de referência XXX]. Pode-se considerar que o programa de imposto de renda oferecido pela receita federal a partir de 1991 foi uma das primeiras ações em grande escala do executivo no sentido de oferta de serviços digitais diretos para o cidadão, mesmo considerando que o envio dos dados da declaração por internet só foi viabilizado a partir de 1998. No início, era preciso enviar os disquetes da declaração juntamente com a documentação em papel." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_104", "O movimento em direção ao governo eletrônico ganhou mais institucionalidade a partir do final do governo FHC, principalmente com a atuação de Pedro Parente à frente da Casa Civil [Diniz, Barbosa, etc]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_105", "[YYY rever essa frase]O Brasil e o México, segundo J.Ramon Gil Garcia e Beatriz B. Lanza)Digital Governo Brasil, México e EUA formalizaram o governo digital 2000, com foco em infraestrutura da internet e serviços e processos enquanto EUA." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_106", "[YYY esta frase está fora de lugar] A questão da infraestrutura no Brasil é relevante pois x da população permanece sem acesso a internet ( CGI.br, INEGI,2015 de atualizar esse dado)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_107", "O Governo Digital no Brasil foi formalizado por Decreto Presidencial de 3 abril de 2000, cuja implementação se deu sob a coordenação política da Presidência da República, com apoio técnico e gerencial da Secretaria de Logística e Tecnologia da Informação (SLTI), do Ministério do Planejamento, Orçamento e Gestão. Essa atuação foi sustentada por um comitê integrado pelos secretários executivos (e cargos equivalentes) dos ministérios e órgãos da Presidência da República, denominado Comitê Executivo de Governo Eletrônico (Cege)." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_108", "Inicialmente o governo brasileiro concentrou esforços em três linhas de ação do Programa Sociedade da Informação [YYY tem que explicar que programa é esse]: universalização de serviços, governo ao alcance de todos e infraestrutura avançada [por enquanto, coloque as citações com colchetes ao invés de parênteses, para não confundir com parênteses que naturalmente acontecem no texto, colocar XXX para não perder a citação depois] ( XXX Comitê Executivo E-gov, 2002)." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_109", "Essa ação vinha no bojo do movimento em prol da modernização da administração pública, já mencionada, e da prestação de serviços para a população, com um viés de busca pela \"qualidade em processos e serviços [XXX Tecnologia Industrial Básica TIB], um conceito que hoje parece corriqueiro, mas que era objeto de frisson naquela época [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_110", "Embora as iniciativas do Governo FHC fossem exclusivamente acessíveis a uma elite de cidadãos, uma vez que a maior parte da população não tinha acesso à internet [XXX CGI.br, INEGI,2015 de atualizar esse dado], sem o apontamento de soluções sistêmicas para sua universalização, funcionaram para abrir o caminho institucional do Governo Eletrônico." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_111", "Um novo paradigma cultural de inclusão social e digital para cidadãos, se fazia necessário, mas esta diretriz não estava presente na fase pioneira de implantação do governo eletrônico no Brasil. Inicialmente, tratando os cidadãos como clientes, o foco era a redução de custos unitários, melhorias na gestão e qualidade dos serviços públicos, transparência governamental e simplificação de procedimentos, formalizados como estratégias, macro-objetivos e  as metas prioritárias  do governo brasileiro para o período de 2000 a 2003." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_112", "[YYY frase perdida no meio do texto… mudança para primeira pessoa do plural] Fizemos um breve levantamento com apoio da metodologia historiográfica na  perspectiva histórica e de pesquisa em administração pública, (XXX Peranti,Octavio,2022) [YYY coloca entre colchetes nesta fase de elaboração do texto. quando estiver tudo pronto, muda para o formato ABNT]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_113", "A consolidação de uma cadeia produtiva completa e eficiente, e que usufruía de mão-de-obra barata na Ásia [XXX], contribuiu para a redução de barreiras econômicas para acesso a dispositivos digitais, uma vez que houve ampla comoditização da produção de eletroeletrônicos em geral e dos bens de computação em particular [XXX]. Uma decorrência direta da Lei de Moore [XXX], o mundo passou a produzir mais transistores eletrônicos do que grãos de soja [XXX], com ganhos de escala que tornaram essas tecnologias mais disponíveis." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_114", "Essa alta disponibilidade de equipamentos digitais, a baixo custo, facilitou uma presença cada vez maior da internet na vida das pessoas, principalmente a partir da popularização dos celulares do tipo \"smart-phone." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_115", "Esta transformação estimulou os governos [XXX] a enfrentarem as dificuldades  de falta de  capacitação dos cidadãos na apropriação tecnológica, de forma que pudessem usufruir melhor da abundância e acesso aos equipamentos digitais. Para isso, estabeleceram políticas públicas que os preparassem para usufruírem do direito humano à comunicação [XXX citar a constituição]. Os governos passaram a se preocupar com a inserção efetiva de seus cidadãos na sociedade da informação [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_116", "Essas iniciativas ficaram conhecidas, genericamente, como programas pertinentes a politicas de \"inclusão digital, ou  de \"cultura digital ou mesmo de \"alfabetização tecnológica [XXX]. Independentemente da abordagem escolhida, dentre as três indicadas, essas políticas sempre estiveram vinculadas às estruturas de educação, seja a formal, ou a não-formal [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_117", "Diferentes iniciativas e perspectivas foram implementadas para uso das tecnologias da informação e comunicação no Brasil.Foram disponibilizados equipamentos, aplicativos, softwares,hardwares, para processar, armazenar, comunicar, prover apropriação tecnológica, o acesso a  informação, ao conhecimento como ação de politica de inclusão digital." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_118", "Algumas ações consideravam o cidadão como usuário de serviços e, para que tivesse acesso a eles, uma capacitação em domínio de mouse e teclado [XXX], por exemplo, era oferecida." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_119", "Um passo a frente, havia as capacitações direcionadas à interação com serviços específicos, a exemplo de ________ [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_120", "Também existiam as capacitações voltadas para a utilizações de pacotes de aplicativos, a exemplo dos pacotes de escritório [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_121", "Outras capacitações focalizavam a autonomia no estabelecimento de serviços locais para o atendimento dos demais cidadãos. Um exemplo eram os cursos em montagem e configuração de redes de computadores [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_122", "Eram comuns, também, as capacitações voltadas para a autoria na área de cultura, as quais visavam a autonomia dos movimentos culturais na produção de seus próprios produtos, sem a dependência de gravadoras ou outras estruturas voltadas para modelos de negócio comerciais [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_123", "Uma abordagem mais ampla, envolvendo a elaboração de saberes e competências no campo da computação, envolvia a prática da programação de jogos de computadores, a exemplo das que foram desenvolvidas no WASH [XXX]" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_124", "Para garantir a objetividade da análise no contexto desta dissertação, há que se concentrar nos aspectos pertinentes ao objeto de estudo, i.e. o Projeto WASH. Esta restrição exige focalizar a relação entre as tecnologias digitais e a educação formal e não-formal, abordagens adotadas pelo projeto Workshop Aficionados por Software e Hardware-WASH, como se verá mais adiante." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_125", "Assim, no espírito de manter a objetividade, e por sua relação direta na gênese do Projeto WASH, optou-se por focalizar a política pública \"Governo Eletrônico de Serviços de Atendimento ao Cidadão-GESAC, programa do  Ministério das Comunicações, cujo o formato de interesse para este trabalho é o que se consolidou a partir de 2003." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_126", "A presente candidata teve um papel na construção e execução de políticas públicas com as características acima, inicialmente no âmbito do Governo Eletrônico, passando pelas áreas de comunicação, saúde, cultura, e culminando na área de ciência e tecnologia. Estas laborações  se deram em vários momentos de sua carreira, ao longo de quase 3 décadas. Isso a tornou uma testemunha ocular dos fatos a elas relacionados, inicialmente no  município de Campinas, na década de 90, e, em seguida, no âmbito do Governo Federal, nas primeiras duas décadas do presente século." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_127", "32- Nessa trajetória foi possível aprender sobre as vantagens e desvantagens de cada uma das abordagens adotadas, bem como sobre a forma de combinar os elementos presentes de (I) até (VI)." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_128", "33- A partir de uma prática regular e frequente de oficinas de formação para  crianças e adolescentes, que se iniciou em setembro de 2013 no Centro de Tecnologia da Informação CTI- Renato Archer em Campinas, esse aprendizado se consolidou em um método do qual a candidata é co-autora, conhecido como WASH (Workshop de Aficionados em Software e Hardware)." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_129", "34 Após um longo período de maturação, ajustes e repetição, esse método veio a ser formalizado em 2018 por meio de portaria de uma unidade de pesquisa do Ministério da Ciência, Tecnologia e Inovações [XXX Portaria 178/2018 SEI/CTI. A descrição detalhada do método consta como anexo da referida portaria, a qual sintetiza os aprendizados conquistados ao longo dos anos, pelos vários participantes do programa. De 2018 para cá, mais aprendizados ocorreram, havendo uma necessidade de aprimoramento de sua descrição." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("governo_eletronico", "paragrafo_130", "35-É justamente uma análise sobre esse método que a presente dissertação intenciona oferecer, complementada por uma proposta de melhoria, na forma de produto tecnológico, como parte dos requisitos para obtenção do título de mestre no âmbito do mestrado profissional em ensino de ciências humanas, sociais e da natureza da Universidade  Tecnológico  Federal do Paraná - UTFPR- Campus Londrina/PR." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "materiais_e_metodos", "MATERIAIS E MÉTODOS" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "paragrafo_149", "Neste trabalho utilizaremos o método de Estudo de Caso para identificar as características do WASH tal tal e tal. Como o Estudo de Caso visa caracterizar o Projeto WASH em três dimensões (História, Método e Resultados) foi preciso empregar métodos de 3 áreas do conhecimento, a saber: pedagogia, historiografia e modelagem e análise de dados. " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "paragrafo_150", "DESCREVER A minha forma de fazer estudo de caso… (a colinha já foi na fundamentação teórica - aqui eu vou citar a colinha da fundamentação teórica)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "paragrafo_151", "Identificação das características gerais do Projeto" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "paragrafo_152", "Para identificar as características do Projeto o método de pesquisa utilizou-se fundamentalmente do documento de referência da Portaria 178." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "paragrafo_153", "Como eu faço para saber se o programa é alfabetização digital, alfabetização científica, popularização da ciência ou educação formal-informal-não-formal." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "MM_historiografia", "Método de Historiografia Utilizado " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("MM_historiografia", "paragrafo_154", "Para estabelecer a história do WASH foi preciso fazer um levantamento de documentação da história do GESAC, do OLPC, et da blablabla" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("materiais_e_metodos", "MM_estruturacao_e_analise_de_dados", "Método de Estruturação e análise dos dados" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("MM_estruturacao_e_analise_de_dados", "paragrafo_155", "Para que fosse possível fazer a estruturação dos dados foi preciso criar uma plataforma, um modelo de dados, etc…" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));

call insere_a_direita_dos_filhos("materiais_e_metodos", "MM_determinacao_do_genero", "Método de determinação do gênero dos participantes" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));

call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_0", "A questão de armazenagem de dados de gênero no WASH ainda não está devidamente equacionada e esta situação tem a ver com a forma como os dados eram armazenados no início do projeto.", "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));


call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_1", "É possível identificar vários momentos na forma como o WASH armazenou seus dados ao longo de 9 anos. Logo no início do projeto, os dados de participantes eram coletados por meio de listas de presença, nas quais constavam inicialmente apenas o nome e a data do evento. Posteriormente novos dados foram sendo coletados, como o ano do nascimento da criança. Sempre houve uma visão minimalista no sentido dos dados que deveriam ser coletados, dado que tal coleta se dava no contexto do serviço público e não havia um mandato para coleta de dados cadastrais mais detalhados. Buscou-se sempre restringir a coleta de dados para os propósitos do projeto, a saber: contabilizar o número de participantes, evitar a contabilização dupla de participantes, identificar os responsáveis, registrar autorizações de uso de imagens, etc.", "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_3", "Assim, desde o início do projeto não havia a armazenagem do gênero de seus participantes.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_5", "Com o crescimento do projeto, começou a existir uma preocupação sobre se o projeto era inclusivo, em termos de atendimento equânime dos vários perfis de gênero. Mas no momento em que essa deficiência de registro foi diagnosticada, o projeto já contava com milhares de participações. Isso exigiu a adoção de algum método para tentar verificar se o atendimento era suficientemente equânime, mesmo sem existirem registros cadastrais que indicassem o gênero dos participantes.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_7", "Criou-se um método em que os indicadores de gênero do WASH são construídos a partir de uma avaliação a posteriori dos primeiros nomes dos participantes, que são comparados com listas de nomes masculinos e de nomes femininos. Evidente que esta abordagem traz imprecisões pela própria imprecisão do conceito de nomes masculinos e nomes femininos. O método não leva em conta a autodeclaração de gênero dos indivíduos participantes, simplesmente porque não foi solicitado aos participantes que se identificassem em termos de gênero. Esse cuidado tem uma lógica: o WASH não é uma escola e não tem a obrigação, ou o direito, de fazer cadastros de participantes. Do ponto de vista do WASH não há interesse em rotular peremptoriamente as pessoas como desse ou daquele gênero. Como o nome dos participantes é auto-declaratório e não são solicitados documentos de registro civil (RG ou certidão de nascimento), o respeito à imagem que o participante faz de si mesmo é garantido, porque suas declarações não são questionadas e não precisam ser verificadas com relação a algum documento civil. Assim, se um participante optar por se identificar com um nome social, isso será respeitado. Se o participante optar por se identificar com o nome civil, isso também será respeitado.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_9", "Dito isso, e reconhecida a deficiência associada à falta de coleta de dados auto-declaratórios de gênero, é preciso criar uma solução que represente da melhor forma possível a distribuição de gênero dos atendidos. Optou-se por um método que permitisse identificar desvios (vícios ou tendências), de atendimento de um determinado gênero em detrimento do outro. Em outras palavras, sabe-se que a presença masculina em atividades STEAM é mais oportunizada, desprivilegiando a presença feminina. Portanto, ao WASH era preciso verificar, da melhor forma possível, se esse tipo de preconceito estava sendo reproduzido dentro do programa.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_11", "Foi a partir dessa necessidade, que o problema foi resolvido parcialmente, pela opção de usar o primeiro nome, comparado com listas dos ditos nomes masculinos/femininos, para determinar o gênero dos participantes.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_13", "Os dados apresentados, pelo menos ao que se refere a masculino e feminino, mostram que estes vícios e tendências não estão presentes no projeto, havendo um relativo equilíbrio entre o atendimento a homens e mulheres. Infelizmente, o método utilizado não permite identificar a qualidade do atendimento do projeto junto à comunidade LGBTQI+, porque, como já dito, esses dados não foram coletados ao longo de sua história.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("MM_determinacao_do_genero", "paragrafo_155_15", "Do ponto de vista legal, o preparo do projeto para armazenar dados de gênero esbarra na falta de atribuição legal para armazenagem de cadastro de pessoas, o que poderia ser resolvido pela delegação por autoridade superior por meio de portaria.", "", (select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));


call insere_a_direita_dos_filhos("corpo_tese", "resultados_e_discussoes", "RESULTADOS E DISCUSSÕES" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_156", "trabalho sobre iniciação  cientifica e extensão para educação básica, resultou no encontro das redes de ensino  e no fazer a aprendizagem e  a educação tecnológica   a partir das séries iniciais" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_157", "a iniciação cientifica" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_158", "a prática de educação cientifica" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_159", "participantes" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_160", " caracterização do publico" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_161", "faixa etarea" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_162", "alunos" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_163", "orientadores" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_164", "professores" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_165", "instituições" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_166", "Locus pedagógico e Método do WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_167", " Aplicando o metodo descobrimos que o WASH é um programa de educação não formal, tal tal tal." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_168", "Ele se caracteriza por ser um método que tais características (descreve o método do WASH)" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_169", "Trajetória do WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_170", "Aplicando o método do WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_171", "Resultados do WASH" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("resultados_e_discussoes", "paragrafo_172", "Para que fosse possível fazer a estruturação dos dados foi preciso criar uma plataforma, um modelo de dados, etc…" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "conclusoes", "CONCLUSÕES" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("conclusoes", "paragrafo_173", "Aqui vão as conclusões." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("corpo_tese", "referencia", "REFERÊNCIAS" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "referencia"));
call insere_a_direita_dos_filhos("referencia", "referencia_1", "[1] Pierry Levy, Cibercultura. 2 ed. Editora 34,  Rio de Janeiro:, 2000.p. 14 e 15." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_de_referencia"));
call insere_a_direita_dos_filhos("referencia", "referencia_2", "[2] Guerrilha Tecnológica]," , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_de_referencia"));
call insere_a_direita_dos_filhos("referencia", "referencia_3", "[3] Social Transformation in an Information Society: Rethinking Access to You and the World, UNESCO 2004] [XXX ILO] Society: Rethinking Access to You and the World, " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_de_referencia"));
call insere_a_direita_dos_filhos("referencia", "referencia_4", "[4]  Yuval, Harari, 21 Lições para o século 21, Companhia das Letras," , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_de_referencia"));
call insere_a_direita_dos_filhos("corpo_tese", "lixeira", "Lixeira" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "topico"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_131", "o estudo sobre a  bases históricas de politicas públicas em inclusão digital que antecederam ao WASH e" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_132", "Primeiro capitulo" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_133", "a trajetória e da consolidação do Projeto Workshop Aficionados em Software e Hardware-WASH ao longo dos anos de 2013 a 2021." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_134", "36- A metodologia do WASH contou com a contribuição ativa desta candidata, tanto na definição de suas bases conceituais, como na sua formalização, documentação, execução,  avaliação, produção de políticas públicas e de  indicadores." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_135", "37- Portanto, pela forma como foi construído o WASH, não seria possível abdicar do conjunto de conhecimentos estabelecidos pela candidata anteriormente a 2013, os quais fazem parte da contribuição e  para a consolidação do Projeto WASH.  " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_136", "38- Em outras palavras, esta dissertação não poderia deixar de \"beber na fonte dessa experiência profissional, traçando um paralelo com outras experiências e buscando, como meta, a solidificação desses conhecimentos pela identificação de referências de outros autores relacionados ao que a candidata vivenciou, visando uma narrativa impessoal e objetiva." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_137", "39- Assim, seja pela experiência da candidata anterior ao WASH, pelas ações e programas do governo federal,  seja pela experiência durante o WASH, há como construir um diálogo especialmente rico entre o conhecimento pré-existente na literatura e aquele vivenciado na prática pela candidata." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_138", "40- Nesse trabalho, a candidata optou por buscar as raízes da análise no conjunto de políticas públicas federais  de inclusão digital que antecederam o Projeto WASH, a exemplo do:" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "item_1_lista_reciclagem", "(i) Programa GESAC - Governo Eletrônico de Serviço ao Cidadão- Ministério das Comunicações;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lixeira", "item_2_lista_reciclagem", "(ii)  Territórios da Cidadania - Atenção Básica no Ministério da Saúde;" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lixeira", "item_3_lista_reciclagem", "(iii) Pontos de  Cultura e" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lixeira", "item_4_lista_reciclagem", "(iv) Projeto WASH-  OLPC e UCA [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "item_lista_num"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_139", "41- Dentre os  programas citados, tiveram participação ativa da candidata o Programa GESAC (i), quando atuou como Coordenadora  Nacional de Relacionamentos com as Comunidades, do Ministério das Comunicações. O Programa Territórios da Cidadania lançado em 2008, foi  uma ação interministerial do governo federal que envolveu 19 politicas publicas de inclusão social. Representou um esforço conjunto entre os vários ministérios, governadores, prefeitos, sociedade civil que realizaram um mapeamento dos 120   territórios rurais, com baixo índice de IDH, com o objetivo de superar a pobreza e gerar trabalho e renda, com politicas publicas de inclusão social. Foi . Neste  trabalho atuou como Assessora Executiva da Diretoria de Atenção Básica do Ministério da Saúde- DAB/MS. A ação do MS nos Territórios da Cidadania, atendeu  a Estratégia da Saúde da Familia.  " , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_140", "Coordenadora Nacional de Cultura e Cidadania no Ministério da Cultura,   _________ [XXX], (ii), quando atuou como _________ [XXX], (iii) quando atuou como implementadora e gestora do Projeto WASH 2003 a 2021." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_141", "A execução baseada em parcerias, é uma ação do WASH para grande passo para" , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_142", "18-  Assim, optou-se nesta dissertação por construir uma linha mestra de narrativa que nasce na experiência da candidata com o GESAC, em 2003, passa pela experiência com ______ em XXX e tal tal tal." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_143", " 19-Além da literatura consolidada, esta dissertação oferecerá, de forma sucinta mas em caráter inédito, os documentos coletados pela candidata ao longo da carreira, exclusivamente os que sejam relacionados com a construção de suas opções no estabelecimento da metodologia descrita na Portaria 178 [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_144", "20- Assim, usando uma combinação de seu acervo pessoal, acumulado durante décadas, espera-se traçar as bases do Programa WASH." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_145", "21-  O acervo próprio, pregresso ao Projeto WASH, é constituído de documentos, anotações, diários, registros de vivências, vídeos, fotos, publicações, registros na imprensa, panfletos e convites, os quais vêm sendo acumulados com cuidado, memória e sensibilidade. Visto a posteriore, evidencia-se o contexto em que tal acervo se construiu: trabalho, luta e busca por relações sociais mais justas. O acervo posterior ao início do projeto WASH é constituído pelas portarias, publicações, fotos, vídeos, site, editais, wiki e pelos registros da Plataforma Platuóxe, um sistema informático especialmente desenvolvido para produção de indicadores do Programa [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_146", "22- Entretanto, não obstante o histórico de formação desse acervo, a candidata tem consciência de que, numa análise retrospectiva de cunho acadêmico, há que se distanciar do objeto de estudo, sem paixões e perseguindo uma neutralidade, que, há bem da verdade, pode ser vista como um alvo, mas também como uma miragem no universo da ciência. [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_147", "23- (repetido ?)Assim, o uso de um acervo pessoal para o registro dessa trajetória será empregado neste trabalho como um complemento ao levantamento bibliográfico convencional, uma vez que, se fosse baseado exclusivamente no acervo da candidata, o trabalho aqui apresentado poderia perder o caráter impessoal e erudito que é imprescindível à construção do conhecimento acadêmico." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_148_a", "-24(repetido ?) Portanto, optou-s por embasar, fundamentalmente, em referências bibliográficas consolidadas, estabelecendo uma visão distanciada e impessoal sobre o desencadeamento dos fatos que levaram à consolidação do Projeto WASH." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));
call insere_a_direita_dos_filhos("lixeira", "paragrafo_148_b", "Naquele contexto, existiam barreiras importantes para serem superadas como divulgar e estabelecer a apropriação das tecnologias, o uso doméstico, educacional para preparar as pessoas e as instituições para utilizá-las, como também adequá-las para as necessidades da sociedade [XXX]." , "",(select id_chave_nested_tipo_secao from nested_tipos_secoes where nome_nested_tipo_secao = "paragrafo"));



INSERT INTO versoes (id_secao, trecho) SELECT id_chave_categoria, descricao FROM secoes;

call mostra_arvore();
call mostra_arvore_niveis();
call mostra_arvore_niveis_pais();
#call mostra_arvore_niveis_pais_segrega_tipo("paragrafo");

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

