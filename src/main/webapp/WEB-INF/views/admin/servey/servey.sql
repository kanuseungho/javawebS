/* 설문지에 참여하는 사람들의 고유정보(통계를 내기위해 필요함) */
create table serveyBasic(
	idx int not null auto_increment primary key,	/* 투표자의 고유번호 */
	gender varchar(4) not null,										/* 성별 */
	age varchar(15) not null,											/* 연령대 */
	address varchar(15) not null									/* 거주 지역 */
);
drop table serveyBasic;

/* 설문지 주제에 따른 제목 설정하기(설문지 만들기) */
create table servey(
	idx int not null auto_increment primary key,	/* 설문지 고유번호				*/
	title varchar(50) not null,										/* 설문제목						*/
	/* content varchar(100) not null, */								/* 설문 상세내역				*/
	sDate datetime default now() not null,				/* 설문 작성일					*/
	startDate datetime not null,									/* 설문 시작날짜				*/
	endDate datetime not null,										/* 설문 종료날짜				*/
	showSw int not null														/* 설문지 보여주기(1)/가리기(0) 	*/
);

/* insert into servey values(default,'여름 과일 구매에 대한 설문입니다.','소비자 맞춤 서비스를 위한 설문지입니다.',now(),20230726,20230801,1); */
insert into servey values(default,'여름 과일 구매에 대한 설문입니다.',now(),20230726,20230801,1);
select * from servey;
delete from servey;

drop table serveyAnswer;
drop table serveyRealAnswer;
drop table serveyBasic;
drop table serveyQuestion;
drop table servey;

/* 설문 문항 만들기(답변지 : 콤보형/체크박스형/텍스트(서술)형) */
create table serveyQuestion(
	idx int not null auto_increment primary key,	/* 설문 문항 고유번호 */
	sIdx int not null,														/* 설문지 고유번호 */
	qcontent varchar(50),													/* 설문 문항 개별 내용 */
	answerSw int not null,												/* 답변유형(체크박스형(1)/콤보형(2)/텍스트(서술)형(0) */
	foreign key(sIdx) references servey(idx) on delete restrict
);
insert into serveyQuestion values  (default,1,'가장 좋아하는 과일은 무엇인가요?',1);
insert into serveyQuestion values  (default,1,'과일 구매 시 주로 고려하는것은 어떤것인가요.',2);
insert into serveyQuestion values  (default,1,'그 밖에 나만의 과일 선택 비법이 있다면 자유롭게 써주세요.',0);

select * from serveyQuestion;

/* 설문문항지에 각 항목(라디오버튼/체크박스/텍스트박스)에 해당하는 각각의 질문 내역 */
create table serveyAnswer(
	idx int not null auto_increment primary key,	/* 설문문항지에 답변한 내역 고유번호 */
	sIdx int not null,														/* 설문지 고유번호 */
	qIdx int not null,														/* 설문 문항지 고유번호 */
	acontent  varchar(50),												/* 설문문항지의 조건의 물음에 따른 각각의 세부문항내역 */
	foreign key(sIdx) references servey(idx) on delete restrict,
	foreign key(qIdx) references serveyQuestion(idx) on delete restrict
);

insert into serveyAnswer values (default,1,1,'수박');
insert into serveyAnswer values (default,1,1,'딸기');
insert into serveyAnswer values (default,1,1,'사과');
insert into serveyAnswer values (default,1,1,'배');
insert into serveyAnswer values (default,1,1,'복숭아');
insert into serveyAnswer values (default,1,2,'신선도');
insert into serveyAnswer values (default,1,2,'가격');
insert into serveyAnswer values (default,1,2,'원산지');
insert into serveyAnswer values (default,1,2,'판매처');
insert into serveyAnswer values (default,1,3,'주로 믿고 거래할 수 있는곳을 발굴한다.');

/* 설문 문항지의 각 항목에 실제로 투표한 내역(체크 또는 기술한것) */
create table serveyRealAnswer(
	idx int not null auto_increment primary key,	/* 설문지 투표한 내역의 고유번호 */
	bIdx int not null,							/* 설문에 참여하는사람들의 기본정보 고유번호 */
	sIdx int not null,							/* 설문지 고유번호 */
	qIdx int not null,							/* 설문지의 질문한 항목의 고유번호 */
	aIdx int not null,							/* 설문지 질문항목에 대하여 투표자가 답변한 번호(단, 서술형(0)인경우는 0이라고 기술하고, detailAnswer 에 내용을 적을수 있게한다. */
	detailAnswer varchar(50)  not null,				/* 설문문항지의 조건이 서술형(0)일때 답변내역 */
	foreign key(sIdx) references servey(idx) on delete restrict,
	foreign key(qIdx) references serveyQuestion(idx) on delete restrict,
	foreign key(bIdx) references serveyBasic(idx) on delete restrict
);


select * from serveyQuestion where sIdx=1;
select * from serveyAnswer where sIdx=1 and qIdx=1 and qIdx in (select qIdx from serveyQuestion where answerSw=1);

select * from serveyRealAnswer where sIdx=1;

select acontent from serveyAnswer a where sIdx=1 ; 
select * from serveyAnswer where sIdx=1
select count(*) from serveyRealAnswer group by aIdx;

select *,(select count(*) from serveyRealAnswer where aIdx=a.idx group by aIdx ) as realAnswerCnt from serveyAnswer a where sIdx = 1;


select * from serveyRealAnswer where sIdx=1 and bIdx in (select idx from serveyBasic where gender='남자');
