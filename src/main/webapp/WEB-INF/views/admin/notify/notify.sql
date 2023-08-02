/* notify2.sql */
create table notify2 (
  idx     int not null auto_increment primary key,	/* 공지사항 고유번호 */
  name    varchar(20)  not null,										/* 공지사항 올린이 */
  title   varchar(100) not null,										/* 공지사항 제목 */
  content text not null,														/* 공지사항 상세내역 */
  startDate datetime default now(),									/* 공지사항 알림 시작일 */
  endDate   datetime default now(),									/* 공지사항 알림 종료일 */
  popupSw   char(1)  default 'N'										/* 공지사항 초기화면에 개시여부 */
);

desc notify2;

insert into notify2 (name,title,content) values ('관리자','여름맞이 특가 이벤트 행사','2023년 여름 바캉스 시즌을 맞이하여 특별가격 행사를 진행합니다.');
insert into notify2 values (default,'관리자','여름맞이 특가 이벤트 행사','2023년 여름 바캉스 시즌을 맞이하여 특별가격 행사를 진행합니다.',default,default,default);

select * from notify2 order by idx desc;
