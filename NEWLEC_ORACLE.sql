--006   create member table
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

--007   oracle data type (char)
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

--008   oracle data type (number, date)
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


--009   alter table
--TABLE COLUMN MODIFY 데이터 형식이 같고, 데이터보다 큰 크기로만 변경 가능
ALTER TABLE MEMBER MODIFY ID NVARCHAR2(50);
--TABLE COLUMN DROP
ALTER TABLE MEMBER DROP COLUMN AGE;
--TABLE COLUMN ADD
ALTER TABLE MEMBER ADD EMAIL VARCHAR2(200);
--DDL(테이블의 수정 포함)은 명령어보다는 툴을 사용


--010   create table
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


--011   manipulate data (insert/select)
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


--012   manipulate data (update/delete)
--UPDATE [테이블] SET [필드명]=[값];
UPDATE MEMBER SET PWD = '222';
SELECT * FROM MEMBER;
--WHERE절 = 조건절, WHERE [필드명]=[조건값];
UPDATE MEMBER SET PWD = '111' WHERE ID = 'newlec1';
--DELETE [테이블] WHERE [필드명]=[조건값];
DELETE MEMBER WHERE ID='newlec2';


--013   trasaction (commit/rollback)
--트랜잭션이란? 업무 실행 단위, 논리 명령 단위, 개념상의 단위
-- 업무적인 단위       물리적인 명령어 단위
-- 계좌이체              update             1. 현재 세션을 위한 임시저장소에서만 테스트
--                      update             2. 그 동안 다른 세션이 건드리디 못하도록 LOCK, 완료 후 UNLOCK, COMMIT;
-- 이벤트 게시글 등록     insert
--                      update

SELECT ID "user id", NAME, PWD FROM MEMBER;
INSERT INTO MEMBER (ID, PWD) VALUES ('test', '111');
INSERT INTO MEMBER (ID, PWD) VALUES ('dragon', '444');

COMMIT;     -- 임시 저장소의 내용을 데이터베이스에 적용
ROLLBACK;   -- 임시 저장소의 내용을 적용시키지 않고 되돌림
-- COMMIT이나 ROLLBACK 할 때까지 해당 테이블은 LOCK 상태. COMMIT이나 ROLLBACK 이후 UNLOCK 됨


--014   arithmetic operator
-- 산술 연산자 +, -, *, /
-- 문자의 붙임은 || 연산자를 사용
-- 연산이 사용된 컬럼은 별칭을 사용
SELECT HIT+1 "hit" FROM NOTICE;
SELECT 1+'3' FROM DUAL; -- 오라클에서 산술연산자는 무조건 숫자로 계산됨
SELECT 1||'3' FROM DUAL;    -- 문자의 붙임은 || 연산자를 사용
SELECT 1 + 'A' FROM DUAL;   -- 오류
SELECT NAME || '(' || ID || ')' "NAME(ID)" FROM MEMBER;


--015   comparison operator
-- 비교 연산자 =, !=, ^=, <>, >, <, >=, <=, IS NULL, IS NOT NULL
-- 같지 않음을 뜻하는 3가지 연산자
-- != : 다른 DBMS에서 사용하기에 표준이 됨
-- <> : ANSI SQL에서 정의하는 연산자
-- ^= : 오라클에서 사용하는 연산자

SELECT * FROM NOTICE WHERE WRITER_ID = 'newlec';    -- 작성자가 newlec인 글 조회
SELECT * FROM NOTICE WHERE HIT > 3;     -- 조회수가 3보다 큰 글 조회
SELECT * FROM NOTICE WHERE CONTENT IS NULL; -- 내용을 입력하지 않은 게시글 조회
SELECT * FROM NOTICE WHERE CONTENT IS NOT NULL; -- 내용이 존재하는 게시글만 조회


--016   relational operator
-- 관계 연산자 NOT, AND, OR, BETWEEN, IN
SELECT * FROM NOTICE WHERE HIT = 0 OR HIT = 1 OR HIT = 2;   -- 조회수가 0, 1, 2인 게시글 조회
SELECT * FROM NOTICE WHERE 0 <= HIT AND HIT <= 2;   -- 조회수가 0, 1, 2인 게시글 조회
SELECT * FROM NOTICE WHERE HIT BETWEEN 0 AND 2;     -- 조회수가 0, 1, 2인 게시글 조회

SELECT * FROM NOTICE WHERE HIT IN (0, 2, 7);    -- 조회수가 0, 2, 7인 게시글 조회
SELECT * FROM NOTICE WHERE HIT NOT IN (0, 2, 7);    -- 조회수가 0, 2, 7이 아닌 게시글 조회


--017   pattern comparison operator
-- 패턴 비교 연산자 LIKE, %, _
SELECT * FROM MEMBER WHERE NAME LIKE '박%';  -- '박'씨 성을 가진 회원 조회
SELECT * FROM MEMBER WHERE NAME LIKE '유__'; -- '유'씨이고 이름이 두글자인 회원 조회
SELECT * FROM MEMBER WHERE NAME NOT LIKE '박%';  -- '박'씨 성을 제외한 회원 조회
SELECT * FROM MEMBER WHERE NAME LIKE '%석%'; -- 이름에 '석'자가 들어간 회원 조회


--018 Regular expression
-- 참고 사이트 https://regexlib.com
-- [] 대괄호 한 칸은 한 글자를 의미함, 여러개의 문자를 넣을 수 있음
-- \d decimal 1글자를 의미
-- {} 중괄호로 바로 앞의 글자가 몇번 반복되는지 지정
-- ^ 정규식의 시작
-- $ 정규식의 끝
-- 정규식 조건외에 다른 문자가 포함된 데이터를 찾을때는 ^ $ 생략
-- 정규식은 [컬럼] LIKE [조건]이 아닌 REGEXP_LIKE([컬럼], [조건]) 사용
-- 핸드폰 번호 예제    ^01[016-9]-\d{3,4}-\d{4}$
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '^01[016-9]-\d{3,4}-\d{4}$');
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '01[016-9]-\d{3,4}-\d{4}');


