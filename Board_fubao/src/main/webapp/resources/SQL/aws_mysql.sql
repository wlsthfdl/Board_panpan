use board_db;

select user();

select database();

select *
from information_schema.schemata
where schema_name = 'board_db';

select version();

select @@global.time_zone, @@session.time_zone;

show tables;

show variables like 'lower%';



alter table tbl_board modify b_like int default 0;
commit;

-- ** 회원 테이블 ** --
CREATE TABLE tbl_member (
	id          VARCHAR(40) NOT NULL, -- 회원ID
	nickname    VARCHAR(100) NOT NULL, -- 닉네임
	name        VARCHAR(20) NOT NULL, -- 이름 
	pwd         VARCHAR(100) NOT NULL, -- 비밀번호
	birthday    DATE         NOT NULL,     -- 생년월일
	registerday  timestamp    default now()   NOT NULL, -- 가입일
	mobile      VARCHAR(100) NOT NULL, -- 휴대폰
	status      INT default 1 NOT NULL, -- 탈퇴여부
	role        INT default 1 NOT NULL,  -- 사용자권한(관리자 or 일반회원)
    constraint MEMBER_PK primary key(id),
    constraint MEMBER_UK_1  unique(nickname),
    constraint MEMEBER_CK_1 check( status in(0,1) ),
    constraint MEMEBER_CK_2 check( role in(0,1) )    
);

-- ** 게시글 테이블 ** --
CREATE TABLE tbl_board(
	b_idx     INT   auto_increment   NOT NULL, -- 글번호
	id_fk     VARCHAR(40)    NOT NULL, -- 회원ID
    nickname  VARCHAR(100)   NOT NULL,
	category_idx_fk  INT   NOT NULL, -- 카테고리번호
	b_title   VARCHAR(200)   NOT NULL, -- 글제목
	b_content VARCHAR(4000)  NOT NULL, -- 글내용
	b_date    timestamp   default now()  NOT NULL, -- 글등록일
	b_like    INT       default 0 NOT NULL, -- 추천수
	b_hit     INT       default 0 NOT NULL,  -- 조회수
    b_status  INT       default 1 NOT NULL, -- 글 삭제여부 0 또는 1
    c_cnt     INT       default 0 NOT NULL, -- 댓글 개수
    constraint BOARD_PK primary key(b_idx),
    constraint BOARD_FK_1 foreign key(id_fk) references tbl_member(id),
    constraint BOARD_FK_2 foreign key(category_idx_fk) references tbl_category(category_idx),
    constraint BOARD_CK_1 check( b_status in(1,0) )
);

-- ** 댓글 테이블 ** --
CREATE TABLE tbl_comment (
	c_idx     INT    auto_increment     NOT NULL, -- 댓글번호
	id_fk     VARCHAR(40)   NOT NULL,     -- 회원ID
	b_idx_fk  INT        NOT NULL,     -- 글번호
	nickname  VARCHAR(20)   NOT NULL,     -- 닉네임
	c_content VARCHAR(1000) NOT NULL,     -- 댓글내용
	c_date    timestamp   default now()   NOT NULL,     -- 작성일자
	c_status  INT default 1  NOT NULL,      -- 글삭제여부: 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
    file_name VARCHAR(500)  null,
    org_file_name VARCHAR(255) null,
    file_size   INT      null
    ,constraint COMMENT_PK primary key(c_idx)
    ,constraint COMMENT_FK_1 foreign key(id_fk) references tbl_member(id)
    ,constraint COMMENT_FK_2 foreign key(b_idx_fk) references tbl_board(b_idx) on delete cascade
    ,constraint COMMENT_CK check( c_status in(1,0) ) 
);


-- ** 카테고리 테이블 ** --
CREATE TABLE tbl_category (
	category_idx  INT  auto_increment  NOT NULL, -- 카테고리번호
	category_name VARCHAR(80) NOT NULL,  -- 카테고리명
    constraint CATEGORY_PK primary key(category_idx)
);

-- ** 게시글 좋아요 테이블** --
CREATE TABLE tbl_like(
    id_fk        varchar(40) not null          -- 아이디
    ,b_idx_fk    INT not null                -- 글 번호
    ,constraint  tbl_like_pk primary key(id_fk, b_idx_fk)  
    ,constraint  tbl_like_fk foreign key(id_fk) references tbl_member(id)
    ,constraint  tbl_like_fk_2 foreign key(b_idx_fk) references tbl_board(b_idx) on delete cascade
);


