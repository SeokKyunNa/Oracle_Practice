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


--025 number function
-- 절대값을 구하는 함수
-- ABS(숫자)
SELECT ABS(35), ABS(-35) FROM DUAL;

-- 음수/양수를 알려주는 함수
-- SIGN(숫자), 양수=1, 음수=-1, 0=0
SELECT SIGN(35), SIGN(-35), SIGN(0) FROM DUAL;

-- 반올림 함수
-- ROUND(숫자, 소수점자릿수), 소숫점자릿수를 입력하지 않으면 소숫점 첫번째에서 반올림
SELECT ROUND(34.456789), ROUND(34.56789) FROM DUAL;
SELECT ROUND(34.456789, 2), ROUND(34.456789, 3) FROM DUAL;

-- 나눗셈 몫을 반환하는 함수
-- TRUNC(분자/분모)
-- 나눗셈 나머지를 반환하는 함수
-- MOD(분자, 분모)
SELECT TRUNC(17/5) 몫, MOD(17, 5) 나머지 FROM DUAL;

-- 숫자의 제곱을 구하는 함수
-- POWER(숫자, 제곱수)
--숫자의 제곱근을 구하는 함수
-- SQRT(숫자)
SELECT POWER(5, 2), SQRT(25) FROM DUAL;


--026 date function
-- SYSDATE  서버의 년/월/일
-- CURRENT_DATE 사용자 세션에 설정된 년/월/일
-- SYSTIMESTAMP 서버의 년/월/일 시분초.밀리세컨드
-- CURRENT_TIMESTAMP    사용자 세션에 설정된 년/월/일 시분초.밀리세컨드
SELECT SYSDATE, CURRENT_DATE, SYSTIMESTAMP, CURRENT_TIMESTAMP FROM DUAL;

-- 세션 시간과 포맷 변경
ALTER SESSION SET TIME_ZONE = '09:00';  --  GMT 그리니치 평균시 기준으로 +9시간 : 한국 KST 시간대
ALTER SESSION SET TIME_ZONE = '-08:00';  -- GMT 그리니치 평균시 기준으로 -8시간
-- NLS : National Language Support 
ALTER SESSION SET NSL_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- 날짜 추출 함수
-- EXTRACT(YEAR/MONTH/DAY/HOUR/MINUTE/SECOND FROM [컬럼명])
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL;
-- 위의 세션 포맷 변경 후 조회 가능
SELECT EXTRACT(MINUTE FROM SYSDATE) FROM DUAL;
SELECT EXTRACT(SECOND FROM SYSDATE) FROM DUAL;

SELECT * FROM MEMBER WHERE EXTRACT(MONTH FROM REGDATE) IN (02, 03, 11, 12);  -- 2, 3, 11, 12월에 가입한 회원 조회

-- 날짜 누적 함수
-- ADD_MONTHS(날짜, 정수)
SELECT ADD_MONTHS(SYSDATE, 1) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, -2) FROM DUAL;
SELECT * FROM MEMBER WHERE REGDATE > ADD_MONTHS(SYSDATE, -6);   -- 가입한지 6개월이 되지 않은 회원 조회
SELECT * FROM MEMBER WHERE REGDATE <= ADD_MONTHS(SYSDATE, -6);   -- 가입한지 6개월이 넘은 회원 조회

-- 날짜의 차이를 알아내는 함수
-- MONTHS_BETWEEN(날짜, 날짜)
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2013-12-25')) FROM DUAL;
SELECT * FROM MEMBER WHERE MONTHS_BETWEEN(SYSDATE, REGDATE) < 6;    -- 가입한지 6개월이 되지 않은 회원 조회
SELECT * FROM MEMBER WHERE MONTHS_BETWEEN(SYSDATE, REGDATE) >= 6;   -- 가입한지 6개월이 넘은 회원 조회

-- 다음 요일을 알려주는 함수
-- NEXT_DAY(현재날짜, 다음요일)
SELECT NEXT_DAY(SYSDATE, '월요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '화') FROM DUAL;
-- 일요일이 1 ~ 토요일이 7
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;

-- 월의 마지막 일자를 알려주는 함수
-- LAST_DAY(날짜)
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(ADD_MONTHS(SYSDATE, -2)) FROM DUAL;

-- 지정된 범위에서 날짜를 반올림하는/자르는 함수 ROUND/TRUNC(날짜, 포맷)
SELECT SYSDATE, ROUND(SYSDATE, 'CC'), TRUNC(SYSDATE, 'CC') FROM DUAL;    -- 1세기(100년 단위)
SELECT SYSDATE, ROUND(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;    -- 년 단위
SELECT SYSDATE, ROUND(SYSDATE, 'Q'), TRUNC(SYSDATE, 'Q') FROM DUAL;  -- 분기 단위
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL;  -- 월 단위
SELECT SYSDATE, ROUND(SYSDATE, 'W'), TRUNC(SYSDATE, 'W') FROM DUAL;  -- 주 단위
SELECT SYSDATE, ROUND(SYSDATE, 'DAY'), TRUNC(SYSDATE, 'DAY') FROM DUAL;  -- 일 단위
SELECT SYSDATE, ROUND(SYSDATE, 'D'), TRUNC(SYSDATE, 'D') FROM DUAL; -- 일 단위(일주일 기준)
SELECT SYSDATE, ROUND(SYSDATE, 'HH'), TRUNC(SYSDATE, 'HH') FROM DUAL;   -- 시간 단위
SELECT SYSDATE, ROUND(SYSDATE, 'MI'), TRUNC(SYSDATE, 'MI') FROM DUAL;   -- 분 단위


--027   CASTING FUNCTION
-- 숫자 - TO_CHAR() - 문자열 - TO_DATE() 날짜
-- 날짜 - TO_CHAR() - 문자열 - TO_NUMBER() 숫자

-- NUMBER 형식을 문자열(VARCHAR2)로 변환
-- TO_CHAR(NUMBER, FORMAT)
-- 포맷은 숫자의 길이보다 길어야 함
-- 포맷문자
-- 9 : 숫자
-- 0 : 빈자리를 채우는 문자
-- $ : 앞에 $ 표시
-- , : 천 단위 구분자 표시
-- . : 소수점 표시
SELECT TO_CHAR(12345678, '$99,999,999,999.99') FROM DUAL;
SELECT 123 || 'HELLO' FROM DUAL;
SELECT TO_CHAR(123) || 'HELLO' FROM DUAL;
SELECT TO_CHAR(12345678, '99,999,999') || 'HELLO' FROM DUAL;
SELECT TO_CHAR(1234567890, '99,999,999') || 'HELLO' FROM DUAL;  -- 입력 숫자가 포맷보다 길면 올바르지 않은 형식으로 표현 됨
SELECT TO_CHAR(1234567890, '009,999,999,999') || 'HELLO' FROM DUAL; -- 포맷0은 포맷보다 입력 숫자가 짧으면 0으로 채워줌
SELECT TO_CHAR(1234567890, '999,999,999,999') || 'HELLO' FROM DUAL;
SELECT TO_CHAR(1234567890, '999,999,999,999') || '원' FROM DUAL;
SELECT TRIM(TO_CHAR(1234567890, '999,999,999,999')) || '원' FROM DUAL;

SELECT TO_CHAR(1234567.12345, '9,999,999,999.9999') || '원' FROM DUAL;   -- 소수점은 표현 가능한 자릿수 하나 아래에서 반올림
SELECT TO_CHAR(1234567.1, '9,999,999,999.9999') || '원' FROM DUAL;   -- 소수점은 포맷길이만큼 0으로 채워져서 표현됨

-- DATE 형식으로 문자열(VARCHAR2)로 변환
-- TO_CHAR(DATETIME)
-- 포맷문자
-- YYYY/RRRR/YY/YEAR : 년도표시 - 4자리/Y2K/2WKFL/영문
-- MM/MON/MONTH : 월표시 - 2자리/영문3자리/영문전체
-- DD/DAY/DDTH : 일표시 - 2자리/영문/2자리ST
-- AM/PM : 오전/오후 표시
-- HH/HH24 : 시간표시 - 12시간/24시간
-- MI : 분표시 - 0~59
-- SS : 초표시 - 0~59
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'RRRR-MONTH-DDTH HH:MI:SS') FROM DUAL;

-- 문자열을 날짜 형식으로 변환하는 함수
-- TO_DATE(문자열, 날짜포맷)
SELECT TO_DATE('2002-01-01', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2002-01-01', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- 문자열을 날짜형식으로 변환하는 함수2
-- TO_TIMESTAMP(문자열)
SELECT TO_TIMESTAMP('2002-01-01', 'YYYY-MM-DD HH:MI:SS') FROM DUAL;

-- 문자열을 숫자 형식으로 변환하는 함수
-- TO_NUMBER(문자열)
SELECT TO_NUMBER('2020') FROM DUAL;
SELECT TO_NUMBER('2') + 3 FROM DUAL;


--028 NULL FUNCTION
-- 반환값이 NULL일때 대체 값을 제공하는 함수
-- NVL(컬럼명(NULL), 대체값)
SELECT NULL + 3 FROM DUAL;
SELECT AGE + 3 FROM MEMBER;
SELECT NVL(GENDER, 0) FROM MEMBER;
SELECT TRUNC(NVL(AGE, 0)/10) * 10 연령대 FROM MEMBER;

-- NVL에서 조건을 하나 더 확장한 함수
-- NVL2(컬럼명(NULL), NOTNULL 대체값, NULL 대체값)
SELECT NVL2(AGE, TRUNC(AGE/10)*10, 0) 연령대2 FROM MEMBER;

-- 두 값이 같은 경우 NULL, 다른 경우 첫 번째 값 반환 함수
-- NULLIF(값1, 값2)
SELECT NAME, NULLIF(AGE, 40) FROM MEMBER;

-- 조건에 따른 값을 선택하는 함수
-- DECODE(기준값, 비교값, 출력값, 나머지 출력값)
SELECT DECODE(PWD, 
            '111', '일일일', 
            '222', '이이이', 
            '333', '삼삼삼',
            '기타') FROM MEMBER;


--029   SELECT, ORDER BY
-- SELECT 구절의 순서(바뀌면 안 됨)
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY
-- FROM : 데이터 가공을 위해 데이터를 연산하는 공간
-- WHERE : 조건 필터링
-- GROUP BY : 데이터 집계 (COUNT, AVG)
-- HAVING : 집계된 결과를 필터링
-- ORDER BY : 정렬

-- ORDER BY 정렬 : ASC(오름차순, DEFAULT, 생략 가능), DESC(내림차순)
SELECT * FROM MEMBER ORDER BY NAME; -- 이름을 오름차순으로 정렬해서 조회
SELECT * FROM MEMBER ORDER BY NAME DESC; -- 이름을 역순(내림차순)으로 정렬해서 조회
SELECT * FROM MEMBER WHERE NAME LIKE '박%' ORDER BY AGE; -- 회원 중에서 '박'씨 성을 가진 회원을 나이 오름차순으로 정렬하여 조회

SELECT * FROM NOTICE ORDER BY HIT DESC, REGDATE DESC;   -- 조회수 내림차순 조회하고 조회수가 같으면 등록일자 내림차순 조회


--030   AGGREGATE FUNCTION
-- SUM(합), MIN(최소값), MAX(최대값), COUNT(수), AVG(평균)
-- COUNT - NULL을 제외한 개수
-- 전체 데이터의 수를 구하려면 NOT NULL 조건인 컬럼으로 조회하거나, *를 조회(시간이 오래 걸릴 수 있음)
SELECT * FROM NOTICE;
SELECT COUNT(TITLE) FROM NOTICE;
SELECT COUNT(*) FROM NOTICE;

SELECT SUM(HIT) 합, AVG(HIT) 평균 FROM NOTICE;
SELECT WRITER_ID, COUNT(ID) COUNT FROM NOTICE GROUP BY WRITER_ID;
SELECT WRITER_ID, COUNT(ID), TITLE FROM NOTICE GROUP BY WRITER_ID;   -- 오류 : 집계 기준값 외의 컬럼은 포함할 수 없음

SELECT WRITER_ID, COUNT(ID) COUNT FROM NOTICE GROUP BY WRITER_ID ORDER BY COUNT DESC, WRITER_ID;

-- **SELECT문의 실행 순서 : FROM > WHERE > GROUP BY > HAVING > ORDER BY > SELECT
-- SQL문은 내려쓰기하여 보기 편하게 정렬


--031   AGGREGATE FUNCTION(HAVING)
-- WHERE 절에서는 집계 함수를 사용할 수 없음
-- **SELECT문의 실행 순서에 의해서 집계 함수는 WHERE절에 사용할 수 없음
SELECT WRITER_ID, COUNT(ID) FROM NOTICE WHERE COUNT(ID) < 2 GROUP BY WRITER_ID;    -- 오류
SELECT WRITER_ID, COUNT(ID) FROM NOTICE GROUP BY WRITER_ID HAVING COUNT(ID) < 2; -- 게시글 수가 2 이하인 회원별 게시글 수 조회


--032   RANKING FUNCTION
-- **ROWNUM은 WHERE절에서 생성됨
SELECT ROWNUM, ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE ORDER BY HIT; -- HIT에 의해 정렬되면서 미리 정의된 ROWNUM의 순서가 바뀜

-- 정렬된 후에 ROWNUM을 붙이는 함수
-- ROW_NUMBER()
SELECT ROW_NUMBER() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- 정렬된 후에 등수를 매기는 함수(중복 허용) EX) 1, 2, 3, 3, 5, 6, ..
-- RANK()
SELECT RANK() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- 정렬된 후에 등수를 매기는 함수(중복 후 등수를 건너뛰지 않음) EX) 1, 2, 3, 3, 4, 5, 6, ...
-- DENSE_RANK()
SELECT DENSE_RANK() OVER (ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
-- 옵션 OVER (ORDER BY 컬럼) - 정렬 후 ROWNUM을 매김
-- 옵션 OVER (PARTITION BY 컬럼1 ORDER BY 컬럼2) - 컬럼1별로 묶어서 ROWNUM을 매길 수 있음, 컬럼1에 대하여 오름차순으로 자동 정렬
SELECT ROW_NUMBER() OVER (PARTITION BY WRITER_ID ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;
SELECT DENSE_RANK() OVER (PARTITION BY WRITER_ID ORDER BY HIT), ID, TITLE, WRITER_ID, REGDATE, HIT FROM NOTICE;


--033   SUB QUERY
SELECT * FROM NOTICE WHERE ROWNUM BETWEEN 1 AND 5;
-- 정렬한 결과에서 상위의 결과를 원하는 경우
-- 정렬한 결과를 서브쿼리로 사용
-- FROM절에 서브쿼리를 입력
SELECT * FROM(
SELECT * FROM NOTICE ORDER BY REGDATE DESC
) WHERE ROWNUM BETWEEN 1 AND 5;

SELECT * FROM MEMBER WHERE AGE >= (SELECT AVG(AGE) FROM MEMBER); -- 평균 나이 이상인 회원을 조회


--034   INNER JOIN
-- 조인의 종류
-- INNER JOIN, OUTER JOIN, SELF JOIN, CROSS JOIN(Cartesian Product)
-- 서로 참조하는 테이블을 합쳐서 조회하는 방법
-- 기준이 되는 쪽(보통은 수가 더 적은 쪽)이 부모 테이블이 됨 EX) 회원정보=부모테이블, 게시판(작성자)=자식테이블

-- 서로 관계 있는 레코드들만 합치는 조인을 INNER JOIN이라고 함
-- ON절에 기준 컬럼 작성
SELECT * FROM MEMBER;
SELECT * FROM NOTICE;
SELECT * FROM MEMBER INNER JOIN NOTICE ON MEMBER.ID = NOTICE.WRITER_ID; -- ANSI SQL 표준 INNER JOIN 방법


--035   OUTER JOIN
-- 서로 관계 없는 레코드들도 포함시키는 조인을 OUTER JOIN이라고 함
-- LEFT OUTER JOIN : 왼쪽 테이블의 OUTER 데이터를 포함시킴
-- RIGHT OUTER JOIN : 오른쪽 테이블의 OUTER 데이터를 포함시킴
-- FULL OUTER JOIN : 양쪽 테이블의 OUTER 데이터를 포함시킴

-- INNER JOIN이 기본값이기때문에 JOIN만 쓰면 INNER JOIN으로 처리됨
SELECT * FROM NOTICE N JOIN MEMBER M ON N.WRITER_ID = M.ID;
-- OUTER JOIN
SELECT * FROM NOTICE N LEFT OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;
SELECT * FROM NOTICE N RIGHT OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;
SELECT * FROM NOTICE N FULL OUTER JOIN MEMBER M ON N.WRITER_ID = M.ID;


--036   USING OUTER JOIN
SELECT WRITER_ID, COUNT(WRITER_ID) FROM NOTICE GROUP BY WRITER_ID;
SELECT * FROM MEMBER;

-- 회원별 작성한 게시글 수 조회
SELECT M.ID, M.NAME, COUNT(N.ID) FROM MEMBER M JOIN NOTICE N ON M.ID = N.WRITER_ID GROUP BY M.ID, M.NAME;   -- 작성 게시글이 0인 회원은 조회되지 않음
SELECT M.ID, M.NAME, COUNT(N.ID) FROM MEMBER M LEFT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID GROUP BY M.ID, M.NAME;    -- 정상 조회
-- 기준이 되는 왼쪽의 데이터는 모두 출력하고 관계있는 데이터를 오른쪽에 JOIN하여 합치는게 JOIN문의 기본


--037  SELF JOIN
-- 본인테이블과 본인테이블간의 JOIN
-- 데이터가 서로 포함 관계를 가지는 경우에 사용 EX) 멤버들간의 상관관계
-- 대댓글, 카테고리 등에서 자주 사용 됨
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

-- FULL OUTER JOIN은 지원하지 않음
-- CROSS JOIN
-- 두 테이블의 곱하기 데이터를 보여줌
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N CROSS JOIN MEMBER M;   -- ANSI SQL
SELECT N.*, M.NAME WRITER_NAME FROM NOTICE N, MEMBER M;    -- ORACLE JOIN


--039   UNION
-- RECORE(DATA)를 합칠 때 사용
-- 각기 다른 테이블의 데이터를 통합 조회할 때 사용 EX) 다양한 게시판의 통합 검색

-- UNION ALL : 중복 상관없이 통합 조회
-- UNION : 중복 데이터는 하나만 조회하여 통합 조회
-- MINUS : 앞의 데이터에서 뒤의 데이터를 빼고 남은 데이터만 조회
-- INTERSECT : 중복 데이터만 조회

SELECT ID, NAME FROM MEMBER UNION SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER UNION ALL SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER MINUS SELECT WRITER_ID, TITLE FROM NOTICE;
SELECT ID, NAME FROM MEMBER INTERSECT SELECT WRITER_ID, TITLE FROM NOTICE;

SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%n%' UNION SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%g%';
SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%n%' MINUS SELECT ID, NAME FROM MEMBER WHERE ID LIKE '%g%';


--040 VIEW
-- 복잡한 쿼리문을 VIEW로 생성해서 편리하게 사용할 수 있음
-- 물리적인 데이터구조(TABLE), 개념적인 데이터구조(VIEW)

-- 게시글 작성자의 이름과 게시글의 댓글 수를 함께 보는 쿼리문
CREATE VIEW NOTICEVIEW AS
SELECT N.ID, N.TITLE, N.WRITER_ID, M.NAME WRITER_NAME, COUNT(C.ID) CNT
FROM MEMBER M RIGHT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID
LEFT OUTER JOIN "COMMENT" C ON N.ID = C.NOTICE_ID
GROUP BY N.ID, N.TITLE, N.WRITER_ID, M.NAME;

-- 위 쿼리의 VIEW 생성문
CREATE VIEW NOTICEVIEW AS
SELECT N.ID, N.TITLE, N.WRITER_ID, M.NAME WRITER_NAME, COUNT(C.ID) CNT
FROM MEMBER M RIGHT OUTER JOIN NOTICE N ON M.ID = N.WRITER_ID
LEFT OUTER JOIN "COMMENT" C ON N.ID = C.NOTICE_ID
GROUP BY N.ID, N.TITLE, N.WRITER_ID, M.NAME;

SELECT * FROM NOTICEVIEW;


--041 DATA DICTIONARY
-- Data Dictionary : 사용자 정보, 권한, 테이블/뷰, 제약조건, 함수/프로시저 등등을 DBMS에서 저장하는 공간
-- 최근에는 툴을 사용하여 손쉽게 조회 가능
-- Data Dictionary는 VIEW 형태로 보여줌 (직접 테이블에 접근하지 못 하게 하기 위한 보안 목적)
-- DBA_, ALL_, USER_ : 권한에 따른 네이밍
SELECT * FROM DICT;
SELECT * FROM USER_TABLES;  -- 테이블 조회
SELECT * FROM USER_TAB_COLUMNS WHERE TABLE_NAME = 'MEMBER'; -- 테이블 컬럼 조회


--042   CONSTRAINT
-- 데이터 입력에 제한을 둠
-- 도메인 > 엔티티 > 릴레이션 제약조건
-- 도메인 : 컬럼의 유효한 값의 범위 EX) 0보다 큰 정수, 20자 내의 문자 등
-- 속성에 도메인이 아닌 값이 올 수 없도록 하는 제약조건

-- NOT NULL : NULL을 허용하지 않음
-- DEFAULT : 값이 없으면 기본값을 넣음
-- CHECK : 값의 유효 범위(도메인 범위)를 체크

-- 테이블 생성할 때 NOT NULL 제약 조건 적용
CREATE TABLE TEST(
    ID VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(200) NULL,
    PHONE CHAR(13) NOT NULL
)

-- 테이블 생성 후 NOT NULL 제약 조건 적용 (기존 데이터에 NULL이 존재하면 불가)
ALTER TABLE TEST MODIFY EMAIL VARCHAR2(200) NOT NULL;

-- 테이블 생성할 때 DEFAULT 제약 조건 적용
CREATE TABLE TEST(
    ID VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(200) NULL,
    PHONE CHAR(13) NOT NULL,
    PWD VARCHAR2(200) DEFAULT '111' 
)

-- 테이블 생성 후 DEFAULT 제약 조건 적용
ALTER TABLE TEST MODIFY EMAIL VARCHAR2(200) DEFAULT '111';
-- **툴 이용 시 접속 리스트의 테이블을 SQL 워크시트에 드래그하면 자동으로 기본 쿼리문을 생성할 수 있음

