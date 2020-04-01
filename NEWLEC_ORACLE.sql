--006
SQL�� ����
DDL
(CREATE / ALTER / DROP)
DML
(INSERT / SELECT / UPDATE / DELETE) - CRUD
DCL
(GRANT/ REVOKE)

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
CHARACTER ���� : CHAR(3), VARCHAR2(3), NCHAR(3), NVARCHAR(3)
VAR(VARiable) - ���� ���� ������, �ִ밪�� ��������
N(National) - 1���ڴ� 2 or 3bytes ���, �������� �� ���� ����

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
LONG    -- 2Gb, ���������� �ƴ� Caracter ����, ������ ���� ����̶� �ϳ��� �÷��� LONGŸ���� ����ϸ� �ٸ� �÷��� ����� �� ����
CLOB    -- 4Gb, ��뷮 ������ Ÿ��
NCLOB   -- 4Gb, ��뷮 �����ڵ� ������ Ÿ��

NUMBER(4)   -- �ִ� 4�ڷ� �̷���� ����
NUMBER(6, 2)    -- �Ҽ��� 2�ڸ��� �����ϴ� �ִ� 6�ڸ� ����
NUMBER(6, -2)   -- �Ҽ��� -2�ڸ����� �ݿø��ϴ� �ִ� 6�ڸ� ����
NUMBER  -- NUMBER(38, *)
NUMBER(*, 5)    -- NUMBER(38, 5)

DATE        --��-��-��
TIMESTAMP   --��-��-��-��-��-��


--009
--TABLE COLUMN MODIFY ������ ������ ����, �����ͺ��� ū ũ��θ� ���� ����
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
--TABLE COLUMN DROP
ALTER TABLE MEMBER DROP COLUMN AGE;
--TABLE COLUMN ADD
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
--���̺��� ������ ��ɾ�ٴ� ���� ���


