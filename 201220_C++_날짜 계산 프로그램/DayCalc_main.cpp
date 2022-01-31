#include "DayCalc.h"
#include <iostream>
using namespace std;

int Daycalc::m_nThis_y = 1;
int Daycalc::m_nThis_m = 1;
int Daycalc::m_nThis_d = 1;
int Daycalc::m_nMonth_days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
ostream &operator<<(ostream &os, const Daycalc &Dayobj);
int main()
{
	Daycalc day, MyBir(1997, 8, 26), Corona(2019, 12, 8), Finished(2020, 12, 23), Parents_meet(1996, 12, 7), Parents_D10000, Start, Finish;
	int Travel_period;
	day.initToday();
	cout << "******************오늘 날짜******************" << endl;
	cout << day.GetToY() << "년 " << day.GetToM() << "월 " << day.GetToD() << "일 " << endl;
	cout << "*********************************************" << endl;
	cout << "\n" << endl;

	cout << "*******************생일**********************" << endl;
	MyBir.Calc_Duration();
	cout << "\n" << endl;

	cout << "*******************코로나*********************" << endl;
	Corona.Calc_Duration();
	cout << "\n" << endl;

	cout << "*******************종강일*********************" << endl;
	Finished.Calc_Duration();
	cout << "\n" << endl;

	cout << "****************부모님 기념일*****************" << endl;
	Parents_D10000 = Parents_meet + 10000;
	cout << "부모님이 만난 "<< Parents_meet<< "로부터\n10000일이 되는 날은 "
		<< Parents_D10000<< "입니다. " << endl;
	cout << "\n" << endl;

	cout << "******************여행기간********************" << endl;
	Start.SetDate(2020, 10, 2);
	Finish.SetDate(2020, 11, 25);
	Travel_period = Finish - Start;
	cout << "출발: "<< Start<< "\n";
	cout << "도착: "<< Finish<< "\n";
	cout << "총 " << Travel_period << "일간 여행하였습니다." << endl;
	cout << "\n" << endl;

}
ostream &operator<<(ostream &os, const Daycalc &Dayobj) // cout << 객체 를 했을 때 날짜형식으로 출력하게 함
{
	os << Dayobj.m_nYear << "년 " << Dayobj.m_nMonth << "월 " << Dayobj.m_nDay << "일 ";
	
	return os;
}