drop table tab_audit_DML;
drop table aluno;
drop TRIGGER TRG_AUDIT_ALUNO;

create table tab_audit_DML(
nom_tabela varchar2(30),
nom_usuario varchar2(30),
dat_evento date,
tip_evento varchar2(30),
new_texto varchar2(30),
old_texto varchar2(30)
);

create table aluno(
    rm number(5),
    nome varchar2(80)
    );
    

CREATE OR REPLACE TRIGGER TRG_AUDIT_ALUNO
BEFORE INSERT OR UPDATE OR DELETE ON aluno
FOR EACH ROW
DECLARE
    V_TEXTO VARCHAR2(100);
    
BEGIN
    IF INSERTING THEN
        INSERT INTO tab_audit_DML 
            VALUES('aluno', USER, SYSDATE, 'INSERT', :NEW.nome, :OLD.nome);
    ELSIF UPDATING THEN
        INSERT INTO tab_audit_DML 
            VALUES('aluno', USER, SYSDATE, 'UPDATE',:NEW.nome, :OLD.nome);
    ELSE 
        INSERT INTO tab_audit_DML 
            VALUES('aluno', USER, SYSDATE, 'DELETE', :NEW.nome, :OLD.nome);
    END IF;
END;
/


INSERT INTO ALUNO (RM, NOME) VALUES (1, 'YASMIN LOPES');

UPDATE ALUNO 
    SET NOME = 'GIOVANA TEIXEIRA'
    WHERE RM= 1;
    
DELETE FROM ALUNO WHERE RM = 1;
    
SELECT * FROM TAB_AUDIT_DML;



