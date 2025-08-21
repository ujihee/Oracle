/*
    날짜 : 2025/08/12
    이름 : 우지희
    내용 : 8장 정규화 실습
*/
-- 정규화 되지 않은 테이블 생성
CREATE TABLE bookorder (
    orderno   NUMBER NOT NULL,
    orderdate DATE,
    custid    VARCHAR2(20),
    cname     VARCHAR2(20),
    address   VARCHAR2(100),
    bookid    NUMBER,
    bookname  VARCHAR2(100),
    count     NUMBER,
    price     NUMBER
);

ALTER TABLE bookorder ADD CONSTRAINT table_1_pk PRIMARY KEY ( orderno );

-- 실습 7-1
insert into bookorder values (10001, '2024-01-12', 'a101', '김유신', '김해', 101, '프로그래밍', 1, 28000);
insert into bookorder values (10002, '2024-01-12', 'a102', '김춘추', '경주', 101, '프로그래밍', 1, 28000);
insert into bookorder values (10003, '2024-01-12', 'a102', '김춘추', '경주', 101, '자료구조', 1, 32000);
insert into bookorder values (10004, '2024-01-12', 'a103', '장보고', '완도', 102, '자료구조', 2, 32000);
insert into bookorder values (10005, '2024-01-12', 'a104', '강감찬', '서울', 110, '데이터베이스', 1, 25000);
insert into bookorder values (10006, '2024-01-12', 'a105', '이순신', '서울', 110, '데이터베이스', 1, 28000);
insert into bookorder values (10007, '2024-01-12', 'a105', '이순신', '서울', 110, '자료구조', 1, 32000);

-- 실습 7-2
CREATE TABLE bo_book (
    bookid   NUMBER NOT NULL,
    bookname VARCHAR2(100),
    price    NUMBER
);

ALTER TABLE bo_book ADD CONSTRAINT book_pk PRIMARY KEY ( bookid );

CREATE TABLE bo_customer (
    custid  VARCHAR2(20) NOT NULL,
    name    VARCHAR2(20),
    address VARCHAR2(100)
);

ALTER TABLE bo_customer ADD CONSTRAINT customer_pk PRIMARY KEY ( custid );

CREATE TABLE bo_order (
    orderno   NUMBER NOT NULL,
    orderid   VARCHAR2(20),
    bookid    NUMBER,
    count     NUMBER,
    orderdate DATE
);

ALTER TABLE bo_order ADD CONSTRAINT order_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_order
    ADD CONSTRAINT order_book_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book ( bookid );

ALTER TABLE bo_order
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( orderid )
        REFERENCES bo_customer ( custid );
-- 실습 7-3
CREATE TABLE bo_book3 (
    bookid   NUMBER NOT NULL,
    bookname VARCHAR2(100)
);

ALTER TABLE bo_book3 ADD CONSTRAINT bo_bookv1_pk PRIMARY KEY ( bookid );

CREATE TABLE bo_customer3 (
    custid  VARCHAR2(20) NOT NULL,
    name    VARCHAR2(20),
    address VARCHAR2(100)
);

ALTER TABLE bo_customer3 ADD CONSTRAINT bo_customerv1_pk PRIMARY KEY ( custid );

CREATE TABLE bo_order3 (
    orderno   NUMBER NOT NULL,
    orderid1  VARCHAR2(20),
    orderdate DATE
);

ALTER TABLE bo_order3 ADD CONSTRAINT bo_orderv1_pk PRIMARY KEY ( orderno );

CREATE TABLE bo_orderitem (
    orderno NUMBER NOT NULL,
    bookid  NUMBER NOT NULL,
    count   NUMBER,
    price   NUMBER
);

ALTER TABLE bo_orderitem ADD CONSTRAINT bo_order3v1_pk PRIMARY KEY ( orderno,
                                                                     bookid );


ALTER TABLE bo_order3
    ADD CONSTRAINT bo_order3_bo_customer3_fk FOREIGN KEY ( orderid1 )
        REFERENCES bo_customer3 ( custid );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_book3_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book3 ( bookid );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_order3_fk FOREIGN KEY ( orderno )
        REFERENCES bo_order3 ( orderno );