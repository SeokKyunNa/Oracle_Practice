--006   create member table
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

--007   oracle data type (char)
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

--008   oracle data type (number, date)
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


--009   alter table
--TABLE COLUMN MODIFY ������ ������ ����, �����ͺ��� ū ũ��θ� ���� ����
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
--TABLE COLUMN DROP
ALTER TABLE MEMBER DROP COLUMN AGE;
--TABLE COLUMN ADD
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
--DDL(���̺��� ���� ����)�� ��ɾ�ٴ� ���� ���


--010   create table
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


--011   manipulate data (insert/select)
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


--012   manipulate data (update/delete)
--UPDATE [���̺�] SET [�ʵ��]=[��];
UPDATE MEMBER SET PWD = '222';
SELECT * FROM MEMBER;
--WHERE�� = ������, WHERE [�ʵ��]=[���ǰ�];
UPDATE MEMBER SET PWD = '111' WHERE ID = 'newlec1';
--DELETE [���̺�] WHERE [�ʵ��]=[���ǰ�];
DELETE MEMBER WHERE ID='newlec2';


--013   trasaction (commit/rollback)
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


--014   arithmetic operator
-- ��� ������ +, -, *, /
-- ������ ������ || �����ڸ� ���
-- ������ ���� �÷��� ��Ī�� ���
SELECT HIT+1 "hit" FROM NOTICE;
SELECT 1+'3' FROM DUAL; -- ����Ŭ���� ��������ڴ� ������ ���ڷ� ����
SELECT 1||'3' FROM DUAL;    -- ������ ������ || �����ڸ� ���
SELECT 1 + 'A' FROM DUAL;   -- ����
SELECT NAME || '(' || ID || ')' "NAME(ID)" FROM MEMBER;


--015   comparison operator
-- �� ������ =, !=, ^=, <>, >, <, >=, <=, IS NULL, IS NOT NULL
-- ���� ������ ���ϴ� 3���� ������
-- != : �ٸ� DBMS���� ����ϱ⿡ ǥ���� ��
-- <> : ANSI SQL���� �����ϴ� ������
-- ^= : ����Ŭ���� ����ϴ� ������

SELECT * FROM NOTICE WHERE WRITER_ID = 'newlec';    -- �ۼ��ڰ� newlec�� �� ��ȸ
SELECT * FROM NOTICE WHERE HIT > 3;     -- ��ȸ���� 3���� ū �� ��ȸ
SELECT * FROM NOTICE WHERE CONTENT IS NULL; -- ������ �Է����� ���� �Խñ� ��ȸ
SELECT * FROM NOTICE WHERE CONTENT IS NOT NULL; -- ������ �����ϴ� �Խñ۸� ��ȸ


--016   relational operator
-- ���� ������ NOT, AND, OR, BETWEEN, IN
SELECT * FROM NOTICE WHERE HIT = 0 OR HIT = 1 OR HIT = 2;   -- ��ȸ���� 0, 1, 2�� �Խñ� ��ȸ
SELECT * FROM NOTICE WHERE 0 <= HIT AND HIT <= 2;   -- ��ȸ���� 0, 1, 2�� �Խñ� ��ȸ
SELECT * FROM NOTICE WHERE HIT BETWEEN 0 AND 2;     -- ��ȸ���� 0, 1, 2�� �Խñ� ��ȸ

SELECT * FROM NOTICE WHERE HIT IN (0, 2, 7);    -- ��ȸ���� 0, 2, 7�� �Խñ� ��ȸ
SELECT * FROM NOTICE WHERE HIT NOT IN (0, 2, 7);    -- ��ȸ���� 0, 2, 7�� �ƴ� �Խñ� ��ȸ


--017   pattern comparison operator
-- ���� �� ������ LIKE, %, _
SELECT * FROM MEMBER WHERE NAME LIKE '��%';  -- '��'�� ���� ���� ȸ�� ��ȸ
SELECT * FROM MEMBER WHERE NAME LIKE '��__'; -- '��'���̰� �̸��� �α����� ȸ�� ��ȸ
SELECT * FROM MEMBER WHERE NAME NOT LIKE '��%';  -- '��'�� ���� ������ ȸ�� ��ȸ
SELECT * FROM MEMBER WHERE NAME LIKE '%��%'; -- �̸��� '��'�ڰ� �� ȸ�� ��ȸ


--018   Regular expression (number)
-- ���� ����Ʈ https://regexlib.com
-- [] ���ȣ �� ĭ�� �� ���ڸ� �ǹ���, �������� ���ڸ� ���� �� ����
-- \d decimal 1���ڸ� �ǹ�
-- {} �߰�ȣ�� �ٷ� ���� ���ڰ� ��� �ݺ��Ǵ��� ����
-- ^ ���Խ��� ����
-- $ ���Խ��� ��
-- ���Խ� ���ǿܿ� �ٸ� ���ڰ� ���Ե� �����͸� ã������ ^ $ ����
-- ���Խ��� [�÷�] LIKE [����]�� �ƴ� REGEXP_LIKE([�÷�], [����]) ���
-- �ڵ��� ��ȣ ����    ^01[016-9]-\d{3,4}-\d{4}$
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '^01[016-9]-\d{3,4}-\d{4}$');
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '01[016-9]-\d{3,4}-\d{4}');


--019   Regular expression (char)
-- \w [a-zA-Z 0-9]�� ����, ������ ������ ��� ����
-- + ���� ���ڰ� �ϳ� �̻� ����
-- * ���� ���ڰ� 0�� �̻� ����
-- | OR�� ����, ���� �� �ϳ��� ���� ��
-- \D [^0-9]�� ����, ���ڰ� �ƴ� ���
-- �̸��� ����   \D\w+@\D\w*.(org|net|com)
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '\D\w+@\D\w*.(org|net|com)');


--020   ROWNUM
-- ROWNUM ��ȸ �� �ڵ����� �����Ǵ� ���� ����
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 1 AND 5;
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 6 AND 10; -- �����Ͱ� ��ȸ���� ����, ROWNUM 1���� WHERE���� ���ǿ� �´� �����Ͱ� ��ȸ�Ǳ� ����.
SELECT ROWNUM, NOTICE.* FROM NOTICE;

-- FROM���� ROWNUM�� ����Ϸ��� ��Ī �ʿ�
SELECT * FROM (SELECT ROWNUM NUM, NOTICE.* FROM NOTICE) WHERE NUM BETWEEN 6 AND 10;


--021   DISTINT, �ߺ����� deduplication
-- ALTER TABLE MEMBER ADD AGE NUMBER;
-- �ϳ��� �÷��� �ߺ����� ������� ���� �� ��� ����
SELECT * FROM MEMBER;
SELECT AGE FROM MEMBER;
SELECT DISTINCT AGE FROM MEMBER;

--022 �߰� ����


--023   string function (1)
-- ���ڿ� ���� �Լ� - SUBSTR(���ڿ�, ������ġ, ����)
-- WHERE ������ �Լ��� ����ϴ� ���� ����, �������� ����ŭ �Լ��� ȣ��Ǿ �ӵ��� ������ ����
SELECT SUBSTR('HELLO', 1, 3) FROM DUAL; -- 1��°���� 3���� ���
SELECT SUBSTR('HELLO', 3) FROM DUAL;    -- 3��°���� ���
SELECT SUBSTRB('HELLO', 3) FROM DUAL;   -- 3��° ����Ʈ���� ���

SELECT NAME FROM MEMBER;
SELECT SUBSTR(NAME, 2) FROM MEMBER;
SELECT SUBSTRB(NAME, 4) FROM MEMBER;

SELECT * FROM MEMBER;
SELECT NAME, SUBSTR(BIRTHDAY, 6, 2) FROM MEMBER;    -- �̸��� �¾ �� ���

SELECT * FROM MEMBER WHERE SUBSTR(PHONE, 1, 3) = '011';  -- ��ȭ��ȣ�� 011�� �����ϴ� ȸ�� ����
SELECT * FROM MEMBER WHERE PHONE LIKE '011%';

SELECT * FROM MEMBER WHERE SUBSTR(BIRTHDAY, 6, 2) IN (07, 08, 09);  -- ������ 7, 8, 9���� ȸ�� ����
SELECT * FROM MEMBER WHERE SUBSTR(BIRTHDAY, 6, 2) NOT IN (07, 08, 09);  -- ������ 7, 8, 9���� �ƴ� ȸ�� ����

SELECT * FROM MEMBER WHERE PHONE IS NULL AND SUBSTR(BIRTHDAY, 6, 2) IN (07, 08, 09);    -- ��ȭ��ȣ�� ��ϵ��� �ʾҰ�, ������ 7, 8, 9���� ȸ�� ����

-- ���ڿ� ���� �Լ� - CONCAT(���ڿ�, ���ڿ�)
-- ���ɸ����δ� �Լ����ٴ� ������ �� ����
SELECT CONCAT(3, '4') FROM DUAL;
SELECT 3||'4' FROM DUAL;

-- ���ڿ� Ʈ�� �Լ�
-- LTRIM(���ڿ�) ���� ���� ����
-- RTRIM(���ڿ�) ������ ���� ����
-- TRIM(���ڿ�) ���� ���� ����
SELECT LTRIM('    HELLO    ') FROM DUAL;
SELECT RTRIM('    HELL0    ') FROM DUAL;
SELECT TRIM('    HELLO    ') FROM DUAL;

-- ���ڿ� �ҹ��� �Ǵ� �빮�ڷ� ����
-- LOWER(���ڿ�) �빮�ڸ� �ҹ��ڷ� ����
-- UPPER(���ڿ�) �ҹ��ڸ� �빮�ڷ� ����
SELECT LOWER('ENGsk') FROM DUAL;
SELECT UPPER('ENGsk') FROM DUAL;

 -- ���ڿ� ġȯ �Լ�
 -- REPLACE(���ڿ�, �ٲ��ڿ�, �ٲܹ��ڿ�) �ٲ��ڿ��� �ش��ϴ� ���ڿ��� �ٲܹ��ڿ��� ġȯ
 -- TRANSLATE(���ڿ�, �ٲ��ڿ�, �ٲܹ��ڿ�) ���� ��ġ�� ���ڳ��� ġȯ
 SELECT REPLACE('WHERE WE ARE', 'WE', 'YOU') FROM DUAL;
 SELECT TRANSLATE('WHERE WE ARE', 'WE', 'YOU') FROM DUAL;
 
 SELECT NAME, REPLACE(EMAIL, ' ', '') FROM MEMBER;  -- �̸��� �ּҸ� ������� ��ȸ
 
 
--024  string function (2)
-- �Լ��� ����
-- ������ �������� �پ��� ������� �� �� ����

-- ���ڿ� �е� �Լ�
-- LPAD(���ڿ�, ����, ä�﹮��) ���ڿ��� ������ ���̸�ŭ ä�﹮�ڷ� ä��
-- RPAD(���ڿ�, ����, ä�﹮��) ���ڿ��� �������� ���̸�ŭ ä�﹮�ڷ� ä��
-- ä�﹮�ڰ� ������ �������� ä��
-- �ѱ��� ��� ����Ʈ ������ �޶� ������ ���̰� ����
SELECT LPAD('HELLO', 5) FROM DUAL;
SELECT LPAD('HELLO', 5, '0') FROM DUAL;
SELECT LPAD('HELLO', 10, '0') FROM DUAL;
SELECT RPAD('HELLO', 10, '0') FROM DUAL;

SELECT RPAD(NAME, 6, '_') FROM MEMBER;  -- �̸��� 2���ڸ� _�� ä���� ��ȸ

-- ù ���ڸ� �빮�ڷ� ġȯ
-- INITCAP(���ڿ�)
SELECT INITCAP('the ....') FROM DUAL;
SELECT INITCAP('the most important thing is ....') FROM DUAL;
SELECT INITCAP('the most im����portant t������hing is ....') FROM DUAL;

-- ���ڿ� ��ġ �˻� �Լ�
-- INSTR(���ڿ�, �˻����ڿ�, ��ġ, ����)
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO') FROM DUAL;   -- ù��°�� �˻��Ǵ� TO�� ��ġ ��ȸ
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO', 15) FROM DUAL;   -- 15��° ���ķ� �˻��Ǵ� TO�� ��ġ ��ȸ
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO', 1, 2) FROM DUAL; -- �ι�° �˻��Ǵ� TO�� ��ġ ��ȸ

SELECT INSTR(PHONE, '-', 1, 2) FROM MEMBER; -- ��ȭ��ȣ���� �ι�° -���ڰ� �����ϴ� ��ġ ��ȸ
SELECT INSTR(PHONE, '-', 1, 2) - INSTR(PHONE, '-') - 1 FROM MEMBER; -- ��ȭ��ȣ���� ù��° -���ڿ� �ι�° -���� ������ ���� ��ȸ
SELECT SUBSTR(PHONE, INSTR(PHONE, '-')+1, INSTR(PHONE, '-', 1, 2)-INSTR(PHONE, '-')-1) FROM MEMBER; ��ȭ��ȣ���� ù��° -���ڿ� �ι�° -���� ������ ���� ��ȸ

-- ���ڿ� ���̸� ��� �Լ�
-- LENGTH(���ڿ�)
-- LENGTHB(���ڿ�)
SELECT LENGTH('WHERE WE ARE') FROM DUAL;

SELECT PHONE, LENGTH(PHONE) FROM MEMBER;    -- �ڵ��� ��ȣ�� ��ȣ�� ���̸� ��ȸ
SELECT LENGTH(REPLACE(PHONE, '-', '')) FROM MEMBER; -- �ڵ��� ��ȣ���� -���ڸ� ���� ��ȣ�� ���̸� ��ȸ

-- �ڵ� ���� ��ȯ�ϴ� �Լ�
-- ASCII(����)
SELECT ASCII('A') FROM DUAL;

-- �ڵ� ������ ���ڸ� ��ȯ�ϴ� �Լ�
-- CHR(�ڵ尪)
SELECT CHR(65) FROM DUAL;


