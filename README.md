# SQL-practice
Oracle 연습 공간입니다.
Oracle SQL Developer로 hr 계정에 연결하여 연습합니다.
### 연산자
  - 산술연산자
    - +, -, *, /
  - 조건 연산자
    -  >= , <, <= , =(같다) , <> (같지않다) , !=(같지않다).
  - 논리연산자
    - and, or, not
  - 기타 연산자
    - between () and ()
    - in (value, value)
    - like ('%', '_')
    - is null, is not null
# Oracle

# 오라클 내장함수

1. 단일행 함수
    - 문자함수

        lower(column or exp) -소문자로

        upper(column or exp) -대문자로

        substr(column or exp, beginIndex, length) -java와는 다르다.

        substr(column or exp, beginIndex) - 

        concat(column or exp, column or exp) -두 문자를 합친다.

        length(column or exp) - 글자수를 반환 공백포함

        instr(column or exp, 'string') -검색된 문자의 index를 반환

        instr(column or exp, 'string',beginIndex)

        instr(column or exp, 'string',beginIndex, count)

        lpad(coloumn or exp, length, 'string')

        rpad(coloumn or exp, length, 'string')

        trim(column or exp) -공백 제거

        replace(column or exp, 'search_string', 'replacement_string')

    - 숫자함수

        round(column or exp)

        round(column or exp,n)

        trunc(column or exp)

        trunc(column or exp,n)

        ceil(column or exp)

        floor(column or exp)

        mod(m,n) — 나머지 구하는 연산자.

    - 날짜함수

        sysdate

        날짜 + 숫자

        날짜 - 숫자

        날짜 - 날짜

        round(날짜)

        trunc(날짜)

        months_between(날짜, 날짜)

        add_months(날짜, 숫자)

    - 변환함수 (묵시적 타입변환, 명시적 타입변환)

        to_char(value, 'format')

        to_date(value, 'format')

        YYYYMMDDAMHHMISS

        to_number(value, 'pattern')

        9 : 숫자를 나타낸다

        0 : 숫자를 나타낸다

        $ : 달러 기호를 나타낸다.

        .  :  소숫점을 나타낸다.

        ,   :  자릿수를 나타낸다.

        L  :  해당지역의 통화로 나오게 한다.

    - 기타함수 (nvl, case, decode)
        - nvl (null value column, value)
        - case (java if)

                select column1, column2,
                  case column3
                      when 값1 then 반환값1
                      when 값2 then 반환값2
                      when 값3 then 반환값3
                      else 반환값 4
                  end
                from table

        - decode (java switch)

                select column1, column2,
                  decode(column3, 비교값1, 반환값1,
                                  비교값2, 반환값2,
                                  비교값3, 반환값3
                                  반환값4)
                from talble;

2. 다중행 함수(그룹함수)
    - 조회된 행을 그룹으로 묶고 그룹당 하나의 결과를 반환
    - count(), sum(), avg(), min(), max(), variance(), stddev()
