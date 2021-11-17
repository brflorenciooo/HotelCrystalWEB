
go
use master

go
DROP DATABASE Estudo_Academico



go
create database Estudo_Academico

go
use Estudo_Academico

go
CREATE TABLE Tema (
Id_Tema INTEGER identity PRIMARY KEY not null,
Tema VARCHAR(100) not null
)

go
CREATE TABLE  Nivel (
Id_Nivel INTEGER  identity PRIMARY KEY not null,
Nivel VARCHAR(100)not null
)

go
CREATE TABLE Tipo (
Id_Tipo INTEGER identity PRIMARY KEY not null,
Tipo VARCHAR(100)not null
)

go
CREATE TABLE  Disciplina (
 Id_Disciplina INTEGER identity PRIMARY KEY not null,
 Disciplina VARCHAR(100)not null
)

go
CREATE TABLE  Funcao (
Id_Funcao INTEGER identity PRIMARY KEY not null,
 Funcao VARCHAR(100)not null
)


go
CREATE TABLE  Login_Aluno (
 Id_Aluno INTEGER  identity primary key,
 Login VARCHAR(100) NULL,
 Senha VARCHAR(100)not null,
 Nome VARCHAR(100)not null,
 Email VARCHAR(100)not null,
 Status CHAR(1) not null
)

go
--procedure login aluno
create procedure p_LoginAluno
@Nome VARCHAR(100),
@Email VARCHAR(100)
as
 BEGIN
  DECLARE @nomeLogin VARCHAR(100);

  insert Login_Aluno (Login, Senha, Nome, Email, Status)
  values ('Teste', '123456', @Nome, @Email, 'A')

  set @nomeLogin = 
  (select 
		substring(Nome, 0, (select CHARINDEX(' ', Nome, 0) from Login_Aluno where id_aluno = (select max(id_aluno) from Login_Aluno))) 
																	from Login_Aluno where id_aluno = (select max(id_aluno) from Login_Aluno))
   + '_' +  CAST ((select  max(id_aluno) from Login_Aluno) as varchar(10));

  UPDATE Login_Aluno
  SET Login = @nomeLogin 
  WHERE id_aluno = (select max(id_aluno) from Login_Aluno)
 END
 /*
EXEC p_LoginAluno 'Jos� da Silva', 'jose@teste.com'
*/


go
CREATE TABLE Funcionario (
 Id_Funcionario INTEGER identity PRIMARY KEY not null,
Id_Funcao INT  not null,
 Nome VARCHAR(100)not null,
Email VARCHAR(100)not null,
Area VARCHAR(100)not null,
Cpf CHAR(11)not null,
RG CHAR(9)not null,
 Data_Nasc SMALLDATETIME not null
)


go

create TABLE  Prof_Disc (
 Id_Funcionario INT not null,
 Id_Disciplina INT not null,
FOREIGN KEY( Id_Funcionario) REFERENCES Funcionario (Id_Funcionario),
FOREIGN KEY( Id_Disciplina) REFERENCES  Disciplina (Id_Disciplina)
)


go

CREATE TABLE  Login_Func (
Id_Login_Func integer IDENTITY PRIMARY KEY not null,
login  Varchar(100)not null,
Senha Varchar(100)not null,
 Status CHAR(1)not null,
Nivel_Acesso CHAR(1)not null,
 Id_Funcionario INT,
FOREIGN KEY( Id_Funcionario) REFERENCES Funcionario (Id_Funcionario)
)
--procedure login prof
go

create procedure p_login 
@idFunc varchar(40),
@nome_login varchar(40)
as 
begin
insert into Login_Func(login,Senha,Status,Nivel_Acesso,Id_Funcionario)
values(@nome_login + '_' + @idFunc,'123456','A','P',@idFunc)
end

go
--procedure login coor
create procedure c_login 
@idFunc varchar(40),
@nome_login varchar(40)
as 
begin
insert into Login_Func(login,Senha,Status,Nivel_Acesso,Id_Funcionario)
values(@nome_login + '_' + @idFunc,'123456','A','C',@idFunc)
end

go
--procedure login tecn
create procedure t_login 
@idFunc varchar(40),
@nome_login varchar(40)
as 
begin
insert into Login_Func(login,Senha,Status,Nivel_Acesso,Id_Funcionario)
values(@nome_login + '_' + @idFunc,'123456','A','P',@idFunc)
end

go
--proc prof_disc
create procedure sp_Prof_Disc
@Id varchar(200)
as
begin
	select Disciplina.Id_Disciplina, Disciplina.Disciplina from Disciplina
	inner join Prof_Disc on Disciplina.Id_Disciplina = Prof_Disc.Id_Disciplina
	inner join Funcionario on Funcionario.Id_funcionario = Aula.Id_Funcionario
    Where Funcionario.Id_Funcionario = @Id And Aula.Status = 'A'
end


go
CREATE TABLE  Aula (
 Id_Aula INTEGER identity PRIMARY KEY not null,
 Id_Funcionario INT not null,
 Id_Disciplina INT not null,
Id_Tema INT not null,
Id_Tipo INT not null,
Id_Nivel INT not null,
 Titulo VARCHAR(100)not null,
 Descricao VARCHAR(250)not null,
 Caminho VARCHAR(200) null,
 Data_Publicacao DATETIME not null,
 Qtd_Download int  null,
 Qtd_view INT  null,
 Feedback VARCHAR(100) null,
 Status CHAR(1)not null
)


go

CREATE TABLE  Acesso (
 Id_Aula INT not null ,
 Id_Aluno INT not null,
Comentarios VARCHAR(200)not null,
Qualidade CHAR(1)not null,
 Data_acesso DATETIME not null, 
FOREIGN KEY(Id_Aluno) REFERENCES  Login_Aluno ( Id_Aluno)
)

go


-- VIEW PROF_DISC
Create View [VW_PROF_DISC]
as
Select D.Disciplina[Disciplina], F.Id_Funcionario[Id_Prof] From
Prof_Disc as D, Funcionario as F F.Disciplina as D Where (PD
Id_Funcionario = F.Id_Funcionario) and (D.Id_Disciplina = PD.Id_Disciplina)



--Select Disciplina From VW_PROF_DISC where Id_Prof = 6 
--exemplo


go
ALTER TABLE  Acesso ADD FOREIGN KEY( Id_Aula) REFERENCES  Aula (Id_Aula)
ALTER TABLE  Aula ADD FOREIGN KEY( Id_Funcionario) REFERENCES Funcionario (Id_Funcionario)
ALTER TABLE  Aula ADD FOREIGN KEY( Id_Disciplina) REFERENCES  Disciplina (Id_Disciplina)
ALTER TABLE  Aula ADD FOREIGN KEY(Id_Tema) REFERENCES Tema (Id_Tema)
ALTER TABLE  Aula ADD FOREIGN KEY(Id_Tipo) REFERENCES Tipo (Id_Tipo)
ALTER TABLE  Aula ADD FOREIGN KEY(Id_Nivel) REFERENCES  Nivel (Id_Nivel)
ALTER TABLE Funcionario ADD FOREIGN KEY(Id_Funcao) REFERENCES  Funcao (Id_Funcao)


go
insert into Tema (Tema) values ('Primeira Guerra Munduial')
insert into Tema (Tema)Values ('Governo Vargas')
insert into Tema(Tema)values('trigonometria')
insert into Tema (Tema)values('Romantismo')


go
insert into Nivel(Nivel)values ('B�sico')
insert into Nivel(Nivel)values('Intermedi�rio')
insert into Nivel(Nivel)values('Avan�ado')


go
insert into Tipo(Tipo)values('Documento')
insert into Tipo(Tipo)values('Video-Aula')
insert into Tipo(Tipo)values('Audio')

go
insert into Disciplina(Disciplina)values('Lingua Portugu�s/Literatura')
insert into Disciplina(Disciplina)values('Matematica')
insert into Disciplina(Disciplina)values('Hist�ria')
insert into Disciplina(Disciplina)values('Geografia')
insert into Disciplina(Disciplina)values('Biologia')
insert into Disciplina(Disciplina)values('Quimica')
insert into Disciplina(Disciplina)values('F�sica')
insert into Disciplina(Disciplina)Values('Filosofia')
insert into Disciplina(Disciplina)values('Sociologia')
insert into Disciplina(Disciplina)values('Educa��o F�sica')
Insert into Disciplina(Disciplina)values('Ingl�s')

go
Insert into Funcao(Funcao)values('Professor')
insert into Funcao(Funcao)values('Coordena��o')
insert into Funcao(Funcao)values('T�cnicos')

go
EXEC p_LoginAluno 'Jos� Daniel', 'jose@gmail.com'
EXEC p_LoginAluno 'Bruno Frorencio', 'bruno@gmail.com'
EXEC p_LoginAluno 'Douglas Bueno', 'douglas@gmail.com'

go
insert into Funcionario(Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Erivelton Santos de Oliveira','EriHist@email.com','Historia',85867826880,215148228,'16/06/1985')
insert into Funcionario(Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(3,'Thomas Martins','Otrem@hotmail.com','Tecnico de Informatica',62406768880,436582302,'23/10/1979')
insert into Funcionario(Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(2,'Daniel Cardoso','Daniels@email.com','Pedagogia',01467865800,175804849,'01/02/1983')
insert into Funcionario(Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Cicero Mour�o Sousa','Cicemo@gmail.com','Lingua Portuguesa',77838182859,206379122,'25/08/1969') 
insert into Funcionario(Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Jorge Silva Dias','DiasJ@email.com','Matematica',17985443851,176605356,'30/06/1970')
insert into Funcionario (Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Leandro Aparecido','Lean@Gmail.com','Lingua Portuguesa',15975365428,741963258,'23/09/1975')
insert into Funcionario (Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Leandro Aparecido','Lean@Gmail.com','Ingles',15975365428,741963258,'23/09/1975')
insert into Funcionario (Id_Funcao,Nome,Email,Area,Cpf,RG,Data_Nasc)values(1,'Adriano','Adri@Gmail.com','Ingles',20975365428,741989258,'27/08/1974')

go 
exec p_login 1, 'Erivelton'
exec t_login 2, 'Thomas'
exec c_login 3, 'Daniel'
exec p_login 4, 'Cicero'
exec p_login 5, 'Jorge'
exec p_login 6, 'Leandro'
exec p_login 8, 'Adriano'

go
insert into Aula(Id_Funcionario,Id_Disciplina,Id_Tema,Id_Nivel,Id_Tipo,Titulo,Descricao,Caminho,Data_Publicacao,Qtd_Download,Qtd_view,Feedback,Status)values
(1,3,1,2,1,'Guerra de Trincheiras','Esse Pdf resume como foi e como funciona a guerra de trincheira','Documentos/Aulas1guerra','20/02/2019',200,350,'A aula esta com uma otima explica��o sobre o assunto ','A')
insert into Aula (Id_Funcionario,Id_Disciplina,Id_Tema,Id_Nivel,Id_Tipo,Titulo,Descricao,Caminho,Data_Publicacao,Qtd_Download,Qtd_view,Feedback,Status)values
(4,1,4,1,3,'Romantismo','No audio esta contando um pouco sobre o romantismo','Audio/aulaRoma','20/03/2019',500,600,'Ouvindo assim fica mais facil de aprender ','A')
insert into Aula(Id_Funcionario,Id_Disciplina,Id_Tema,Id_Nivel,Id_Tipo,Titulo,Descricao,Caminho,Data_Publicacao,Qtd_Download,Qtd_view,Feedback,Status)values
(5,2,3,3,2,'Trigonometria','Esta video aula explicarei passo a passo como funciona e darei dicas uteis ','Video/Matemarica','28/02/2019',450,700,'Otimas dicas','A')


go
insert into Acesso(Id_Aula,Id_Aluno,Comentarios,Qualidade,Data_acesso)values(2,1,'O audio estava com uma otima qualidade','5','21/03/2019')
insert into Acesso(Id_Aula,Id_Aluno,Comentarios,Qualidade,Data_acesso)values(3,2,'As dicas ajudaram bastante','4','28/02/2019')
insert into Acesso(Id_Aula,Id_Aluno,Comentarios,Qualidade,Data_acesso)values(1,3,'N�o sabia como funcionava','3','21/02/2019')


go
insert into Prof_Disc(Id_Funcionario,Id_Disciplina)values(1,3)
insert into Prof_Disc(Id_Funcionario,Id_Disciplina)values(4,1)
insert into Prof_Disc(Id_Funcionario,Id_Disciplina)values(5,2)


--app estudo academico
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
go
create table PerguntaQuizMobile
(
	idPerguntaQuiz int identity primary key,
	perguntaQuiz varchar(500) not null,
	dataCriacao date not null,
	idDiscProf int, 
	--	foreign key references Prof_Disc ok,
	imagemQuiz varchar(100), 
	pesoQuest int not null,
	statusPerguntaQuiz char(1) not null
)
	
go
insert PerguntaQuizMobile values ('Qual � a cor do ceu?', getdate(), 1, 'SEM IMAGEM', 1,'A')
insert PerguntaQuizMobile values ('Qual � a cor da grama?', getdate(), 1, 'SEM IMAGEM', 1,'A')
insert PerguntaQuizMobile values ('Qual � a cor da gema do ovo?', getdate(), 1, 'SEM IMAGEM', 1,'A')

go
create table alternativasQuiz
(
	idPerguntaQuiz int foreign key references PerguntaQuizMobile,
	altA varchar(200) not null,
	altB varchar(200) not null,
	altC varchar(200) not null,
	altD varchar(200) not null,
	altCorreta char(1) not null
)
insert alternativasQuiz values (1, 'Azul', 'Verde', 'Roxa', 'Amarela', 'A')
insert alternativasQuiz values (2, 'Azul', 'Verde', 'Roxa', 'Amarela', 'B')
insert alternativasQuiz values (3, 'Azul', 'Verde', 'Roxa', 'Amarela', 'D')

go
create table QuizMobile
(
	idQuiz int identity primary key,
	dataCriacao date not null,
	idDiscProf int, 
	--	foreign key references Prof_Disc,
	statusQuiz char(1) not null
)

go
insert QuizMobile values (getdate(), 10, 'A')

go
create table QuizAlunoMobile
(
	idQuiz int foreign key references QuizMobile,
	idPerguntaQuiz int foreign key references PerguntaQuizMobile
)

go
create table pontuacaoAluno
(
	idPontuacaoAluno int identity primary key,
	id_Aluno int, --foreign key references Login_Aluno_Aluno ok,
	id_Disc int, --foreign key references Disciplina ok,
	saldoPontos decimal(10,2) not null
)

insert pontuacaoAluno values (10, 2, 0)

go
create table HistoricoPontosAluno
(
	idHistoricoPontosAluno int identity primary key,
	idPontuacaoAluno int foreign key references pontuacaoAluno,
	idQuiz int foreign key references QuizMobile,
	quatidadePontos decimal(10,2) not null
)


alter table PerguntaQuizMobile add foreign key (idDiscProf) references Prof_Disc (Id_Prof_Disc)
alter table QuizMobile add foreign key (idDiscProf)references Prof_Disc (Id_Prof_Disc) 
alter table pontuacaoAluno add Foreign key (id_Aluno)references Login_Aluno_Aluno (Id_Login_Aluno)
alter table pontuacaoAluno add foreign key (id_Disc)references Disciplina (Id_Disciplina)




--
select * from  Funcionario


update  aula set Feedback = 0 where Feedback is null

 
alter table aula alter column Feedback varchar(200) null

SELECT * FROM Login_Func

select * from prof_disc

select * from aula

SELECT Disciplina.Id_Disciplina,DISCIPLINA.Disciplina FROM 
Disciplina INNER JOIN Prof_Disc
ON Disciplina.Id_Disciplina = Prof_Disc.Id_Disciplina
INNER JOIN Funcionario
ON Funcionario.Id_Funcionario = Prof_Disc.Id_Funcionario
WHERE Funcionario.Id_Funcionario = 1

SELECT * FROM Disciplina
SELECT * FROM Nivel ORDER BY Nivel

SELECT Disciplina.Id_Disciplina,DISCIPLINA.Disciplina FROM Disciplina INNER JOIN Prof_Disc ON Disciplina.Id_Disciplina = Prof_Disc.Id_Disciplina INNER JOIN Funcionario ON Funcionario.Id_Funcionario = Prof_Disc.Id_Funcionario WHERE Funcionario.Id_Funcionario = 3


SELECT * FROM Aula WHERE Id_aula = 2


SELECT* from aula where Id_Funcionario = 4

select * from Funcionario

select * from aula where Id_Funcionario = 4

SELECT * FROM Aula where Id_Funcionario = 4
select * from Disciplina

select * from Tema  nome where i 

select* from Aula where Id_Funcionario = 4

select*from Aula where Id_Aula = 24


select * from Tema where Id_Tema = 2

select *from Tema where 


select Aula.Id_Aula,Funcionario.Id_Funcionario,Funcionario.Nome,Disciplina.Id_Disciplina,Disciplina.Disciplina, Tema.Id_Tema,Tema.Tema, Tipo.Id_Tipo,Tipo.Tipo, Nivel.Id_Nivel,Nivel.Nivel, Aula.Titulo, Aula.Descricao, Aula.Caminho,Aula.Data_Publicacao,Aula.Qtd_Download,
Aula.Qtd_view ,Aula.Feedback from Disciplina 
inner join Aula on Disciplina.Id_Disciplina = Aula.Id_Aula
inner join Tema on Tema.Id_Tema = Aula.Id_Tema
inner join Tipo on Tipo.Id_Tipo = Aula.Id_Tipo
inner join Nivel on Nivel.Id_Nivel = Aula.Id_Nivel
inner join Funcionario on Funcionario.Id_Funcionario = Aula.Id_Funcionario
where Funcionario.Id_Funcionario = 4  

SELECT Id_Aula,Feedback From Aula where Id_Funcionario = 4





select*from Nivel

SELECT * FROM Nivel ORDER BY Nivel

UPDATE Aula SET Titulo = 'tcc',  Descricao = 'tcc', Caminho = 'tcc',Id_Nivel = 2,id_Tema = 3,id_Tipo = 1  WHERE Id_Aula = 20
SELECT TOP 1 Id_Aula FROM Aula order by Id_Aula desc

select Aula.Id_Aula,Tema.Tema,Tipo.Tipo,Nivel.Nivel, Aula.Titulo,Aula.Data_Publicacao ,Aula.Feedback
 from Disciplina 
inner join Aula on Disciplina.Id_Disciplina = Aula.Id_Aula
inner join Tema on Tema.Id_Tema = Aula.Id_Tema
inner join Tipo on Tipo.Id_Tipo = Aula.Id_Tipo
inner join Nivel on Nivel.Id_Nivel = Aula.Id_Nivel
inner join Funcionario on Funcionario.Id_Funcionario = Aula.Id_Funcionario
where Funcionario.Id_Funcionario = 4 and Aula.Status = 'A' 



UPDATE Aula SET Titulo = '?',  Descricao = '?', Caminho = 't',Id_Nivel = 1, Data_Publicacao = 24/06/2001 ,Id_Tema = 1,Id_Tipo = 1 ,Status='I' WHERE Id_Aula =11


select*from Aula where Id_Aula = 10





select * from Tipo



select Aula.Id_Aula,Funcionario.Nome,Disciplina.Disciplina,Tema.Tema,Tipo.Tipo,Nivel.Nivel, Aula.Titulo, Aula.Descricao, Aula.Caminho,Aula.Data_Publicacao,Aula.Qtd_Download,
Aula.Qtd_view ,Aula.Feedback from Disciplina 
inner join Aula on Disciplina.Id_Disciplina = Aula.Id_Aula
inner join Tema on Tema.Id_Tema = Aula.Id_Tema
inner join Tipo on Tipo.Id_Tipo = Aula.Id_Tipo
inner join Nivel on Nivel.Id_Nivel = Aula.Id_Nivel
inner join Funcionario on Funcionario.Id_Funcionario = Aula.Id_Funcionario and Status ='I'



select*from Funcionario

select Aula.Id_Aula,Funcionario.Id_Funcionario,Funcionario.Nome,Disciplina.Id_Disciplina,Disciplina.Disciplina, Tema.Id_Tema,Tema.Tema, Tipo.Id_Tipo,Tipo.Tipo, Nivel.Id_Nivel,Nivel.Nivel, Aula.Titulo, Aula.Descricao, Aula.Caminho,Aula.Data_Publicacao,Aula.Qtd_Download,
						Aula.Qtd_view ,Aula.Feedback from Disciplina  
						inner join Aula on Disciplina.Id_Disciplina = Aula.Id_Aula
						inner join Tema on Tema.Id_Tema = Aula.Id_Tema 
						inner join Tipo on Tipo.Id_Tipo = Aula.Id_Tipo
						inner join Nivel on Nivel.Id_Nivel = Aula.Id_Nivel
						inner join Funcionario on Funcionario.Id_Funcionario = Aula.Id_Funcionario



UPDATE Aula SET Feedback='tcc'  WHERE Id_Aula =2

select*from Login_Func

SELECT * FROM Login_Func WHERE Login = 'Thomas_2' and Nivel_Acesso ='T'
UPDATE Login_Func SET Login = 'Leandro_4',  Id_Funcionario= Id_login_Func= 4

SELECT * FROM Login_Func WHERE Login  LIKE '%_1' 

select*from aula