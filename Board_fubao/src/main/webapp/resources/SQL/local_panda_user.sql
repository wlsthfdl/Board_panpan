
show user;

-- ** 회원 테이블 ** --
CREATE TABLE TBL_MEMBER (
	id          VARCHAR2(40) NOT NULL, -- 회원ID
	nickname    VARCHAR2(100) NOT NULL, -- 닉네임
	name        VARCHAR2(20) NOT NULL, -- 이름 
	pwd         VARCHAR2(100) NOT NULL, -- 비밀번호
	email       VARCHAR2(400) NOT NULL, -- 이메일
	birthday    DATE         NOT NULL,     -- 생년월일
	registerday DATE  default sysdate  NOT NULL, -- 가입일
	mobile      VARCHAR2(100) NOT NULL, -- 휴대폰
	status      NUMBER(1) default 1 NOT NULL, -- 탈퇴여부
	role        NUMBER(1) default 1 NOT NULL,  -- 사용자권한(관리자 or 일반회원)
    constraint MEMBER_PK primary key(id),
    constraint MEMBER_UK_1  unique(nickname),
    constraint MEMBER_UK_2  unique(email),
    constraint MEMEBER_CK_1 check( status in(0,1) ),
    constraint MEMEBER_CK_2 check( role in(0,1) )    
);

-- ** 게시글 테이블 ** --
CREATE TABLE TBL_BOARD (
	b_idx     NUMBER          NOT NULL, -- 글번호
	id_fk       VARCHAR2(40)  NOT NULL, -- 회원ID
	category_idx_fk  NUMBER   NOT NULL, -- 카테고리번호
	b_title   VARCHAR2(200)   NOT NULL, -- 글제목
	b_content VARCHAR2(4000)  NOT NULL, -- 글내용
	b_date    DATE default sysdate  NOT NULL, -- 글등록일
	b_like    NUMBER(7)       NOT NULL, -- 추천수
	b_hit     NUMBER(7)       NOT NULL,  -- 조회수
    b_status  NUMBER(1) default 1 NOT NULL, -- 글 삭제여부 0 또는 1
    c_cnt     NUMBER    default 0 NOT NULL, -- 댓글 개수
    constraint BOARD_PK primary key(b_idx),
    constraint BOARD_FK_1 foreign key(id_fk) references TBL_MEMBER(id),
    constraint BOARD_FK_2 foreign key(category_idx_fk) references TBL_CATEGORY(category_idx),
    constraint BOARD_CK_1 check( b_status in(1,0) )
);

-- ** 댓글 테이블 ** --
CREATE TABLE TBL_COMMENT (
	c_idx     NUMBER         NOT NULL, -- 댓글번호
	id_fk     VARCHAR2(40)   NOT NULL,     -- 회원ID
	b_idx_fk  NUMERIC        NOT NULL,     -- 글번호
	nickname  VARCHAR2(20)   NOT NULL,     -- 닉네임
	c_content VARCHAR2(1000) NOT NULL,     -- 댓글내용
	c_date    DATE    default sysdate   NOT NULL,     -- 작성일자
	c_status  NUMBER(1) default 1  NOT NULL      -- 글삭제여부: 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
    ,constraint COMMENT_PK primary key(c_idx)
    ,constraint COMMENT_FK_1 foreign key(id_fk) references TBL_MEMBER(id)
    ,constraint COMMENT_FK_2 foreign key(b_idx_fk) references TBL_BOARD(b_idx) on delete cascade
    ,constraint COMMENT_CK check( c_status in(1,0) ) 
);


-- ** 카테고리 테이블 ** --
CREATE TABLE TBL_CATEGORY (
	category_idx  NUMBER     NOT NULL, -- 카테고리번호
	category_name VARCHAR2(80) NOT NULL,  -- 카테고리명
    constraint CATEGORY_PK primary key(category_idx)
);


-- ** 첨부파일 테이블 ** --
CREATE TABLE TBL_ATTACH (
	file_idx       NUMBER            NOT NULL, -- 파일번호
	b_idx_fk       NUMBER            NOT NULL, -- 글번호
	org_file_name  VARCHAR2(400)     NOT NULL, -- 원본파일명
	save_file_name VARCHAR2(400)     NOT NULL, -- 파일명
	file_size      NUMBER            NOT NULL,  -- 파일크기
    constraint ATTACH_PK primary key(file_idx),
    constraint ATTACH_FK foreign key(b_idx_fk) references TBL_BOARD(b_idx)
);

-- ** 시퀀스 ** --

create sequence b_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence c_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence category_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence file_idx
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
