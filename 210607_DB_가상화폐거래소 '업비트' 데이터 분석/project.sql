create database upbit;

use upbit;

create table 기업(
	기업ID char(10) not null,
	이름 char(30),
	사업내용 char(100),
	primary key(기업ID)
	);

insert into 기업 values ('C001', '비트코인', '최초의 온라인 암호화폐');
insert into 기업 values ('C002', '이더리움', '디지털 자산 및 앱 개발 지원 플랫폼');
insert into 기업 values ('C003', '리플', '실시간 총액결제 시스템');
insert into 기업 values ('C004', '도지코인', '재밌고 친근한 디지털자산');
insert into 기업 values ('C005', '메디블록', '의료 정보 오픈 플랫폼');

select *
from 기업;

create table 가상화폐(
	가상화폐ID char(10) not null,
	이름 char(30),
	영문명 char(30),
	현재가 int,
	고가 int,
	저가 int,
	전일대비등락률 real,
	전일대비등락금액 real,
	거래량 char(50),
	시가총액 char(10),
	기업ID char(10),
	최초발행일 char(10),
	총발행량 bigint,
	총발행한도 bigint,
	primary key(가상화폐ID),
	foreign key(기업ID) references 기업(기업ID)
	);

insert into 가상화폐 values ('BTC', '비트코인', 'Bitcoin', 52463000, 58000000, 51381000, -9.00, -5186000, '30,546.402 BTC', '998.2조원', 'C001', '2009-01', 18681487, 21000000);
insert into 가상화폐 values ('ETH', '이더리움', 'Ethereum', 3797000, 4473000, 3800000, -10.62, -473000, '539,673.561 ETH', '493.1조원', 'C002', '2015-07', null, null);
insert into 가상화폐 values ('XRP', '리플', 'Ripple', 1825, 1910, 1610, +1.39, +25.00, '2,117,964,536.336 XRP', '60.7조원', 'C003', '2013-04', 100000000000, 100000000000);
insert into 가상화폐 values ('DOGE', '도지코인', 'Dogecoin', 588, 644, 554, -7.84, -50.00, '5,325,378,688.407 DOGE', '75.0조원', 'C004', '2013-12', 128948608768, null);
insert into 가상화폐 values ('MED', '메디블록', 'MediBloc', 101, 117, 97.70, -12.93, -15.00, '931,006,965.346 MED', '2961.3억원', 'C005', '2017-11', 8388959432, 10000000000);

select *
from 가상화폐;

create table 고객(
	고객ID char(10) not null,
	이름 char(10),
	평가금액 int,
	평가손익 int,
	평가수익률 real,
	입금 int,
	출금 int,
	primary key(고객ID)
	);

insert into 고객 values ('P001', '임우섭', 2226800, +226800, +11.34, 2000000, 100000);
insert into 고객 values ('P002', '이수아', 272000, +72000, +7.2, 200000, 0);
insert into 고객 values ('P003', '황범수', 4600000, +2000000 ,+230.64, 2600000, 200000);
insert into 고객 values ('P004', '이성래', 5792400, -207600 ,-3.46, 6000000, 500000);
insert into 고객 values ('P005', '박영권', 16600000, -3400000, -17, 20000000, 5000000);

select *
from 고객;

create table 보유(
	고객ID char(10) not null,
	보유가상화폐ID char(10) not null,
	이름 char(10),
	primary key(고객ID, 보유가상화폐ID),
	foreign key(고객ID) references 고객(고객ID)
	);

insert into 보유 values ('P001', 'XRP', '리플');
insert into 보유 values ('P002', 'DOGE', '도지코인');
insert into 보유 values ('P003', 'BTC', '비트코인');
insert into 보유 values ('P004', 'XRP','리플');
insert into 보유 values ('P004', 'ETH', '이더리움');
insert into 보유 values ('P005', 'MED','메디블록');

select *
from 보유;

create table 거래(
	가상화폐ID char(10) not null,
	고객ID char(10) not null,
	거래코인 char(30),
	주문시간 char(20),
	체결시간 char(20),
	거래종류 char(10),
	거래가격 int,
	거래수량 real,
	수수료 real,
	정산금액 real,
	primary key(가상화폐ID, 고객ID)
	);

-- 수수료 = 체결금액 (주문수량 x 주문가격) x 마켓 거래수수료율(%) 

insert into 거래 values ('DOGE', 'P001' ,'도지코인', '21-04-09 12:40', '21-04-09 12:40','매도', 80, 6250, 250, 500250)
insert into 거래 values ('XRP', 'P001' ,'리플', '21-05-17 12:33', '21-05-17 12:33', '매수', 1605, 623.05295950, 500, 1000500);
insert into 거래 values ('ETH', 'P002' ,'이더리움', '21-05-11 18:43', '21-05-11 18:43','매도', 4977705, 0.02008957, 50, 100050);
insert into 거래 values ('DOGE', 'P002' ,'도지코인', '21-05-16 11:08', '21-05-16 11:08','매수', 650, 153.84615384, 50, 100050);
insert into 거래 values ('BTC', 'P003' ,'비트코인', '20-11-27 18:03', '20-11-27 18:03','매수', 18602585, 0.10751193, 1000, 2001000);
insert into 거래 values ('BTC', 'P004' ,'비트코인', '21-04-02 00:07', '21-04-02 00:07','매도', 72491259, 0.04414325, 1600, 3201600);
insert into 거래 values ('ETH', 'P004' ,'이더리움', '21-04-23 12:58', '21-04-23 12:58','매도', 2620107, 0.30533104, 400, 800400);
insert into 거래 values ('XRP', 'P004' ,'리플', '21-05-19 09:00', '21-05-19 09:00', '매수', 1293, 3712.29698375, 2400, 4802400);
insert into 거래 values ('ETH', 'P004' ,'이더리움', '21-05-23 09:00', '21-05-23 09:00','매수', 2915361, 0.34301069, 500, 1000500);
insert into 거래 values ('MED', 'P005' ,'메디블록', '21-05-02 16:55', '21-05-02 16:55','매수', 176, 56818.18181818, 5000, 10005000);

select *
from 거래;

create table 마켓(
	마켓ID char(10) not null,
	이름 char(20),
	거래수단 char(10),
	primary key(마켓ID)
	);

insert into 마켓 values ('KRW', '원화마켓', '원화');
insert into 마켓 values ('BTC', '비트코인마켓', '비트코인');
insert into 마켓 values ('USDT', '테더마켓', '테더코인');

select *
from 마켓;

create table 지원(
	가상화폐ID char(10) not null,
	마켓ID char(10) not null,
	거래수수료 real,
	primary key(가상화폐ID, 마켓ID)
	);

insert into 지원 values ('BTC', 'KRW', 0.05);
insert into 지원 values ('BTC', 'BTC', 0.25);
insert into 지원 values ('BTC', 'USDT', 0.25);
insert into 지원 values ('ETH', 'KRW', 0.05);
insert into 지원 values ('ETH', 'BTC', 0.25);
insert into 지원 values ('ETH', 'USDT', 0.25);
insert into 지원 values ('XRP', 'KRW', 0.05);
insert into 지원 values ('XRP', 'BTC', 0.25);
insert into 지원 values ('XRP', 'USDT', 0.25);
insert into 지원 values ('DOGE', 'KRW', 0.05);
insert into 지원 values ('DOGE', 'BTC', 0.25);
insert into 지원 values ('DOGE', 'USDT', 0.25);
insert into 지원 values ('MED', 'KRW', 0.05);
insert into 지원 values ('MED', 'BTC', 0.25);

select *
from 지원;

select *
from 가상화폐;
select *
from 고객;
select *
from 거래;
select *
from 마켓;
select *
from 기업;
select *
from 지원;
select *
from 보유;

-- 1. 가격이 10000원 이하인 가상화폐의 이름을 내림차순으로 정렬하시오.
select 이름
from 가상화폐
where 현재가<=10000
order by 이름 desc;

-- 2. 가격이 10000원 이상인 가상화폐의 영문명을 오름차순으로 정렬하시오.
select 영문명
from 가상화폐
where 현재가>=10000
order by 영문명 asc;

-- 3. 총 발행량이 null값인 가상화폐의 사업내용은?
select 사업내용
from 기업, 가상화폐
where 기업.기업ID=가상화폐.기업ID and 총발행량 is null;

-- 4. ‘도지코인’의 최초 발행일은?
select 최초발행일
from 가상화폐
where 이름='도지코인';

-- 5. ‘이더리움’거래를 지원하는 마켓의 이름과 거래수수료는?
select 마켓.이름, 거래수수료
from 가상화폐, 마켓, 지원
where 마켓.마켓ID=지원.마켓ID and 가상화폐.가상화폐ID=지원.가상화폐ID and 가상화폐.이름='이더리움';

-- 6. 거래수수료가 0.05%인 마켓의 이름과 거래수단?
select 이름, 거래수단
from 마켓, 지원
where 마켓.마켓ID=지원.마켓ID and 거래수수료='0.05'
group by 이름, 거래수단;

-- 7. 입금액이 5000000원 이상인 고객의 입금액과 출금액은?
select 입금, 출금
from 고객
where 입금>=5000000;

-- 8. 임우섭 고객의 평가손익은?
select 평가손익
from 고객
where 이름='임우섭';

-- 9. ‘도지코인’을 보유한 고객의 평가수익률은?
select 평가수익률
from 고객, 보유
where 고객.고객ID=보유.고객ID and 보유.이름='도지코인';

-- 10. ‘메디블록’을 거래한 적이 있는 고객의 이름은?
select 이름
from 고객, 거래
where 고객.고객ID=거래.고객ID and 거래코인='메디블록';

-- 11. ‘XRP'를 보유하고 있는 고객의 이름과 평가금액은?
select 고객.이름, 평가금액
from 고객, 보유
where 고객.고객ID=보유.고객ID and 보유.보유가상화폐ID='XRP';

-- 12. 평가수익률이 음수인 고객의 이름과 평가손익은?
select 이름, 평가손익
from 고객
where 평가수익률<0;

-- 13. 황범수 고객이 보유한 가상화폐ID와 평가금액, 평가손익은?
select 보유가상화폐ID, 평가금액, 평가손익
from 고객, 보유
where 고객.고객ID=보유.고객ID and 고객.이름='황범수';

-- 14. '도지코인'이 거래되었던 주문시간과 체결시간, 거래종류는?
select 주문시간, 체결시간, 거래종류
from 거래
where 거래코인='도지코인';

-- 15. 입금액이 1000만원 이상인 고객의 이름과 보유한 가상화폐이름은?
select 고객.이름, 보유.이름
from 고객, 보유
where 고객.고객ID=보유.고객ID and 입금<10000000;

-- 16. '테더코인'을 거래수단으로 하는 마켓ID와 이름은?
select 마켓ID, 이름
from 마켓
where 거래수단='테더코인';

-- 17. 거래내역에서 매도를 한 적이 있는 고객의 이름은?
select 이름
from 고객, 거래
where 고객.고객ID=거래.고객ID and 거래종류='매도'
group by 이름;

-- 18. 총 발행한도가 없는 가상화폐의 영문명과 현재가는?
select 영문명, 현재가
from 가상화폐
where 총발행한도 is null;

-- 19. 21년 4월에 가상화폐 주문을 한 적이 있는 고객의 거래가격과 거래수량은?
select 거래가격, 거래수량
from 거래
where 주문시간 like '21-04%';

-- 20. 다음을 보고 '비트코인'의 정보를 수정하시오.
-- 비트코인(BTC)
-- 현재가 : 43643000, 고가 : 43915000, 저가 : 41304000
-- 전일대비등락률 : 1.26, 전일대비등락금액 : 460000
-- 거래량 : 9442.861BTC, 시가총액 : 739.1조원

Update 가상화폐
Set 현재가='43643000', 고가='43915000', 저가='41304000' ,전일대비등락률='1.26', 전일대비등락금액='460000', 거래량='9442.861BTC', 시가총액='739.1조원'
Where 이름='비트코인';

select *
from 가상화폐;

-- 뷰
create view 알트코인
as select *
    from 가상화폐
	where 이름 not in ('비트코인');

select *
from 알트코인;

create view 하락코인
as select *
    from 가상화폐
	where 전일대비등락률<0;

select *
from 하락코인;