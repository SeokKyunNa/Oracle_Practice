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


--025 number function
-- ���밪�� ���ϴ� �Լ�
-- ABS(����)
SELECT ABS(35), ABS(-35) FROM DUAL;

-- ����/����� �˷��ִ� �Լ�
-- SIGN(����), ���=1, ����=-1, 0=0
SELECT SIGN(35), SIGN(-35), SIGN(0) FROM DUAL;

-- �ݿø� �Լ�
-- ROUND(����, �Ҽ����ڸ���), �Ҽ����ڸ����� �Է����� ������ �Ҽ��� ù��°���� �ݿø�
SELECT ROUND(34.456789), ROUND(34.56789) FROM DUAL;
SELECT ROUND(34.456789, 2), ROUND(34.456789, 3) FROM DUAL;

-- ������ ���� ��ȯ�ϴ� �Լ�
-- TRUNC(����/�и�)
-- ������ �������� ��ȯ�ϴ� �Լ�
-- MOD(����, �и�)
SELECT TRUNC(17/5) ��, MOD(17, 5) ������ FROM DUAL;

-- ������ ������ ���ϴ� �Լ�
-- POWER(����, ������)
--������ �������� ���ϴ� �Լ�
-- SQRT(����)
SELECT POWER(5, 2), SQRT(25) FROM DUAL;


--026 date function
-- SYSDATE  ������ ��/��/��
-- CURRENT_DATE ����� ���ǿ� ������ ��/��/��
-- SYSTIMESTAMP ������ ��/��/�� �ú���.�и�������
-- CURRENT_TIMESTAMP    ����� ���ǿ� ������ ��/��/�� �ú���.�и�������
SELECT SYSDATE, CURRENT_DATE, SYSTIMESTAMP, CURRENT_TIMESTAMP FROM DUAL;

-- ���� �ð��� ���� ����
ALTER SESSION SET TIME_ZONE = '09:00';  --  GMT �׸���ġ ��ս� �������� +9�ð� : �ѱ� KST �ð���
ALTER SESSION SET TIME_ZONE = '-08:00';  -- GMT �׸���ġ ��ս� �������� -8�ð�
-- NLS : National Language Support 
ALTER SESSION SET NSL_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- ��¥ ���� �Լ�
-- EXTRACT(YEAR/MONTH/DAY/HOUR/MINUTE/SECOND FROM [�÷���])
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
-- ���� ���� ���� ���� �� ��ȸ ����
SELECT EXTRACT(MINUTE FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(SECOND FROM SYSDATE) FROM DUAL;

SELECT * FROM MEMBER WHERE EXTRACT(MONTH FROM REGDATE) IN (02, 03, 11, 12);  -- 2, 3, 11, 12���� ������ ȸ�� ��ȸ

-- ��¥ ���� �Լ�
-- ADD_MONTHS(��¥, ����)
SELECT ADD_MONTHS(SYSDATE, 1) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, -2) FROM DUAL;
SELECT * FROM MEMBER WHERE REGDATE > ADD_MONTHS(SYSDATE, -6);   -- �������� 6������ ���� ���� ȸ�� ��ȸ
SELECT * FROM MEMBER WHERE REGDATE <= ADD_MONTHS(SYSDATE, -6);   -- �������� 6������ ���� ȸ�� ��ȸ

-- ��¥�� ���̸� �˾Ƴ��� �Լ�
-- MONTHS_BETWEEN(��¥, ��¥)
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2013-12-25')) FROM DUAL;
SELECT * FROM MEMBER WHERE MONTHS_BETWEEN(SYSDATE, REGDATE) < 6;    -- �������� 6������ ���� ���� ȸ�� ��ȸ
SELECT * FROM MEMBER WHERE MONTHS_BETWEEN(SYSDATE, REGDATE) >= 6;   -- �������� 6������ ���� ȸ�� ��ȸ

-- ���� ������ �˷��ִ� �Լ�
-- NEXT_DAY(���糯¥, ��������)
SELECT NEXT_DAY(SYSDATE, '������') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'ȭ') FROM DUAL;
-- �Ͽ����� 1 ~ ������� 7
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;

-- ���� ������ ���ڸ� �˷��ִ� �Լ�
-- LAST_DAY(��¥)
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(ADD_MONTHS(SYSDATE, -2)) FROM DUAL;

-- ������ �������� ��¥�� �ݿø��ϴ�/�ڸ��� �Լ� ROUND/TRUNC(��¥, ����)
SELECT SYSDATE, ROUND(SYSDATE, 'CC'), TRUNC(SYSDATE, 'CC') FROM DUAL;    -- 1����(100�� ����)
SELECT SYSDATE, ROUND(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;    -- �� ����
SELECT SYSDATE, ROUND(SYSDATE, 'Q'), TRUNC(SYSDATE, 'Q') FROM DUAL;  -- �б� ����
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL;  -- �� ����
SELECT SYSDATE, ROUND(SYSDATE, 'W'), TRUNC(SYSDATE, 'W') FROM DUAL;  -- �� ����
SELECT SYSDATE, ROUND(SYSDATE, 'DAY'), TRUNC(SYSDATE, 'DAY') FROM DUAL;  -- �� ����
SELECT SYSDATE, ROUND(SYSDATE, 'D'), TRUNC(SYSDATE, 'D') FROM DUAL; -- �� ����(������ ����)
SELECT SYSDATE, ROUND(SYSDATE, 'HH'), TRUNC(SYSDATE, 'HH') FROM DUAL;   -- �ð� ����
SELECT SYSDATE, ROUND(SYSDATE, 'MI'), TRUNC(SYSDATE, 'MI') FROM DUAL;   -- �� ����


--027   CASTING FUNCTION
-- ���� - TO_CHAR() - ���ڿ� - TO_DATE() ��¥
-- ��¥ - TO_CHAR() - ���ڿ� - TO_NUMBER() ����

-- NUMBER ������ ���ڿ�(VARCHAR2)�� ��ȯ
-- TO_CHAR(NUMBER, FORMAT)
-- ������ ������ ���̺��� ���� ��
-- ���˹���
-- 9 : ����
-- 0 : ���ڸ��� ä��� ����
-- $ : �տ� $ ǥ��
-- , : õ ���� ������ ǥ��
-- . : �Ҽ��� ǥ��
SELECT TO_CHAR(12345678, '$99,999,999,999.99') FROM DUAL;
SELECT 123 || 'HELLO' FROM DUAL;
SELECT TO_CHAR(123) || 'HELLO' FROM DUAL;
SELECT TO_CHAR(12345678, '99,999,999') || 'HELLO' FROM DUAL;
SELECT TO_CHAR(1234567890, '99,999,999') || 'HELLO' FROM DUAL;  -- �Է� ���ڰ� ���˺��� ��� �ùٸ��� ���� �������� ǥ�� ��
SELECT TO_CHAR(1234567890, '009,999,999,999') || 'HELLO' FROM DUAL; -- ����0�� ���˺��� �Է� ���ڰ� ª���� 0���� ä����
SELECT TO_CHAR(1234567890, '999,999,999,999') || 'HELLO' FROM DUAL;
SELECT TO_CHAR(1234567890, '999,999,999,999') || '��' FROM DUAL;
SELECT TRIM(TO_CHAR(1234567890, '999,999,999,999')) || '��' FROM DUAL;

SELECT TO_CHAR(1234567.12345, '9,999,999,999.9999') || '��' FROM DUAL;   -- �Ҽ����� ǥ�� ������ �ڸ��� �ϳ� �Ʒ����� �ݿø�
SELECT TO_CHAR(1234567.1, '9,999,999,999.9999') || '��' FROM DUAL;   -- �Ҽ����� ���˱��̸�ŭ 0���� ä������ ǥ����

-- DATE �������� ���ڿ�(VARCHAR2)�� ��ȯ
-- TO_CHAR(DATETIME)
-- ���˹���
-- YYYY/RRRR/YY/YEAR : �⵵ǥ�� - 4�ڸ�/Y2K/2WKFL/����
-- MM/MON/MONTH : ��ǥ�� - 2�ڸ�/����3�ڸ�/������ü
-- DD/DAY/DDTH : ��ǥ�� - 2�ڸ�/����/2�ڸ�ST
-- AM/PM : ����/���� ǥ��
-- HH/HH24 : �ð�ǥ�� - 12�ð�/24�ð�
-- MI : ��ǥ�� - 0~59
-- SS : ��ǥ�� - 0~59
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'RRRR-MONTH-DDTH HH:MI:SS') FROM DUAL;

-- ���ڿ��� ��¥ �������� ��ȯ�ϴ� �Լ�
-- TO_DATE(���ڿ�, ��¥����)
SELECT TO_DATE('2002-01-01', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2002-01-01', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- ���ڿ��� ��¥�������� ��ȯ�ϴ� �Լ�2
-- TO_TIMESTAMP(���ڿ�)
SELECT TO_TIMESTAMP('2002-01-01', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- ���ڿ��� ���� �������� ��ȯ�ϴ� �Լ�
-- TO_NUMBER(���ڿ�)
SELECT TO_NUMBER('2020') FROM DUAL;
SELECT TO_NUMBER('2') + 3 FROM DUAL;


--028 NULL FUNCTION
-- ��ȯ���� NULL�϶� ��ü ���� �����ϴ� �Լ�
-- NVL(�÷���(NULL), ��ü��)
SELECT NULL + 3 FROM DUAL;
SELECT AGE + 3 FROM MEMBER;
SELECT NVL(GENDER, 0) FROM MEMBER;
SELECT TRUNC(NVL(AGE, 0)/10) * 10 ���ɴ� FROM MEMBER;

-- NVL���� ������ �ϳ� �� Ȯ���� �Լ�
-- NVL2(�÷���(NULL), NOTNULL ��ü��, NULL ��ü��)
SELECT NVL2(AGE, TRUNC(AGE/10)*10, 0) ���ɴ�2 FROM MEMBER;

-- �� ���� ���� ��� NULL, �ٸ� ��� ù ��° �� ��ȯ �Լ�
-- NULLIF(��1, ��2)
SELECT NAME, NULLIF(AGE, 40) FROM MEMBER;

-- ���ǿ� ���� ���� �����ϴ� �Լ�
-- DECODE(���ذ�, �񱳰�, ��°�, ������ ��°�)
SELECT DECODE(PWD, 
            '111', '������', 
            '222', '������', 
            '333', '����',
            '��Ÿ') FROM MEMBER;


--029   SELECT, ORDER BY
-- SELECT ������ ����(�ٲ�� �� ��)
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM : ������ ������ ���� �����͸� �����ϴ� ����
-- WHERE : ���� ���͸�
-- GROUP BY : ������ ���� (COUNT, AVG)
-- HAVING : ����� ����� ���͸�
-- ORDER BY : ����

-- ORDER BY ���� : ASC(��������, DEFAULT, ���� ����), DESC(��������)
SELECT * FROM MEMBER ORDER BY NAME; -- �̸��� ������������ �����ؼ� ��ȸ
SELECT * FROM MEMBER ORDER BY NAME DESC; -- �̸��� ����(��������)���� �����ؼ� ��ȸ
SELECT * FROM MEMBER WHERE NAME LIKE '��%' ORDER BY AGE; -- ȸ�� �߿��� '��'�� ���� ���� ȸ���� ���� ������������ �����Ͽ� ��ȸ

SELECT * FROM NOTICE ORDER BY HIT DESC, REGDATE DESC;   -- ��ȸ�� �������� ��ȸ�ϰ� ��ȸ���� ������ ������� �������� ��ȸ


--030   AGGREGATE FUNCTION
-- SUM(��), MIN(�ּҰ�), MAX(�ִ밪), COUNT(��), AVG(���)
-- COUNT - NULL�� ������ ����
-- ��ü �������� ���� ���Ϸ��� NOT NULL ������ �÷����� ��ȸ�ϰų�, *�� ��ȸ(�ð��� ���� �ɸ� �� ����)
SELECT * FROM NOTICE;
SELECT COUNT(TITLE) FROM NOTICE;
SELECT COUNT(*) FROM NOTICE;

SELECT SUM(HIT) ��, AVG(HIT) ��� FROM NOTICE;
SELECT WRITER_ID, COUNT(ID) COUNT FROM NOTICE GROUP BY WRITER_ID;
SELECT WRITER_ID, COUNT(ID), TITLE FROM NOTICE GROUP BY WRITER_ID;   -- ���� : ���� ���ذ� ���� �÷��� ������ �� ����

SELECT WRITER_ID, COUNT(ID) COUNT FROM NOTICE GROUP BY WRITER_ID ORDER BY COUNT DESC, WRITER_ID;

-- **SELECT���� ���� ���� : FROM > WHERE > GROUP BY > HAVING > ORDER BY > SELECT
-- SQL���� ���������Ͽ� ���� ���ϰ� ����


--031   AGGREGATE FUNCTION(HAVING)
-- WHERE �������� ���� �Լ��� ����� �� ����
-- **SELECT���� ���� ������ ���ؼ� ���� �Լ��� WHERE���� ����� �� ����
SELECT WRITER_ID, COUNT(ID) FROM NOTICE WHERE COUNT(ID) < 2 GROUP BY WRITER_ID;    -- ����
SELECT WRITER_ID, COUNT(ID) FROM NOTICE GROUP BY WRITER_ID HAVING COUNT(ID) < 2; -- �Խñ� ���� 2 ������ ȸ���� �Խñ� �� ��ȸ


--032   RANKING FUNCTION
-- **ROWNUM�� WHERE������ ������
SELECT ROWNUM, ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE ORDER BY HIT; -- HIT�� ���� ���ĵǸ鼭 �̸� ���ǵ� ROWNUM�� ������ �ٲ�

-- ���ĵ� �Ŀ� ROWNUM�� ���̴� �Լ�
-- ROW_NUMBER()
SELECT ROW_NUMBER() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- ���ĵ� �Ŀ� ����� �ű�� �Լ�(�ߺ� ���) EX) 1, 2, 3, 3, 5, 6, ..
-- RANK()
SELECT RANK() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- ���ĵ� �Ŀ� ����� �ű�� �Լ�(�ߺ� �� ����� �ǳʶ��� ����) EX) 1, 2, 3, 3, 4, 5, 6, ...
-- DENSE_RANK()
SELECT DENSE_RANK() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- �ɼ� OVER (ORDER BY �÷�) - ���� �� ROWNUM�� �ű�
-- �ɼ� OVER (PARTITION BY �÷�1 ORDER BY �÷�2) - �÷�1���� ��� ROWNUM�� �ű� �� ����, �÷�1�� ���Ͽ� ������������ �ڵ� ����
SELECT ROW_NUMBER() OVER (PARTITION BY WRITER_ID ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
SELECT DENSE_RANK() OVER (PARTITION BY WRITER_ID ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;


--033   SUB QUERY
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 1 AND 5;
-- ������ ������� ������ ����� ���ϴ� ���
-- ������ ����� ���������� ���
-- FROM���� ���������� �Է�
SELECT * FROM(
SELECT * FROM NOTICE ORDER BY REGDATE DESC
) WHERE ROWNUM BETWEEN 1 AND 5;

SELECT * FROM MEMBER WHERE AGE >= (SELECT AVG(AGE) FROM MEMBER); -- ��� ���� �̻��� ȸ���� ��ȸ


--034   INNER JOIN
-- ������ ����
-- INNER JOIN, OUTER JOIN, SELF JOIN, CROSS JOIN(Cartesian Product)
-- ���� �����ϴ� ���̺��� ���ļ� ��ȸ�ϴ� ���
-- ������ �Ǵ� ��(������ ���� �� ���� ��)�� �θ� ���̺��� �� EX) ȸ������=�θ����̺�, �Խ���(�ۼ���)=�ڽ����̺�

-- ���� ���� �ִ� ���ڵ�鸸 ��ġ�� ������ INNER JOIN�̶�� ��
-- ON���� ���� �÷� �ۼ�
SELECT * FROM MEMBER;
SELECT * FROM NOTICE;
SELECT * FROM MEMBER INNER JOIN NOTICE ON MEMBER.ID = NOTICE.WRITER_ID; -- ANSI SQL ǥ�� INNER JOIN ���


--035   OUTER JOIN
-- ���� ���� ���� ���ڵ�鵵 ���Խ�Ű�� ������ OUTER JOIN�̶�� ��
-- LEFT OUTER JOIN : ���� ���̺��� OUTER �����͸� ���Խ�Ŵ
-- RIGHT OUTER JOIN : ������ ���̺��� OUTER �����͸� ���Խ�Ŵ
-- FULL OUTER JOIN : ���� ���̺��� OUTER �����͸� ���Խ�Ŵ

-- INNER JOIN�� �⺻���̱⶧���� JOIN�� ���� INNER JOIN���� ó����
SELECT * FROM NOTICE N JOIN MEMBER M ON N.WRITER_ID = M.ID;
-- OUTER JOIN
SELECT * FROM NOTICE N LEFT OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;
SELECT * FROM NOTICE N RIGHT OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;
SELECT * FROM NOTICE N FULL OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;


--036   USING OUTER JOIN
SELECT WRITER_ID, COUNT(WRITER_ID) FROM NOTICE GROUP BY WRITER_ID;
SELECT * FROM MEMBER;

-- ȸ���� �ۼ��� �Խñ� �� ��ȸ
SELECT M.ID, M.NAME, COUNT(N.ID) FROM MEMBER M JOIN NOTICE N ON M.ID = N.WRITER_ID GROUP BY M.ID, M.NAME;   -- �ۼ� �Խñ��� 0�� ȸ���� ��ȸ���� ����
SELECT M.ID, M.NAME, COUNT(N.ID) FROM MEMBER M LEFT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID GROUP BY M.ID, M.NAME;    -- ���� ��ȸ
-- ������ �Ǵ� ������ �����ʹ� ��� ����ϰ� �����ִ� �����͸� �����ʿ� JOIN�Ͽ� ��ġ�°� JOIN���� �⺻


--037  SELF JOIN
-- �������̺�� �������̺��� JOIN
-- �����Ͱ� ���� ���� ���踦 ������ ��쿡 ��� EX) ����鰣�� �������
-- ����, ī�װ� ��� ���� ��� ��
ALTER TABLE MEMBER ADD BOSS_ID NVARCHAR2(50);

SELECT * FROM MEMBER;
SELECT M.*, B.NAME BOSS_NAME FROM MEMBER M LEFT OUTER JOIN MEMBER B ON B.ID = M.BOSS_ID;


--038 ORACLE JOIN
-- INNER JOIN
SELECT N.ID, N.TITLE, M.NAME FROM MEMBER M INNER JOIN NOTICE N ON M.ID = N.WRITER_ID;   -- ANSI SQL
SELECT N.ID, N.TITLE, M.NAME FROM MEMBER M, NOTICE N WHERE M.ID = N.WRITER_ID;  -- ORACLE JOIN

SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N JOIN MEMBER M ON M.ID = N.WRITER_ID;   -- ANSI SQL
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N, MEMBER M WHERE M.ID = N.WRITER_ID;    -- ORACLE JOIN

-- OUTER JOIN
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N LEFT JOIN MEMBER M ON M.ID = N.WRITER_ID;   -- ANSI SQL
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N, MEMBER M WHERE M.ID(+) = N.WRITER_ID;    -- ORACLE JOIN

-- FULL OUTER JOIN�� �������� ����
-- CROSS JOIN
-- �� ���̺��� ���ϱ� �����͸� ������
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N CROSS JOIN MEMBER M;   -- ANSI SQL
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N, MEMBER M;    -- ORACLE JOIN


--039   UNION
-- RECORE(DATA)�� ��ĥ �� ���
-- ���� �ٸ� ���̺��� �����͸� ���� ��ȸ�� �� ��� EX) �پ��� �Խ����� ���� �˻�

-- UNION ALL : �ߺ� ������� ���� ��ȸ
-- UNION : �ߺ� �����ʹ� �ϳ��� ��ȸ�Ͽ� ���� ��ȸ
-- MINUS : ���� �����Ϳ��� ���� �����͸� ���� ���� �����͸� ��ȸ
-- INTERSECT : �ߺ� �����͸� ��ȸ

SELECT ID, NAME FROM MEMBER UNION SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER UNION ALL SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER MINUS SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER INTERSECT SELECT WRITER_ID, TITLE FROM NOTICE;

SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%n%' UNION SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%g%';
SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%n%' MINUS SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%g%';


--040 VIEW
-- ������ �������� VIEW�� �����ؼ� ���ϰ� ����� �� ����
-- �������� �����ͱ���(TABLE), �������� �����ͱ���(VIEW)

-- �Խñ� �ۼ����� �̸��� �Խñ��� ��� ���� �Բ� ���� ������
CREATE VIEW NOTICEVIEW AS
SELECT N.ID, N.TITLE, N.WRITER_ID, M.NAME WRITER_NAME, COUNT(C.ID) CNT
FROM MEMBER M RIGHT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID
LEFT OUTER JOIN "COMMENT" C ON N.ID = C.NOTICE_ID
GROUP BY N.ID, N.TITLE, N.WRITER_ID, M.NAME;

-- �� ������ VIEW ������
CREATE VIEW NOTICEVIEW AS
SELECT N.ID, N.TITLE, N.WRITER_ID, M.NAME WRITER_NAME, COUNT(C.ID) CNT
FROM MEMBER M RIGHT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID
LEFT OUTER JOIN "COMMENT" C ON N.ID = C.NOTICE_ID
GROUP BY N.ID, N.TITLE, N.WRITER_ID, M.NAME;

SELECT * FROM NOTICEVIEW;


--041 DATA DICTIONARY
-- Data Dictionary : ����� ����, ����, ���̺�/��, ��������, �Լ�/���ν��� ����� DBMS���� �����ϴ� ����
-- �ֱٿ��� ���� ����Ͽ� �ս��� ��ȸ ����
-- Data Dictionary�� VIEW ���·� ������ (���� ���̺� �������� �� �ϰ� �ϱ� ���� ���� ����)
-- DBA_, ALL_, USER_ : ���ѿ� ���� ���̹�
SELECT * FROM DICT;
SELECT * FROM USER_TABLES;  -- ���̺� ��ȸ
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'MEMBER'; -- ���̺� �÷� ��ȸ


--042   CONSTRAINT
-- ������ �Է¿� ������ ��
-- ������ > ��ƼƼ > �����̼� ��������
-- ������ : �÷��� ��ȿ�� ���� ���� EX) 0���� ū ����, 20�� ���� ���� ��
-- �Ӽ��� �������� �ƴ� ���� �� �� ������ �ϴ� ��������

-- NOT NULL : NULL�� ������� ����
-- DEFAULT : ���� ������ �⺻���� ����
-- CHECK : ���� ��ȿ ����(������ ����)�� üũ

-- ���̺� ������ �� NOT NULL ���� ���� ����
CREATE TABLE TEST(
    ID VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(200) NULL,
    PHONE CHAR(13) NOT NULL
)

-- ���̺� ���� �� NOT NULL ���� ���� ���� (���� �����Ϳ� NULL�� �����ϸ� �Ұ�)
ALTER TABLE TEST MODIFY EMAIL VARCHAR2(200) NOT NULL;

-- ���̺� ������ �� DEFAULT ���� ���� ����
CREATE TABLE TEST(
    ID VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(200) NULL,
    PHONE CHAR(13) NOT NULL,
    PWD VARCHAR2(200) DEFAULT '111' 
)

-- ���̺� ���� �� DEFAULT ���� ���� ����
ALTER TABLE TEST MODIFY EMAIL VARCHAR2(200) DEFAULT '111';
-- **�� �̿� �� ���� ����Ʈ�� ���̺��� SQL ��ũ��Ʈ�� �巡���ϸ� �ڵ����� �⺻ �������� ������ �� ����

