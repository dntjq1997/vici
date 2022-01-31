#include <iostream>
using namespace std;

class Daycalc {

private:
	/* This �������� ���� ��¥�� �����ϴ� ������ 
	��� ��ü���� �Բ� ���ؾ� �ϹǷ� static���� ���� */
	static int m_nThis_y;
	static int m_nThis_m;
	static int m_nThis_d;
	/* Month_days �迭�� 1������ 12������ �� �� �ϼ��� ������ ������
	2���� ������ �ƴ� ���� �������� 28�Ϸ� �����س���
	��� ��ü���� �������� ����ϹǷ� static ����, 
	��ü������ ������ �����ϰ� �ϱ����� const ������ ���� ���� */
	static int m_nMonth_days[12];
	/* ����� ����� �Ǵ� ��¥ ������ */
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

	// 5.������ �����ε�
	Daycalc operator+(const int) const;
	int operator-(const Daycalc &) const;
	friend ostream &operator<<(ostream &os, const Daycalc &Dayobj);
};
