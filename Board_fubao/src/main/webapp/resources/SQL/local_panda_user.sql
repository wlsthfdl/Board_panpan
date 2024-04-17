
show user;

-- ** 회원 테이블 ** --
CREATE TABLE MEMBER (
	id          VARCHAR2(40) NOT NULL, -- 회원ID
	nickname    VARCHAR2(20) NOT NULL, -- 닉네임
	name        VARCHAR2(20) NOT NULL, -- 이름 
	pwd         VARCHAR2(40) NOT NULL, -- 비밀번호
	email       VARCHAR2(40) NOT NULL, -- 이메일
	birthday    DATE        NULL,     -- 생년월일
	registerday DATE        NOT NULL, -- 가입일
	mobile      VARCHAR2(20) NOT NULL, -- 휴대폰
	status      NUMBER(1) default 1 NOT NULL, -- 탈퇴여부
	role        NUMBER(1) NOT NULL,  -- 사용자권한(관리자 or 일반회원)
    constraint MEMBER_PK primary key(id),
    constraint UK_1  unique(nickname),
    constraint UK_2  unique(email),
    constraint ck_1 check( status in(0,1) ),
    constraint ck_2 check( role in(0,1) )    
);

-- ** 게시글 테이블 ** --
CREATE TABLE BOARD (
	b_idx     NUMBER          NOT NULL, -- 글번호
	id_fk       VARCHAR2(40)  NOT NULL, -- 회원ID
	category_idx_fk  NUMBER   NOT NULL, -- 카테고리번호
	b_title   VARCHAR2(200)   NOT NULL, -- 글제목
	b_content VARCHAR2(4000)  NOT NULL, -- 글내용
	b_date    DATE            NOT NULL, -- 글등록일
	b_like    NUMBER(7)       NOT NULL, -- 추천수
	b_hit     NUMBER(7)       NOT NULL,  -- 조회수constraint BOARD_PK primary key(board_idx),
    constraint BOARD_PK primary key(b_idx),
    constraint BOARD_FK_1 foreign key(id_fk) references MEMBER(id),
    constraint BOARD_FK_2 foreign key(category_idx_fk) references CATEGORY(category_idx)
);


create sequence b_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- ** 카테고리 테이블 ** --
CREATE TABLE CATEGORY (
	category_idx  NUMBER     NOT NULL, -- 카테고리번호
	category_name VARCHAR2(80) NOT NULL,  -- 카테고리명
    constraint CATEGORY_PK primary key(category_idx)
);


create sequence category_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- ** 첨부파일 테이블 ** --
CREATE TABLE ATTACH (
	file_idx       NUMBER            NOT NULL, -- 파일번호
	b_idx_fk       NUMBER            NOT NULL, -- 글번호
	org_file_name  VARCHAR2(400)     NOT NULL, -- 원본파일명
	save_file_name VARCHAR2(400)     NOT NULL, -- 파일명
	file_size      NUMBER            NOT NULL,  -- 파일크기
    constraint ATTACH_PK primary key(file_idx),
    constraint ATTACH_FK foreign key(b_idx_fk) references BOARD(b_idx)
);