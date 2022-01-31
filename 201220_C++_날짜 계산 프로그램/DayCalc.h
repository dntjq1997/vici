#include <iostream>
using namespace std;

class Daycalc {

private:
	/* This 변수들은 현재 날짜를 저장하는 변수로 
	모든 객체에서 함께 변해야 하므로 static으로 선언 */
	static int m_nThis_y;
	static int m_nThis_m;
	static int m_nThis_d;
	/* Month_days 배열은 1월부터 12월까지 한 달 일수를 저장한 변수로
	2월은 윤달이 아닌 달을 기준으로 28일로 저장해놓음
	모든 객체에서 공통으로 사용하므로 static 선언, 
	객체끼리의 대입을 가능하게 하기위해 const 선언을 하지 못함 */
	static int m_nMonth_days[12];
	/* 계산의 대상이 되는 날짜 변수들 */
	int m_nYear;
	int m_nMonth;
	int m_nDay;

public:
	// 1.constructor
	Daycalc();
	Daycalc(int, int, int);
	// 2.destructor
	~Daycalc();
	// 3.Get, Set
	int GetYear() { return m_nYear; } const
	int GetMonth() { return m_nMonth; } const
	int GetDay() { return m_nDay; } const
	int GetToY() { return m_nThis_y; } const
	int GetToM() { return m_nThis_m; } const
	int GetToD() { return m_nThis_d; } const
	void SetYear(int year) { m_nYear = year; }
	void SetMonth(int month) { m_nMonth = month; }
	void SetDay(int day) { m_nDay = day; }
	void SetDate(int year, int month, int day) { m_nYear = year; m_nMonth = month; m_nDay = day; }
	// 4.function
	void initToday();
	void Calc_Duration() const;
	int Days_from_1_1(int, int, int) const;
	bool isLeapYear(int year) const;

	// 5.연산자 오버로딩
	Daycalc operator+(const int) const;
	int operator-(const Daycalc &) const;
	friend ostream &operator<<(ostream &os, const Daycalc &Dayobj);
};
