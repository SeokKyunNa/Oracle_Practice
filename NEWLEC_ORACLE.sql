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


--018   Regular expression (number)
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


--019   Regular expression (char)
-- \w [a-zA-Z 0-9]와 같음, 공백을 포함한 모든 문자
-- + 앞의 문자가 하나 이상 존재
-- * 앞의 문자가 0개 이상 존재
-- | OR와 같음, 조건 중 하나와 같을 때
-- \D [^0-9]와 같음, 숫자가 아닌 경우
-- 이메일 예제   \D\w+@\D\w*.(org|net|com)
SELECT * FROM NOTICE WHERE REGEXP_LIKE (TITLE, '\D\w+@\D\w*.(org|net|com)');


--020   ROWNUM
-- ROWNUM 조회 시 자동으로 생성되는 숫자 순서
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 1 AND 5;
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 6 AND 10; -- 데이터가 조회되지 않음, ROWNUM 1부터 WHERE절의 조건에 맞는 데이터가 조회되기 때문.
SELECT ROWNUM, NOTICE.* FROM NOTICE;

-- FROM절의 ROWNUM을 사용하려면 별칭 필요
SELECT * FROM (SELECT ROWNUM NUM, NOTICE.* FROM NOTICE) WHERE NUM BETWEEN 6 AND 10;


--021   DISTINT, 중복제거 deduplication
-- ALTER TABLE MEMBER ADD AGE NUMBER;
-- 하나의 컬럼을 중복없이 목록으로 뽑을 때 사용 가능
SELECT * FROM MEMBER;
SELECT AGE FROM MEMBER;
SELECT DISTINCT AGE FROM MEMBER;

--022 중간 정리


--023   string function (1)
-- 문자열 추출 함수 - SUBSTR(문자열, 시작위치, 길이)
-- WHERE 절에는 함수를 사용하는 것을 지양, 데이터의 수만큼 함수가 호출되어서 속도에 문제가 생김
SELECT SUBSTR('HELLO', 1, 3) FROM DUAL; -- 1번째부터 3글자 출력
SELECT SUBSTR('HELLO', 3) FROM DUAL;    -- 3번째부터 출력
SELECT SUBSTRB('HELLO', 3) FROM DUAL;   -- 3번째 바이트부터 출력

SELECT NAME FROM MEMBER;
SELECT SUBSTR(NAME, 2) FROM MEMBER;
SELECT SUBSTRB(NAME, 4) FROM MEMBER;

SELECT * FROM MEMBER;
SELECT NAME, SUBSTR(BIRTHDAY, 6, 2) FROM MEMBER;    -- 이름과 태어난 월 출력

SELECT * FROM MEMBER WHERE SUBSTR(PHONE, 1, 3) = '011';  -- 전화번호가 011로 시작하는 회원 정보
SELECT * FROM MEMBER WHERE PHONE LIKE '011%';

SELECT * FROM MEMBER WHERE SUBSTR(BIRTHDAY, 6, 2) IN (07, 08, 09);  -- 생일이 7, 8, 9월인 회원 정보
SELECT * FROM MEMBER WHERE SUBSTR(BIRTHDAY, 6, 2) NOT IN (07, 08, 09);  -- 생일이 7, 8, 9월이 아닌 회원 정보

SELECT * FROM MEMBER WHERE PHONE IS NULL AND SUBSTR(BIRTHDAY, 6, 2) IN (07, 08, 09);    -- 전화번호가 등록되지 않았고, 생일이 7, 8, 9월인 회원 정보

-- 문자열 덧셈 함수 - CONCAT(문자열, 문자열)
-- 성능면으로는 함수보다는 연산이 더 빠름
SELECT CONCAT(3, '4') FROM DUAL;
SELECT 3||'4' FROM DUAL;

-- 문자열 트림 함수
-- LTRIM(문자열) 왼쪽 공백 삭제
-- RTRIM(문자열) 오른쪽 공백 삭제
-- TRIM(문자열) 양쪽 공백 삭제
SELECT LTRIM('    HELLO    ') FROM DUAL;
SELECT RTRIM('    HELL0    ') FROM DUAL;
SELECT TRIM('    HELLO    ') FROM DUAL;

-- 문자열 소문자 또는 대문자로 변경
-- LOWER(문자열) 대문자를 소문자로 변경
-- UPPER(문자열) 소문자를 대문자로 변경
SELECT LOWER('ENGsk') FROM DUAL;
SELECT UPPER('ENGsk') FROM DUAL;

 -- 문자열 치환 함수
 -- REPLACE(문자열, 바뀔문자열, 바꿀문자열) 바뀔문자열에 해당하는 문자열을 바꿀문자열로 치환
 -- TRANSLATE(문자열, 바뀔문자열, 바꿀문자열) 같은 위치의 문자끼리 치환
 SELECT REPLACE('WHERE WE ARE', 'WE', 'YOU') FROM DUAL;
 SELECT TRANSLATE('WHERE WE ARE', 'WE', 'YOU') FROM DUAL;
 
 SELECT NAME, REPLACE(EMAIL, ' ', '') FROM MEMBER;  -- 이메일 주소를 공백없이 조회
 
 
--024  string function (2)
-- 함수의 장점
-- 복잡한 절차없이 다양한 결과물을 얻어낼 수 있음

-- 문자열 패딩 함수
-- LPAD(문자열, 길이, 채울문자) 문자열의 왼쪽을 길이만큼 채울문자로 채움
-- RPAD(문자열, 길이, 채울문자) 문자열의 오른쪽을 길이만큼 채울문자로 채움
-- 채울문자가 없으면 공백으로 채움
-- 한글의 경우 바이트 단위가 달라서 영문과 차이가 있음
SELECT LPAD('HELLO', 5) FROM DUAL;
SELECT LPAD('HELLO', 5, '0') FROM DUAL;
SELECT LPAD('HELLO', 10, '0') FROM DUAL;
SELECT RPAD('HELLO', 10, '0') FROM DUAL;

SELECT RPAD(NAME, 6, '_') FROM MEMBER;  -- 이름이 2글자면 _로 채워서 조회

-- 첫 글자를 대문자로 치환
-- INITCAP(문자열)
SELECT INITCAP('the ....') FROM DUAL;
SELECT INITCAP('the most important thing is ....') FROM DUAL;
SELECT INITCAP('the most im하이portant t오케이hing is ....') FROM DUAL;

-- 문자열 위치 검색 함수
-- INSTR(문자열, 검색문자열, 위치, 순번)
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO') FROM DUAL;   -- 첫번째로 검색되는 TO의 위치 조회
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO', 15) FROM DUAL;   -- 15번째 이후로 검색되는 TO의 위치 조회
SELECT INSTR('ALL WE NEED TO IS JUST TO...', 'TO', 1, 2) FROM DUAL; -- 두번째 검색되는 TO의 위치 조회

SELECT INSTR(PHONE, '-', 1, 2) FROM MEMBER; -- 전화번호에서 두번째 -문자가 존재하는 위치 조회
SELECT INSTR(PHONE, '-', 1, 2) - INSTR(PHONE, '-') - 1 FROM MEMBER; -- 전화번호에서 첫번째 -문자와 두번째 -문자 사이의 간격 조회
SELECT SUBSTR(PHONE, INSTR(PHONE, '-')+1, INSTR(PHONE, '-', 1, 2)-INSTR(PHONE, '-')-1) FROM MEMBER; 전화번호에서 첫번째 -문자와 두번째 -문자 사이의 국번 조회

-- 문자열 길이를 얻는 함수
-- LENGTH(문자열)
-- LENGTHB(문자열)
SELECT LENGTH('WHERE WE ARE') FROM DUAL;

SELECT PHONE, LENGTH(PHONE) FROM MEMBER;    -- 핸드폰 번호와 번호의 길이를 조회
SELECT LENGTH(REPLACE(PHONE, '-', '')) FROM MEMBER; -- 핸드폰 번호에서 -문자를 없앤 번호의 길이를 조회

-- 코드 값을 반환하는 함수
-- ASCII(문자)
SELECT ASCII('A') FROM DUAL;

-- 코드 값으로 문자를 반환하는 함수
-- CHR(코드값)
SELECT CHR(65) FROM DUAL;


