--006
--SQL�� ����
--DDL
--(CREATE / ALTER / DROP)
--DML
--(INSERT / SELECT / UPDATE / DELETE) - CRUD
--DCL
--(GRANT/ REVOKE)

CREATE MEMBER(
    ID          VARCHAR2(50),
    PWD         VARCHAR2(50),
    NAME        VARCHAR2(50),
    GENDER      VARCHAR2(50), 
    AGE         NUMBER,
    BIRTHDAY    VARCHAR2(50),
    PHONE       VARCHAR2(50),
    REGDATE     DATE
);

--007
--CHARACTER ���� : CHAR(3), VARCHAR2(3), NCHAR(3), NVARCHAR(3)
--VAR(VARiable) - ���� ���� ������, �ִ밪�� ��������
--N(National) - 1���ڴ� 2 or 3bytes ���, �������� �� ���� ����

CREATE MEMBER(
    ID          VARCHAR2(50),
    PWD         NVARCHAR2(50),
    NAME        NVARCHAR2(50),
    GENDER      NCHAR(2),    -- CHAR(2 CHAR) = 2���� �Է� ����
    AGE         NUMBER(3),
    BIRTHDAY    CHAR(10),   --2000-01-02
    PHONE       CHAR(13),   --010-1234-5678
    REGDATE     DATE
);

select length('ab') from dual;
select length('�ѱ�') from dual;
select lengthb('ab') from dual; --lengthb = length byte
select lengthb('�ѱ�') from dual;

--008
--LONG    -- 2Gb, ���������� �ƴ� Caracter ����, ������ ���� ����̶� �ϳ��� �÷��� LONGŸ���� ����ϸ� �ٸ� �÷��� ����� �� ����
--CLOB    -- 4Gb, ��뷮 ������ Ÿ��
--NCLOB   -- 4Gb, ��뷮 �����ڵ� ������ Ÿ��

--NUMBER(4)   -- �ִ� 4�ڷ� �̷���� ����
--NUMBER(6, 2)    -- �Ҽ��� 2�ڸ��� �����ϴ� �ִ� 6�ڸ� ����
--NUMBER(6, -2)   -- �Ҽ��� -2�ڸ����� �ݿø��ϴ� �ִ� 6�ڸ� ����
--NUMBER  -- NUMBER(38, *)
--NUMBER(*, 5)    -- NUMBER(38, 5)

--DATE        --��-��-��
--TIMESTAMP   --��-��-��-��-��-��


--009
--TABLE COLUMN MODIFY ������ ������ ����, �����ͺ��� ū ũ��θ� ���� ����
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
--TABLE COLUMN DROP
ALTER TABLE MEMBER DROP COLUMN AGE;
--TABLE COLUMN ADD
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
--DDL(���̺��� ���� ����)�� ��ɾ�ٴ� ���� ���


--010
--����Ŭ�� ����� ������ �̹� ���Ǵ� ���� ū����ǥ�� ���μ� ���̺���̳� �÷��� ������ ��� ����
CREATE TABLE NOTICE(
    ID              NUMBER,
    TITLE           NVARCHAR2(100),
    WRITER_ID       NVARCHAR2(50),
    CONTENT         CLOB,
    REGDATE         TIMESTAMP,
    HIT             NUMBER,
    FILES           NVARCHAR2(1000)
);

CREATE TABLE "COMMENT"(
    ID          NUMBER,
    CONTENT     NVARCHAR2(2000),
    REGDATE     TIMESTAMP,
    WRITER_ID   NVARCHAR2(50),
    NOTICE_ID   NUMBER
);

CREATE TABLE ROLE(
    ID              VARCHAR2(50),
    DISCRIPTION     NVARCHAR2(500)
);

CREATE TABLE MEMBER_ROLE(
    MEMBER_ID       NVARCHAR2(50),
    ROLE_ID         VARCHAR2(50)
);


--011
--INSERT INTO [���̺�] VALUES (��� �� ���);
--INSERT INTO [���̺�](�ʵ��) VALUES (�� �ʵ� ��);
-- �������� �ʴ� ���� NULL���� ��

--SELECT * FROM [���̺�];

INSERT INTO MEMBER (ID, PWD) VALUES ('engsk1211', '111');
SELECT * FROM MEMBER;

--SELECT [�ʵ��] FROM [���̺�];
SELECT ID, NAME, PWD FROM MEMBER;

--[�ʵ��] AS [��Ī]   -- �ʵ���� ��Ī���� ���, AS�� ���� ����
SELECT ID AS USER_ID, NAME, PWD FROM MEMBER;
SELECT ID USER_ID, NAME, PWD FROM MEMBER;
SELECT ID "user id", NAME, PWD FROM MEMBER; -- ū����ǥ�� ���� ��Ī�� ��ҹ��ڰ� ���е�ä�� ����


--012
--UPDATE [���̺�] SET [�ʵ��]=[��];
UPDATE MEMBER SET PWD = '222';
SELECT * FROM MEMBER;
--WHERE�� = ������, WHERE [�ʵ��]=[���ǰ�];
UPDATE MEMBER SET PWD = '111' WHERE ID = 'newlec1';
--DELETE [���̺�] WHERE [�ʵ��]=[���ǰ�];
DELETE MEMBER WHERE ID='newlec2';


--013
--Ʈ������̶�? ���� ���� ����, �� ��� ����, ������� ����
-- �������� ����       �������� ��ɾ� ����
-- ������ü              update             1. ���� ������ ���� �ӽ�����ҿ����� �׽�Ʈ
--                      update             2. �� ���� �ٸ� ������ �ǵ帮�� ���ϵ��� LOCK, �Ϸ� �� UNLOCK, COMMIT;
-- �̺�Ʈ �Խñ� ���     insert
--                      update

SELECT ID "user id", NAME, PWD FROM MEMBER;
INSERT INTO MEMBER (ID, PWD) VALUES ('test', '111');
INSERT INTO MEMBER (ID, PWD) VALUES ('dragon', '444');

COMMIT;     -- �ӽ� ������� ������ �����ͺ��̽��� ����
ROLLBACK;   -- �ӽ� ������� ������ �����Ű�� �ʰ� �ǵ���
-- COMMIT�̳� ROLLBACK �� ������ �ش� ���̺��� LOCK ����. COMMIT�̳� ROLLBACK ���� UNLOCK ��


--014
-- ��� ������ +, -, *, /
-- ������ ������ || �����ڸ� ���
-- ������ ���� �÷��� ��Ī�� ���
SELECT HIT+1 "hit" FROM NOTICE;
SELECT 1+'3' FROM DUAL; -- ����Ŭ���� ��������ڴ� ������ ���ڷ� ����
SELECT 1||'3' FROM DUAL;    -- ������ ������ || �����ڸ� ���
SELECT 1 + 'A' FROM DUAL;   -- ����
SELECT NAME || '(' || ID || ')' "NAME(ID)" FROM MEMBER;


--015
-- �� ������ =, !=, ^=, <>, >, <, >=, <=, IS NULL, IS NOT NULL
-- ���� ������ ���ϴ� 3���� ������
-- != : �ٸ� DBMS���� ����ϱ⿡ ǥ���� ��
-- <> : ANSI SQL���� �����ϴ� ������
-- ^= : ����Ŭ���� ����ϴ� ������

SELECT * FROM NOTICE WHERE WRITER_ID = 'newlec';    -- �ۼ��ڰ� newlec�� �� ��ȸ
SELECT * FROM NOTICE WHERE HIT > 3;     -- ��ȸ���� 3���� ū �� ��ȸ
SELECT * FROM NOTICE WHERE CONTENT IS NULL; -- ������ �Է����� ���� �Խñ� ��ȸ
SELECT * FROM NOTICE WHERE CONTENT IS NOT NULL; -- ������ �����ϴ� �Խñ۸� ��ȸ


