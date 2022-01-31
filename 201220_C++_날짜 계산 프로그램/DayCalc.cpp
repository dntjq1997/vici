#include "DayCalc.h"
#include <iostream>
#include <time.h>

using namespace std;

/* ������� �ʱ�ȭ */
Daycalc::Daycalc()
{
	m_nYear = 1;
	m_nMonth = 1;
	m_nDay = 1;
}
Daycalc::Daycalc(int year, int month, int day)
{
	m_nYear = year;
	m_nMonth = month;
	m_nDay = day;
}
Daycalc::~Daycalc()
{
}

/* This �������� ���ó�¥�� �ʱ�ȭ */
void Daycalc::initToday()
{
	time_t t = time(NULL);
	struct tm tm = *localtime(&t);
	m_nThis_y = tm.tm_year + 1900;
	m_nThis_m = tm.tm_mon + 1;
	m_nThis_d = tm.tm_mday;
}

bool Daycalc::isLeapYear(int year) const // ����˻�
{
	/* ������: 400���� �������ų�, 4�� ���������鼭 100���� �������� �ʴ� ���� �����̴�. */
	return (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0));
}

int Daycalc::Days_from_1_1(int year, int month, int day) const // 1�� 1�Ϻ��� ���س�¥������ �ϼ� ���
{
	int days = 0, i; // �� �ϼ��� ������ days ����
	for (i = 0; i < month-1; i++) {
		days += m_nMonth_days[i];
	}//���� �� ���� �޵��� �ϼ��� ����
	days += day;
	if (month > 2 && isLeapYear(year))
		days += 1;
	//���� ���� �����̰� ��¥�� 3���̻��� ��� �ϼ��� �Ϸ� ����
	return days;
}

void Daycalc::Calc_Duration() const // ���ó�¥�� ���س�¥�� �ϼ� ���� ���
{
	int days=0, o_y=m_nYear, o_m=m_nMonth, o_d=m_nDay, n_y=m_nThis_y, n_m=m_nThis_m, n_d=m_nThis_d;
	int days1;
	int days2;
	int i;

	/* ���ð� ���س� �� �� ������ ��(old)�� o_�����鿡, �� �ֱ��� ��(new)�� n_�����鿡 ���� */
	if ((m_nThis_y < m_nYear) || (m_nThis_y == m_nYear && m_nThis_m < m_nMonth) || (m_nThis_y == m_nYear && m_nThis_m == m_nMonth && m_nThis_d < m_nDay)) {
		o_y = m_nThis_y;
		o_m = m_nThis_m;
		o_d = m_nThis_d;
		n_y = m_nYear;
		n_m = m_nMonth;
		n_d = m_nDay;
	}
	
	/* old�� new�� ���� �⵵�� �ϼ��� �ٲ� �� �ű⿡ 
	new�� 1�� 1�Ϻ��� ���� �ϼ��� ���ϰ� old�� 1�� 1�Ϻ��� ���� �ϼ��� ����
	ex) old: 2000�� 1�� 30��, new: 2001�� 1�� 15��
	366 + 15 - 30 = 351 */
	days1 = Days_from_1_1(n_y, n_m, n_d);
	days2 = Days_from_1_1(o_y, o_m, o_d);
	for (i = o_y; i < n_y; i++) {
		days += 365;
		if (isLeapYear(i)) days += 1;
	}
	days += days1;
	days -= days2;
	
	/* ���� ��¥�� �� �ֱ� �� ��� ��� */
	if (n_y == m_nThis_y && n_m==m_nThis_m && n_d==m_nThis_d)
		cout << "������ " << m_nYear << "�� " << m_nMonth << "�� " << m_nDay << "�Ϸκ��� " << days << "�� �������ϴ�." << endl;
	/* ���� ��¥�� �� ���� �� ��� ��� */
	else cout << "���ú��� " << m_nYear << "�� " << m_nMonth << "�� " << m_nDay << "�ϱ��� " << days << "�� ���ҽ��ϴ�." << endl;

}

Daycalc Daycalc::operator+(const int plusday) const // ���س�¥�κ��� plusday��ŭ ���� ���� ��¥ ���
{
	Daycalc DDay;
	int days1, days, i=0;

	DDay.m_nYear = this->m_nYear; // ���� �ʱ�ȭ�� ���� �⵵ 1�� 1�Ϸ� ��
	
	days1 = Days_from_1_1(this->m_nYear, this->m_nMonth, this->m_nDay);
	days = days1 + plusday;
	/*���س⵵���� ���س�¥������ �ϼ��� plusday�� ���� 
	���س⵵�� 1�� 1�Ϻ��� ���ذ��� ��� �� �� */

	/* days�� 1�� �̻��� ��� ���̿� �⵵�� ������*/
	while (days >= 365) {
		if (isLeapYear(DDay.m_nYear) && days >= 366) { //������ ��
			DDay.m_nYear += 1;
			days -= 366;
		}
		else if (!isLeapYear(DDay.m_nYear) && days >= 365) { //������ �ƴ� ��
			DDay.m_nYear += 1;
			days -= 365;
		}
		else if (isLeapYear(DDay.m_nYear) && days < 366) break;
	}

	/* days�� 1������ 12������ ���� �� ���� �ϼ� �̻��̸� ���̿� ���� ������ */
	for (i = 0; i < 12; i++) {
		if (days >= m_nMonth_days[i]) {
			if (i == 1 && isLeapYear(DDay.m_nYear)) {
				if (days < m_nMonth_days[i] + 1) {
					DDay.m_nDay += days;
					days = 0;
				}
				else {
					DDay.m_nMonth++;
					days -= m_nMonth_days[i] + 1;
				}
			}
			else {
				DDay.m_nMonth++;
				days -= m_nMonth_days[i];
			}
		}
		else break;
	}
	/* ���� days�� ������ ���ڿ� ������*/
	DDay.m_nDay += days;

	return DDay;
}

int Daycalc::operator-(const Daycalc &Day) const // �� ��ü�� ���� ��¥ �ϼ� ���� ���
{
	int days = 0;
	int days1=0;
	int days2=0;
	int i;
	
	/* ���ڷ� ���� ��ü�� �׻� old��� ���� Calc_Duration �Լ��� ���� ������� ��� */
	days1 = Days_from_1_1(this->m_nYear, this->m_nMonth, this->m_nDay);
	days2 = Days_from_1_1(Day.m_nYear, Day.m_nMonth, Day.m_nDay);
	for (i = Day.m_nYear; i < this->m_nYear; i++) {
		days += 365;
		if (isLeapYear(i)) days += 1;
	}
	days += days1;
	days -= days2;
	
	return days;


}