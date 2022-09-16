select 
	nome_nested_tipo_secao, 
	(
		select 
			nome_categoria 
		from 
			secoes as s1 
		where 
			s1.lft  < s.lft and 
			s1.rgt > s.rgt
		order by 
			(s1.rgt - s1.lft) ASC limit 1
	) as pai,
	s.lft, 
	s.rgt,
	nome_categoria, 
	nome_versao, 
	substring(trecho,1,40) 
from 
	secoes as s, 
	versoes, 
	nested_tipos_secoes 
where 
	id_tipo_secao = id_chave_nested_tipo_secao and  
	nome_categoria like "auto\_%" and 
	nome_categoria > "auto_2022-09-14" and 
	nome_categoria < "auto_2022-09-14_14" and 
	id_secao = id_chave_categoria order by nome_categoria;
