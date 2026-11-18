-- KANT 데이터베이스 기초 · 2장 데일리 미션

-- 1번·연락처 점검 대상 회원

SELECT
    member_id       AS 회원번호     ,
    name            AS 회원이름     ,
    birth_year      AS 출생연도     ,
    region          AS 거주지역     ,
    phone           AS 전화번호
FROM members;


-- 2번·지역·성별 회원 현황

SELECT
    region				    AS 거주지역             ,
    gender				    AS 성별                ,
    COUNT(*)				AS 회원수              ,
    ROUND(AVG(birth_year))	AS "평균 출생연도"
FROM members
GROUP BY region, gender
HAVING COUNT(*) >= 5
ORDER BY region, gender;


-- 3번·10월 수강 취소 명단

SELECT
    m.name          AS 회원이름     ,
    m.phone         AS 회원이름     ,
    c.course_name   AS 취소강좌명
from enrollments e
JOIN members m ON e.member_id = m.member_id
JOIN courses c ON e.course_id = c.course_id
WHERE e.enroll_month = '2026-10'
    AND e.status = '취소'
ORDER BY m.name;



-- 4번·종목별 월 매출

SELECT
    s.sport_name            AS 종목명       ,
    e.enroll_month          AS 수강월       ,
    COUNT(e.member_id)      AS 수강인원     ,
    SUM(e.pay_amount)       AS 총매출
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN sports s ON c.sport_id = s.sport_id
WHERE NOT (e.status = '취소')
GROUP BY s.sport_name, e.enroll_month
HAVING SUM(e.pay_amount) >= 1000000
ORDER BY s.sport_name, e.enroll_month;


-- 5번·강사별 담당 강좌와 이번 달 신청

SELECT
    i.name                          AS 강사명           ,
    COUNT(DISTINCT c.course_id)     AS "담당 강좌수"    ,
    COUNT(e.member_id)              AS "이번달 신청"
FROM instructors i
LEFT JOIN courses c ON i.instructor_id = c.instructor_id
LEFT JOIN enrollments e ON c.course_id = e.course_id AND e.enroll_month = '2026-11'
GROUP BY i.instructor_id, i.name
ORDER BY "이번달 신청" DESC, i.name;

