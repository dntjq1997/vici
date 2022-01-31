create database upbit;

use upbit;

create table ���(
	���ID char(10) not null,
	�̸� char(30),
	������� char(100),
	primary key(���ID)
	);

insert into ��� values ('C001', '��Ʈ����', '������ �¶��� ��ȣȭ��');
insert into ��� values ('C002', '�̴�����', '������ �ڻ� �� �� ���� ���� �÷���');
insert into ��� values ('C003', '����', '�ǽð� �Ѿװ��� �ý���');
insert into ��� values ('C004', '��������', '��հ� ģ���� �������ڻ�');
insert into ��� values ('C005', '�޵���', '�Ƿ� ���� ���� �÷���');

select *
from ���;

create table ����ȭ��(
	����ȭ��ID char(10) not null,
	�̸� char(30),
	������ char(30),
	���簡 int,
	�� int,
	���� int,
	���ϴ������ real,
	���ϴ�����ݾ� real,
	�ŷ��� char(50),
	�ð��Ѿ� char(10),
	���ID char(10),
	���ʹ����� char(10),
	�ѹ��෮ bigint,
	�ѹ����ѵ� bigint,
	primary key(����ȭ��ID),
	foreign key(���ID) references ���(���ID)
	);

insert into ����ȭ�� values ('BTC', '��Ʈ����', 'Bitcoin', 52463000, 58000000, 51381000, -9.00, -5186000, '30,546.402 BTC', '998.2����', 'C001', '2009-01', 18681487, 21000000);
insert into ����ȭ�� values ('ETH', '�̴�����', 'Ethereum', 3797000, 4473000, 3800000, -10.62, -473000, '539,673.561 ETH', '493.1����', 'C002', '2015-07', null, null);
insert into ����ȭ�� values ('XRP', '����', 'Ripple', 1825, 1910, 1610, +1.39, +25.00, '2,117,964,536.336 XRP', '60.7����', 'C003', '2013-04', 100000000000, 100000000000);
insert into ����ȭ�� values ('DOGE', '��������', 'Dogecoin', 588, 644, 554, -7.84, -50.00, '5,325,378,688.407 DOGE', '75.0����', 'C004', '2013-12', 128948608768, null);
insert into ����ȭ�� values ('MED', '�޵���', 'MediBloc', 101, 117, 97.70, -12.93, -15.00, '931,006,965.346 MED', '2961.3���', 'C005', '2017-11', 8388959432, 10000000000);

select *
from ����ȭ��;

create table ��(
	��ID char(10) not null,
	�̸� char(10),
	�򰡱ݾ� int,
	�򰡼��� int,
	�򰡼��ͷ� real,
	�Ա� int,
	��� int,
	primary key(��ID)
	);

insert into �� values ('P001', '�ӿ켷', 2226800, +226800, +11.34, 2000000, 100000);
insert into �� values ('P002', '�̼���', 272000, +72000, +7.2, 200000, 0);
insert into �� values ('P003', 'Ȳ����', 4600000, +2000000 ,+230.64, 2600000, 200000);
insert into �� values ('P004', '�̼���', 5792400, -207600 ,-3.46, 6000000, 500000);
insert into �� values ('P005', '�ڿ���', 16600000, -3400000, -17, 20000000, 5000000);

select *
from ��;

create table ����(
	��ID char(10) not null,
	��������ȭ��ID char(10) not null,
	�̸� char(10),
	primary key(��ID, ��������ȭ��ID),
	foreign key(��ID) references ��(��ID)
	);

insert into ���� values ('P001', 'XRP', '����');
insert into ���� values ('P002', 'DOGE', '��������');
insert into ���� values ('P003', 'BTC', '��Ʈ����');
insert into ���� values ('P004', 'XRP','����');
insert into ���� values ('P004', 'ETH', '�̴�����');
insert into ���� values ('P005', 'MED','�޵���');

select *
from ����;

create table �ŷ�(
	����ȭ��ID char(10) not null,
	��ID char(10) not null,
	�ŷ����� char(30),
	�ֹ��ð� char(20),
	ü��ð� char(20),
	�ŷ����� char(10),
	�ŷ����� int,
	�ŷ����� real,
	������ real,
	����ݾ� real,
	primary key(����ȭ��ID, ��ID)
	);

-- ������ = ü��ݾ� (�ֹ����� x �ֹ�����) x ���� �ŷ���������(%) 

insert into �ŷ� values ('DOGE', 'P001' ,'��������', '21-04-09 12:40', '21-04-09 12:40','�ŵ�', 80, 6250, 250, 500250)
insert into �ŷ� values ('XRP', 'P001' ,'����', '21-05-17 12:33', '21-05-17 12:33', '�ż�', 1605, 623.05295950, 500, 1000500);
insert into �ŷ� values ('ETH', 'P002' ,'�̴�����', '21-05-11 18:43', '21-05-11 18:43','�ŵ�', 4977705, 0.02008957, 50, 100050);
insert into �ŷ� values ('DOGE', 'P002' ,'��������', '21-05-16 11:08', '21-05-16 11:08','�ż�', 650, 153.84615384, 50, 100050);
insert into �ŷ� values ('BTC', 'P003' ,'��Ʈ����', '20-11-27 18:03', '20-11-27 18:03','�ż�', 18602585, 0.10751193, 1000, 2001000);
insert into �ŷ� values ('BTC', 'P004' ,'��Ʈ����', '21-04-02 00:07', '21-04-02 00:07','�ŵ�', 72491259, 0.04414325, 1600, 3201600);
insert into �ŷ� values ('ETH', 'P004' ,'�̴�����', '21-04-23 12:58', '21-04-23 12:58','�ŵ�', 2620107, 0.30533104, 400, 800400);
insert into �ŷ� values ('XRP', 'P004' ,'����', '21-05-19 09:00', '21-05-19 09:00', '�ż�', 1293, 3712.29698375, 2400, 4802400);
insert into �ŷ� values ('ETH', 'P004' ,'�̴�����', '21-05-23 09:00', '21-05-23 09:00','�ż�', 2915361, 0.34301069, 500, 1000500);
insert into �ŷ� values ('MED', 'P005' ,'�޵���', '21-05-02 16:55', '21-05-02 16:55','�ż�', 176, 56818.18181818, 5000, 10005000);

select *
from �ŷ�;

create table ����(
	����ID char(10) not null,
	�̸� char(20),
	�ŷ����� char(10),
	primary key(����ID)
	);

insert into ���� values ('KRW', '��ȭ����', '��ȭ');
insert into ���� values ('BTC', '��Ʈ���θ���', '��Ʈ����');
insert into ���� values ('USDT', '�״�����', '�״�����');

select *
from ����;

create table ����(
	����ȭ��ID char(10) not null,
	����ID char(10) not null,
	�ŷ������� real,
	primary key(����ȭ��ID, ����ID)
	);

insert into ���� values ('BTC', 'KRW', 0.05);
insert into ���� values ('BTC', 'BTC', 0.25);
insert into ���� values ('BTC', 'USDT', 0.25);
insert into ���� values ('ETH', 'KRW', 0.05);
insert into ���� values ('ETH', 'BTC', 0.25);
insert into ���� values ('ETH', 'USDT', 0.25);
insert into ���� values ('XRP', 'KRW', 0.05);
insert into ���� values ('XRP', 'BTC', 0.25);
insert into ���� values ('XRP', 'USDT', 0.25);
insert into ���� values ('DOGE', 'KRW', 0.05);
insert into ���� values ('DOGE', 'BTC', 0.25);
insert into ���� values ('DOGE', 'USDT', 0.25);
insert into ���� values ('MED', 'KRW', 0.05);
insert into ���� values ('MED', 'BTC', 0.25);

select *
from ����;

select *
from ����ȭ��;
select *
from ��;
select *
from �ŷ�;
select *
from ����;
select *
from ���;
select *
from ����;
select *
from ����;

-- 1. ������ 10000�� ������ ����ȭ���� �̸��� ������������ �����Ͻÿ�.
select �̸�
from ����ȭ��
where ���簡<=10000
order by �̸� desc;

-- 2. ������ 10000�� �̻��� ����ȭ���� �������� ������������ �����Ͻÿ�.
select ������
from ����ȭ��
where ���簡>=10000
order by ������ asc;

-- 3. �� ���෮�� null���� ����ȭ���� ���������?
select �������
from ���, ����ȭ��
where ���.���ID=����ȭ��.���ID and �ѹ��෮ is null;

-- 4. ���������Ρ��� ���� ��������?
select ���ʹ�����
from ����ȭ��
where �̸�='��������';

-- 5. ���̴����򡯰ŷ��� �����ϴ� ������ �̸��� �ŷ��������?
select ����.�̸�, �ŷ�������
from ����ȭ��, ����, ����
where ����.����ID=����.����ID and ����ȭ��.����ȭ��ID=����.����ȭ��ID and ����ȭ��.�̸�='�̴�����';

-- 6. �ŷ������ᰡ 0.05%�� ������ �̸��� �ŷ�����?
select �̸�, �ŷ�����
from ����, ����
where ����.����ID=����.����ID and �ŷ�������='0.05'
group by �̸�, �ŷ�����;

-- 7. �Աݾ��� 5000000�� �̻��� ���� �Աݾװ� ��ݾ���?
select �Ա�, ���
from ��
where �Ա�>=5000000;

-- 8. �ӿ켷 ���� �򰡼�����?
select �򰡼���
from ��
where �̸�='�ӿ켷';

-- 9. ���������Ρ��� ������ ���� �򰡼��ͷ���?
select �򰡼��ͷ�
from ��, ����
where ��.��ID=����.��ID and ����.�̸�='��������';

-- 10. ���޵��ϡ��� �ŷ��� ���� �ִ� ���� �̸���?
select �̸�
from ��, �ŷ�
where ��.��ID=�ŷ�.��ID and �ŷ�����='�޵���';

-- 11. ��XRP'�� �����ϰ� �ִ� ���� �̸��� �򰡱ݾ���?
select ��.�̸�, �򰡱ݾ�
from ��, ����
where ��.��ID=����.��ID and ����.��������ȭ��ID='XRP';

-- 12. �򰡼��ͷ��� ������ ���� �̸��� �򰡼�����?
select �̸�, �򰡼���
from ��
where �򰡼��ͷ�<0;

-- 13. Ȳ���� ���� ������ ����ȭ��ID�� �򰡱ݾ�, �򰡼�����?
select ��������ȭ��ID, �򰡱ݾ�, �򰡼���
from ��, ����
where ��.��ID=����.��ID and ��.�̸�='Ȳ����';

-- 14. '��������'�� �ŷ��Ǿ��� �ֹ��ð��� ü��ð�, �ŷ�������?
select �ֹ��ð�, ü��ð�, �ŷ�����
from �ŷ�
where �ŷ�����='��������';

-- 15. �Աݾ��� 1000���� �̻��� ���� �̸��� ������ ����ȭ���̸���?
select ��.�̸�, ����.�̸�
from ��, ����
where ��.��ID=����.��ID and �Ա�<10000000;

-- 16. '�״�����'�� �ŷ��������� �ϴ� ����ID�� �̸���?
select ����ID, �̸�
from ����
where �ŷ�����='�״�����';

-- 17. �ŷ��������� �ŵ��� �� ���� �ִ� ���� �̸���?
select �̸�
from ��, �ŷ�
where ��.��ID=�ŷ�.��ID and �ŷ�����='�ŵ�'
group by �̸�;

-- 18. �� �����ѵ��� ���� ����ȭ���� ������� ���簡��?
select ������, ���簡
from ����ȭ��
where �ѹ����ѵ� is null;

-- 19. 21�� 4���� ����ȭ�� �ֹ��� �� ���� �ִ� ���� �ŷ����ݰ� �ŷ�������?
select �ŷ�����, �ŷ�����
from �ŷ�
where �ֹ��ð� like '21-04%';

-- 20. ������ ���� '��Ʈ����'�� ������ �����Ͻÿ�.
-- ��Ʈ����(BTC)
-- ���簡 : 43643000, �� : 43915000, ���� : 41304000
-- ���ϴ������ : 1.26, ���ϴ�����ݾ� : 460000
-- �ŷ��� : 9442.861BTC, �ð��Ѿ� : 739.1����

Update ����ȭ��
Set ���簡='43643000', ��='43915000', ����='41304000' ,���ϴ������='1.26', ���ϴ�����ݾ�='460000', �ŷ���='9442.861BTC', �ð��Ѿ�='739.1����'
Where �̸�='��Ʈ����';

select *
from ����ȭ��;

-- ��
create view ��Ʈ����
as select *
    from ����ȭ��
	where �̸� not in ('��Ʈ����');

select *
from ��Ʈ����;

create view �϶�����
as select *
    from ����ȭ��
	where ���ϴ������<0;

select *
from �϶�����;