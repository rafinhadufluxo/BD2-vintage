-- atividades de funções 
--Conectar: sudo -u postgres psql postgres

create table dados (name varchar(50),  salary float, id int);

INSERT INTO dados(name ,  salary , id ) values ('rafa','1500','1');
INSERT INTO dados(name ,  salary , id ) values ('lucas','1200','2');

---------------------------------------------  questions ----------------------------------------------
-- 1)Crie uma função capaz de incrementar um dado número;

create or replace function teste (id int) 
returns int as $$
declare
 	temp int;
begin
	temp = id + 1;
    return temp;
end;
$$ LANGUAGE plpgsql;
select *from teste(2);

-- 2) Crie uma função capaz de retornar um texto passado por argumento;

create or replace function teste3 (frase varchar) 
returns text as $$
begin

    return frase;
end;
$$ LANGUAGE plpgsql;
select *from teste3('aaaaaaa');

-- 3)Crie uma tabela com a assinatura “usuario (id int, nome varchar(50))”. Após inserir 5 tuplas, faça uma função capaz de retornar os nomes com id maiores que a média;
-- criação de dados
CREATE TABLE  usuario(id int, nome varchar(50));

-- inserir dados do bd usuario
insert into usuario values (16,'rafa');
insert into usuario values (1,'thomas');
insert into usuario values (4,'Pedro');
insert into usuario values (24,'Lukas Ruiz');
insert into usuario values (2,'Isabela');

--verificar a inserção de dados
select * from usuario;

-- aqui e a resposta!
CREATE OR REPLACE FUNCTION retorna_name()
RETURNS table(nome varchar(50))
AS
$$
declare
  media float;
begin
  select avg(id) into media from usuario;
  RETURN query select u.nome from usuario u where id > media;
 end;
$$
Language plpgsql;

select retorna_name();
