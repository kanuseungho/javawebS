create table qna2 (
  idx		int not null,										/* qna의 고유번호 */
  qnaIdx varchar(10) not null,					/* 답변글의 고유번호 */
  mid   varchar(20) not null,						/* 올린이의 아이디 */
  nickName  varchar(20)  not null,			/* qna 올린사람의 닉네임 */
  title varchar(100) not null,					/* qna의 글 제목 */
  email varchar(50)  not null,					/* 이메일 */
  pwd 	varchar(20),										/* 비밀번호(필요없음... 여기선 비밀'질문/답변'글의 용도로 사용할것, 즉 체크박스에 비밀글로 체크하면 여기선 이곳에 '1234'를 저장했다.) */
  wDate datetime	 default now(),				/* 글쓴날짜 */
  content text  not null,								/* qna 글내용 */
  qnaSw		varchar(2) 	not null default 'q',	/* question(q)인지 answer(a)인지 표시처리 */
  primary key(idx)											/* 기본키는 고유번호 */
);

drop table qna2;

desc qna2;

select max(idx) from qna2;

select count(idx) from qna2;

select * from qna2 order by qnaIdx desc, idx desc;

select * from qna2 where SUBSTRING_INDEX(qnaIdx, '_', 1)  = '03';


/* 이번에 작성된 qna는 다음과 같은 방법으로 구현해 봤다.
 * 질문글과 답변글을 올릴때 아래 idx, qnaIdx, qnaSw가 결정된다. 즉, qnaSw는 질문글은 'q', 답변글은 'a'로 설정되고, 글을 올리기전에 먼저 idx값을 구한후(기존 idx의 최대값), 아래와 같은 방법으로 qnaIdx를 구한다.
 * 질문글 올릴때는, qnaIdx값을, 만들어진 idx값에 '_2'를 붙여서 등록시켜주고, 
 * 답변글을 올릴때는, 질문글의 qnaIdx값의 _앞의 고유번호를 받아와서 붙여주기 '_1'을 붙여서 등록시켜준다. 추후 계속되는 답변글은 계속해서 질문글의 qnaIdx값의 '_'앞의 고유번호에 '_1'을 똑같이 붙여준다. 출력시 qnaIdx내림차순출력값이 같으면 idx내림차순으로 출력하면된다.
 * 나중에 결과를 출력할때는 qnaIdx 내림차순(같으면 두번째키는 idx 오름차순)으로 출력시켜주면 자동적으로 답변과 질문글이 정렬되어 출력된다. 이때 답변글은 '└'기호를 붙여서 들여쓰기 해 주었다. 
idx		qnaIdx	qnaSw
1			1_2			q
2			1_1			a
3			3_2			q
4			4_2			q
5			3_1			a
6			3_1  		a
7			7_2			q

아래처럼 정렬해서 결과를 출력시켜준다.
select * from qna2 order by qnaIdx desc, idx desc;
idx		qnaIdx	qnaSw
7			7_2			q
4			4_2			q
5			3_1			a
6			3_1  		a
3			3_2			q
2			1_1			a
1			1_2			q

*/
