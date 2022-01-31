#include "DayCalc.h"
#include <iostream>
#include <time.h>

using namespace std;

/* 멤버변수 초기화 */
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

/* This 변수들을 오늘날짜로 초기화 */
void Daycalc::initToday()
{
	time_t t = time(NULL);
	struct tm tm = *localtime(&t);
	m_nThis_y = tm.tm_year + 1900;
	m_nThis_m = tm.tm_mon + 1;
	m_nThis_d = tm.tm_mday;
}

bool Daycalc::isLeapYear(int year) const // 윤년검사
{
	/* 윤년계산: 400으로 나눠지거나, 4로 나누어지면서 100으로 나눠지지 않는 년은 윤년이다. */
	return (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0));
}

int Daycalc::Days_from_1_1(int year, int month, int day) const // 1월 1일부터 기준날짜까지의 일수 계산
{
	int days = 0, i; // 총 일수를 저장할 days 변수
	for (i = 0; i < month-1; i++) {
		days += m_nMonth_days[i];
	}//기준 달 전의 달들의 일수를 더함
	days += day;
	if (month > 2 && isLeapYear(year))
		days += 1;
	//기준 년이 윤년이고 날짜가 3월이상일 경우 일수를 하루 더함
	return days;
}

void Daycalc::Calc_Duration() const // 오늘날짜와 기준날짜의 일수 차이 계산
{
	int days=0, o_y=m_nYear, o_m=m_nMonth, o_d=m_nDay, n_y=m_nThis_y, n_m=m_nThis_m, n_d=m_nThis_d;
	int days1;
	int days2;
	int i;

	/* 오늘과 기준날 중 더 오래된 날(old)을 o_변수들에, 더 최근의 날(new)을 n_변수들에 저장 */
	if ((m_nThis_y < m_nYear) || (m_nThis_y == m_nYear && m_nThis_m < m_nMonth) || (m_nThis_y == m_nYear && m_nThis_m == m_nMonth && m_nThis_d < m_nDay)) {
		o_y = m_nThis_y;
		o_m = m_nThis_m;
		o_d = m_nThis_d;
		n_y = m_nYear;
		n_m = m_nMonth;
		n_d = m_nDay;
	}
	
	/* old와 new의 차이 년도를 일수로 바꾼 후 거기에 
	new의 1월 1일부터 지난 일수를 더하고 old의 1월 1일부터 지난 일수를 빼줌
	ex) old: 2000년 1월 30일, new: 2001년 1월 15일
	366 + 15 - 30 = 351 */
	days1 = Days_from_1_1(n_y, n_m, n_d);
	days2 = Days_from_1_1(o_y, o_m, o_d);
	for (i = o_y; i < n_y; i++) {
		days += 365;
		if (isLeapYear(i)) days += 1;
	}
	days += days1;
	days -= days2;
	
	/* 오늘 날짜가 더 최근 일 경우 출력 */
	if (n_y == m_nThis_y && n_m==m_nThis_m && n_d==m_nThis_d)
		cout << "오늘은 " << m_nYear << "년 " << m_nMonth << "월 " << m_nDay << "일로부터 " << days << "일 지났습니다." << endl;
	/* 오늘 날짜가 더 예전 일 경우 출력 */
	else cout << "오늘부터 " << m_nYear << "년 " << m_nMonth << "월 " << m_nDay << "일까지 " << days << "일 남았습니다." << endl;

}

Daycalc Daycalc::operator+(const int plusday) const // 기준날짜로부터 plusday만큼 지난 날의 날짜 계산
{
	Daycalc DDay;
	int days1, days, i=0;

	DDay.m_nYear = this->m_nYear; // 디데이 초기화를 기준 년도 1월 1일로 함
	
	days1 = Days_from_1_1(this->m_nYear, this->m_nMonth, this->m_nDay);
	days = days1 + plusday;
	/*기준년도부터 기준날짜까지의 일수에 plusday를 더해 
	기준년도의 1월 1일부터 더해가며 계산 할 것 */

	/* days가 1년 이상일 경우 디데이에 년도를 더해줌*/
	while (days >= 365) {
		if (isLeapYear(DDay.m_nYear) && days >= 366) { //윤년일 때
			DDay.m_nYear += 1;
			days -= 366;
		}
		else if (!isLeapYear(DDay.m_nYear) && days >= 365) { //윤년이 아닐 때
			DDay.m_nYear += 1;
			days -= 365;
		}
		else if (isLeapYear(DDay.m_nYear) && days < 366) break;
	}

	/* days가 1월부터 12월까지 돌며 그 달의 일수 이상이면 디데이에 달을 더해줌 */
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
	/* 남은 days를 디데이의 일자에 더해줌*/
	DDay.m_nDay += days;

	return DDay;
}

int Daycalc::operator-(const Daycalc &Day) const // 두 객체의 기준 날짜 일수 차이 계산
{
	int days = 0;
	int days1=0;
	int days2=0;
	int i;
	
	/* 인자로 받은 객체가 항상 old라고 보고 Calc_Duration 함수와 같은 방법으로 계산 */
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