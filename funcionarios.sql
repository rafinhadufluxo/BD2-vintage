CREATE TABLE empregados (
 emp_id int NOT NULL,
 dep_id int DEFAULT NULL,
 supervisor_id int DEFAULT NULL,
 nome varchar(255) DEFAULT NULL,
 salario int DEFAULT NULL,
 PRIMARY KEY (emp_id)
);

CREATE TABLE departamentos (
 dep_id int NOT NULL ,
 nome varchar(255) DEFAULT NULL,
 PRIMARY KEY (dep_id)
);


INSERT INTO empregados (emp_id, dep_id, supervisor_id, nome, salario)
VALUES
 (1,1,0,'Jose','8000'),
	(2,3,5,'Joao','6000'),
	(3,1,1,'Guilherme','5000'),
	(4,1,1,'Maria','9500'),
	(5,2,0,'Pedro','7500'),    
    (6,1,1,'Claudia','10000'),
    (7,4,1,'Ana','12200'),
    (8,2,5,'Luiz','8000');

INSERT INTO departamentos (dep_id, nome)
VALUES
	(1,'TI'),
	(2,'RH'),
	(3,'Vendas'),
	(4,'Marketing');


-- - A soma dos  salários de todos  os funcionário s. 

SELECT SUM(SALFUNC) 
FROM Funcionarios

--// questoes
-- 2)Construir a consulta para listar a soma dos salarios dos subordinados de cada chefe.
SELECT e.emp_id, e.nome, SUM(s.salario) AS soma_salario_subordinados_chefe FROM empregados AS e INNER JOIN empregados AS s ON s.supervisor_id = e.emp_id
GROUP BY e.emp_id, e.nome HAVING SUM(s.salario) > (SELECT AVG(salario) FROM empregados AS c WHERE c.supervisor_id = e.emp_id)

--3) Construir a consulta para listar a quantidade de funcionarios por setor que ganham um salario maior ou igual a média do setor em SQL.
SELECT d.dep_id, d.nome, COUNT(e.emp_id) AS quantidade_funcionarios FROM departamentos AS d INNER JOIN empregados AS e ON e.dep_id = d.dep_id
WHERE e.salario >= (SELECT AVG(salario) FROM empregados AS e WHERE e.dep_id = d.dep_id) GROUP BY d.dep_id, d.nome

--4) Retornar o nome do departamento e a média de salario do departamento que possui entre os demais departamentos a menor media salarial em SQL.

SELECT d.nome, AVG(e.salario) AS media_salarios_departamentos FROM departamentos AS d INNER JOIN empregados AS e ON e.dep_id = d.dep_id
GROUP BY d.nome HAVING AVG(e.salario) = (SELECT MIN(media_salario) FROM (SELECT AVG(e.salario) AS media_salario FROM departamentos AS d INNER JOIN empregados AS e 
ON e.dep_id = d.dep_id GROUP BY d.nome) AS rafa)

--5) O funcionário cadastrado com o menor salário (mostrar o  nome do funcionário, o setor em que trabalha e o valor do  salário)

SELECT e.nome, dep_id FROM empregados e   WHERE salario  = (SELECT MIN(salario) FROM empregados e)

-- 6) Os setores  que possuem mais do que 3  funcionários (mostrar o setor e a quantidade de funcionários). 

SELECT dep_id ,COUNT(*) FROM empregados e  GROUP BY dep_id HAVING COUNT(*) > 1

