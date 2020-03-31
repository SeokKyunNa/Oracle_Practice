--006
SQL의 구분
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
CHARACTER 형식 : CHAR(3), VARCHAR2(3), NCHAR(3), NVARCHAR(3)
VAR(VARiable) - 가변 길이 데이터, 최대값을 지정해줌
N(National) - 1글자당 2 or 3bytes 사용, 전세계의 언어에 적용 가능

CREATE MEMBER(
    ID          VARCHAR2(50),
    PWD         NVARCHAR2(50),
    NAME        NVARCHAR2(50),
    GENDER      NCHAR(2),    -- CHAR(2 CHAR) = 2글자 입력 가능
    AGE         NUMBER,
    BIRTHDAY    CHAR(10),   --2000-01-02
    PHONE       CHAR(13),   --010-1234-5678
    REGDATE     DATE
);

select length('ab') from dual;
select length('한글') from dual;
select lengthb('ab') from dual; --lengthb = length byte
select lengthb('한글') from dual;