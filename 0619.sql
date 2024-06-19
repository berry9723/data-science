-- 추출하는 방법 (SELECT,FROM, WHERE을 사용한다)
-- FROM 어디에서 추출할지 알려준다 
--SELECT: 열을 추출해준다
-- FROM: 행을 추출해준다 
-- 실행은 FROM부터 된다 FROM+테이블명, TB_EMP에 200개 있는데 다 가져올꺼야? NO!
-- 그냥 번외: 모델링설계서에서 각 표의 의미를 이해할 수 있음 
SELECT ENAME, GENDER, EDU_LEVEL
    FROM TB_EMP
WHERE POS_CD = 'P009';

--실습문제(15P) -- 가급적이면 띄어쓰여서 적는 게 더 가독성이 좋다 
-- 순서: from부터 적고 그 다음 윗 줄에 select를 적는다 
SELECT ENAME,
    , SERVICE_YEAR
    , EDU_LEVEL
    , SALARY
FROM TB_EMP; -- 사원 테이블에서 가져온다

SELECT PAYMENT_DY -- 지급일자
    , PAYMENT_DVCD -- 디바이스 코드
    , PAYMENT_AMOUNT -- 지급액
FROM TB_sALARY_PAYMENT;

-- SHIFT F4하면 표의 정보를 볼 수 있다 
SELECT POS_NAME
  FROM TB_EMP;
  
-- SELECT*FROM TB_eMP 테이블 안에서 모든 컬럼의 정보를 출력한다 
SELECT * FROM TB_EMP;

-- 실습에서 *는 잘 사용하지 않습니다 
-- *를 에스터리스크?라고 불리나봐 
-- 웬만하면 필요로 하는 데이터를 나열하는 게 좋다 

-- SELECT DISTINCT
SELECT EDU_LEVEL
  FROM TB_eMP;
-- 갯수를 파악하진 못하는가 : 질문 >> 그냥 중복 체크만!
SELECT DISTINCT EDU_LEVEL
  FROM TB_eMP;

-- SELECT DISTINCT EDU_LEVEL, GENDER 이렇게 두 개는 못 쓰이나?
-- 쓸 수는 있는데 웬만해서는 안쓰인다 그냥 하나만 쓰인다 
SELECT DISTINCT ENAME
     , SERVICE_YEAR
     , EDU_LEVEL
     , SALARY
   FROM TB_eMP;
   
   -- 실습문제(28P)
SELECT DISTINCT RETIRE_REASON
FROM TB_EMP;

-- AS 부분
--원래는 EID인데 직원 ID로 새로운 별명을 부여해주는 거
-- 근데 직원 ID로 영구 변환 놉 , 그냥 별명만 
-- 별명 지을 때 띄어쓰기로 적용 노놉
-- AS 다시보기 >> 엥?

-- NULL은 아직 정해지지 않았습니다 > 빈 공간이라는 뜻

-- ACTIVE STATE: 재직 여부 (그럼 퇴사 여부는 없는 거겠쥬?)
-- 그래서 재직 자 칸에 퇴사 여부칸에 NULL이 있다 
-- 빈칸인 데이터는 없다, 무조건 빈칸이면 NULL로 채워진다 

-- 36P
-- 사칙연산하기 
-- SELECT에 리터럴(숫자)사용하기
-- SELCT는 행으로(매 튜플마다) 20번으로 실행 된 것이다 (열이 아니라 행으로 쭈루루 나온다)
SELECT EID
    , ENAME
    , AGE
    , 1000
    , SALARY
    , SALARY + 1000 AS 희망연봉
    , SALARY - 1000
  FROM TB_EMP ;
  
-- 40P SALARY*0.3이라고 적어야 돼 성과급이라고 적으면 안돼 
-- 최종지급액을 두 가지 버젼으로 나타낼 수 있다 (최종지급액, 최종지급액02)
SELECT EID
     , ENAME
     , SALARY
     , SALARY * 0.3 AS 성과급
     , SALARY + (SALARY*0.3) AS 최종지급액 
     , SALARY *1.3 AS 최종지급액02
  FROM TB_eMP; 
  
-- 연결 연산은 패스하겠다 

-- 함수 활용 46P
-- 함수란 입력값에 특정 블랙 박스가 있고 그 박스를 지나쳐 출력값이 나온다 
-- 블랙박스가 어떻게 만들어져 있는지 알 필요는 없다 
-- 입력, 출력, 기능만 알면된다(48P)
-- 여러 함수가 있지만 단일 함수를 배워보겠다 
-- 내장형 함수가 진~~짜 많은데 그 중에서 50P 소수의 친구들만 데려왔다 

--01. 문자형 함수: SUBSTAR, REPLACE
-- 내장형 중 SUBSTAR 함수  
-- 20240601인데 2024만 못 뽑나.?
SELECT PAYMENT_DY
      , SUBSTR(PAYMENT_DY, 1, 4) AS 연도만
   FROM TB_sALARY_PAYMENT; 
      -- SUBSTER 입력값이 3개 들어가는 함수 (페이먼트랑 1과 3) 
      -- PAYMENT_DY에서 1번째부터 4개 뽑으라는 의미이다 

-- 내장형 중 REPLACE 함수 
-- 전화번호 입력 (- 제외하고 입력) 인 경우 있다 
SELECT REPLACE ('010-1231-1231' , '-', '') 
FROM DUAL; 

SELECT EDU_LEVEL
    , REPLACE(EDU_LEVEL, ' ', '')
    -- 띄어쓰기 ' ', 공백 없음''
FROM TB_eMP;

-- 실슴문제 53P

-- 안되는 경우:
SELECT PAYMENT_DY
      , SUBSTR(PAYMENT_DY, 1, 6) AS 지급연월
      , PAYMENT_DVCD AS 지급구분
      , SUM(PAYMENT_AMOUNT) AS 연월별지급구분별합계
FROM TB_SALARY_PAYMENT
GROUP BY SUBSTR(PAYMENT_DY, 1, 6), PAYMENT_DVCD
ORDER BY 1,2 ; 

-- 되는 경우: 
-- 우선 " SELECT * FROM TB_sALARY_PAYMENT "를 돌려서 데이터 정보를 먼저 훑어본다 
-- 줄인대상을 그룹화 하겠다 :GROUP BY 
-- ORDER BY는 정렬 하는 명령어 > 나중에 설명하겠다 
SELECT SUBSTR(PAYMENT_DY, 1, 6) AS 지급연월
      , PAYMENT_DVCD AS 지급구분
      , SUM(PAYMENT_AMOUNT) AS 연월별지급구분별합계
FROM TB_SALARY_PAYMENT
GROUP BY SUBSTR(PAYMENT_DY, 1, 6), PAYMENT_DVCD
ORDER BY 1,2 ;

-- 실습문제 54P 
-- 함수의 중첩이라는 내용을 넣겠다 
-- 공백이 있으면 데이터 전처리하기 어렵다 
-- UPPER함수를 이용하여 대문자로 바꾼다 
-- REPLACE를 여러번 하는 건 데이터 질이 막 떨어지진 않는다 
-- 데이터가 너무 길어지면 가독성이 안좋을 순 있다 > 근데 REPLACE 그냥 써~ 
SELECT ENAME
     , UPPER(REPLACE (REPLACE(SKILLS, ' ', ''), ',', '#')) 
FROM TB_EMP;


-- 67P 복붙
SELECT TO_NUMBER('1') FROM DUAL ; -- 문자형('1')을 숫자형(1) 로 형변환해 출력 ​
--- 문자 처리를 된 1을 숫자 1로 바꾸겠다 
-- SELECT TO_NUMBER('1살') FROM DUAL ;
-- 1살을 1로 바꾸지 못한다 위에는 오류가 뜬다 
​

SELECT TO_CHAR(1) FROM DUAL ;       --숫자형(1)을 문자형('1') 로 형변환해 출력 ​

​SELECT SYSDATE FROM DUAL;

SELECT TO_CHAR(SYSDATE , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL ; ​

​

SELECT TO_CHAR(SYSDATE , 'YYYYMMDD') FROM DUAL ;​

​
-- 투데이트는 아예 다르지 문자를 날짜형으로 바꾸는 거 
SELECT TO_DATE('20230101' , 'YYYY/MM/DD') FROM DUAL ; ​

-- 시간까지 넣고 싶어 : 14시도 넣을래 위에 문장에서 14만 추가한거
SELECT TO_DATE('2023010114' , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL ; 
​
-- YYYY 연도 4자리
-- MM 월 2자리 (01월 > 01)
-- DD 일 2자리 (1일-01)
-- HH24:시간을 24시간(0-23) // 그냥 HH: 12시간제(0-11)
-- MI: 분 (0-59)
-- SS : 초 (0-59)
-- 테스트용 더비데이터 : 
SELECT * FROM DUAL; 
SELECT SUBSTR ('010-1111-1111', 1,3) FROM DUAL; -- 그냥 값을 도출 할 때 뒤에 쓰는 거  영향 X

SELECT TO_DATE('20230101141212' , 'YYYY/MM/DD HH24:MI:SS') FROM DUAL; 

-- 68P 문제 -- 연월까지 나타내는 정보르 알고 싶다 >> WLFANS 
SELECT ENAME
      , HIRE_DATE
      , TO_CHAR (HIRE_dATE, 'YYYY') AS 입사연도
      , TO_CHAR (HIRE_DATE, 'YYYYMM') AS 입사연월
FROM TB_EMP
WHERE ACTIVE_sTATE= 'Y'; 

-- 71ㅔ 
-- 투챠를 강제형 변환이라고 한댜 자동형 변환도 잇구..!
-- 72P 질문

-- 하나라도 NULL이 들어가면 계산이 불가하다
-- AGE+1을 하고 싶은데 20 >21 이지만 NULL > NULL이다 
-- 그래서 NULL값을 대체하자 빈값을 대체하는 방법을 알자 74P
-- NVL 함수 (DATA1, DATA2)
-- NULL이면 DATA2로 바꾸겠다, NULL이 아니면 그대로 데이터1 쓰겟다 
-- 윗 문장 예시가 아래 ! 
-- 76P
SELECT EID
    , ENAME 
    , NVL(RETIRE_REASON, '재직중') AS 퇴사여부
 FROM TB_EMP
 WHERE POS_CD = 'P009';
 
 -- 77P
 -- DECODE는 IF 느낌인데 아래 보면 마지막에 그렇지 않는 경우 ELSE를 끝에 붙여준다
 -- 그러니까 FLOOR(버림함수)안에 2,3,4,5가 아니면 60대이상으로 간다 
 SELECT EID
      , ENAME
      , DECODE( RETIRE_DATE, NULL, '재직중', RETIRE_REASON) AS 퇴사이유
      , AGE 
      , DECODE( FLOOR(AGE/10), 2, '20대', 3, '30대',
                               4, '40대', 5, '50대',
                               6, '60대', '60대이상' ) AS 나이대 
FROM TB_eMP;

-- NVL을 많이 쓰고 DECODE는 중급자들이 마니 쓴다 
-- 그래서 NVL을 사용할 때 CASE를 사용한다 
-- DECODE는 축약인데 CASE와 함께 NVL을 직관적으로 알 수 있다 
-- 마지막에 END를 넣어야 한다 

-- 실습문제 79P 
SELECT * FROM TB_EMP_ATTE;
-- 82P 정답
SELECT EID
     , ATTE_STATE
     , STS_DT
     , END_DT
     , NVL(REASON, '출근') AS 근태사유
FROM TB_eMP_ATTE; 
-- 80P 실습 문제 
-- DECODE (UPPER(DATA1:큰 함수), CHINA(DATA2), 중국(DATA3), 나머지(DATA4- 이 친구는 써도 되고 안써도되고 ELSE 느낌이다)
-- 그니까 DATA1 큰 조건에서 CHINA라는 DATA2랑 같으면 DATA3라는 중국을 출력하는 거다 
SELECT * FROM TB_eMP;
SELECT ENAME
     , NATION
     , DECODE( UPPER(NVL(NATION, 'KOREA')), 'CHINA', '중국'
                                          , 'KOREA', '한국'
                                          , 'USA', '미국'
                                          , 'INDIA', '인도'
                                          , 'UK', '영국'
                                          ,'JAPAN', '일본'
                                          , '나머지'
               ) AS 국적한글로
FROM TB_eMP; 

-- 실습문제 81P
-- 답지 확인하기

SELECT EID
    , ENAME 
    , POS_CD
    , TRAINING_HOURS
    , CASE WHEN TRAINING_HOURS>=40 THEN '발급가능'
           WHEN TRAINING_HOURS<40 THEN '발급불가능'
      END AS 이수증발급여부
FROM TB_eMP;
