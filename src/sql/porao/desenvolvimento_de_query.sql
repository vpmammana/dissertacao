SELECT COUNT(parent.nome_nested_tipo_secao) - 1 as nivel, @nome:=node.nome_nested_tipo_secao AS nome_secao_tipo_secao, node.id_chave_nested_tipo_secao as id_tipo_secao,(select nome_nested_tipo_secao from nested_tipos_secoes where lft < (select lft from nested_tipos_secoes where nome_nested_tipo_secao=@nome) and rgt > (select rgt from nested_tipos_secoes where nome_nested_tipo_secao=@nome) order by lft DESC limit 1) as pai FROM nested_tipos_secoes AS node, nested_tipos_secoes AS parent  WHERE node.lft BETWEEN parent.lft AND parent.rgt GROUP BY node.nome_nested_tipo_secao, node.id_chave_nested_tipo_secao ORDER BY MAX(node.lft);
