--006
--SQL의 구분
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
--CHARACTER 형식 : CHAR(3), VARCHAR2(3), NCHAR(3), NVARCHAR(3)
--VAR(VARiable) - 가변 길이 데이터, 최대값을 지정해줌
--N(National) - 1글자당 2 or 3bytes 사용, 전세계의 언어에 적용 가능

CREATE MEMBER(
    ID          VARCHAR2(50),
    PWD         NVARCHAR2(50),
    NAME        NVARCHAR2(50),
    GENDER      NCHAR(2),    -- CHAR(2 CHAR) = 2글자 입력 가능
    AGE         NUMBER(3),
    BIRTHDAY    CHAR(10),   --2000-01-02
    PHONE       CHAR(13),   --010-1234-5678
    REGDATE     DATE
);

select length('ab') from dual;
select length('한글') from dual;
select lengthb('ab') from dual; --lengthb = length byte
select lengthb('한글') from dual;

--008
--LONG    -- 2Gb, 숫자형식이 아닌 Caracter 형식, 예전에 쓰던 방식이라서 하나의 컬럼에 LONG타입을 사용하면 다른 컬럼에 사용할 수 없음
--CLOB    -- 4Gb, 대용량 데이터 타입
--NCLOB   -- 4Gb, 대용량 유니코드 데이터 타입

--NUMBER(4)   -- 최대 4자로 이루어진 숫자
--NUMBER(6, 2)    -- 소수점 2자리를 포함하는 최대 6자리 숫자
--NUMBER(6, -2)   -- 소수점 -2자리에서 반올림하는 최대 6자리 숫자
--NUMBER  -- NUMBER(38, *)
--NUMBER(*, 5)    -- NUMBER(38, 5)

--DATE        --년-월-일
--TIMESTAMP   --년-월-일-시-분-초


--009
--TABLE COLUMN MODIFY 데이터 형식이 같고, 데이터보다 큰 크기로만 변경 가능
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
--TABLE COLUMN DROP
ALTER TABLE MEMBER DROP COLUMN AGE;
--TABLE COLUMN ADD
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
--DDL(테이블의 수정 포함)은 명령어보다는 툴을 사용


--010
--오라클은 예약어 등으로 이미 사용되는 용어는 큰따옴표로 감싸서 테이블명이나 컬럼명 등으로 사용 가능
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
--INSERT INTO [테이블] VALUES (모든 값 목록);
--INSERT INTO [테이블](필드명) VALUES (각 필드 값);
-- 지정되지 않는 값은 NULL값이 들어감

--SELECT * FROM [테이블];

INSERT INTO MEMBER (ID, PWD) VALUES ('engsk1211', '111');
SELECT * FROM MEMBER;

--SELECT [필드명] FROM [테이블];
SELECT ID, NAME, PWD FROM MEMBER;

--[필드명] AS [별칭]   -- 필드명을 별칭으로 사용, AS는 생략 가능
SELECT ID AS USER_ID, NAME, PWD FROM MEMBER;
SELECT ID USER_ID, NAME, PWD FROM MEMBER;
SELECT ID "user id", NAME, PWD FROM MEMBER; -- 큰따옴표로 묶인 별칭은 대소문자가 구분된채로 사용됨


--012
--UPDATE [테이블] SET [필드명]=[값];
UPDATE MEMBER SET PWD = '222';
SELECT * FROM MEMBER;
--WHERE절 = 조건절, WHERE [필드명]=[조건값];
UPDATE MEMBER SET PWD = '111' WHERE ID = 'newlec1';
--DELETE [테이블] WHERE [필드명]=[조건값];
DELETE MEMBER WHERE ID='newlec2';


