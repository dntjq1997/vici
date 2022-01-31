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
	cout << "******************���� ��¥******************" << endl;
	cout << day.GetToY() << "�� " << day.GetToM() << "�� " << day.GetToD() << "�� " << endl;
	cout << "*********************************************" << endl;
	cout << "\n" << endl;

	cout << "*******************����**********************" << endl;
	MyBir.Calc_Duration();
	cout << "\n" << endl;

	cout << "*******************�ڷγ�*********************" << endl;
	Corona.Calc_Duration();
	cout << "\n" << endl;

	cout << "*******************������*********************" << endl;
	Finished.Calc_Duration();
	cout << "\n" << endl;

	cout << "****************�θ�� �����*****************" << endl;
	Parents_D10000 = Parents_meet + 10000;
	cout << "�θ���� ���� "<< Parents_meet<< "�κ���\n10000���� �Ǵ� ���� "
		<< Parents_D10000<< "�Դϴ�. " << endl;
	cout << "\n" << endl;

	cout << "******************����Ⱓ********************" << endl;
	Start.SetDate(2020, 10, 2);
	Finish.SetDate(2020, 11, 25);
	Travel_period = Finish - Start;
	cout << "���: "<< Start<< "\n";
	cout << "����: "<< Finish<< "\n";
	cout << "�� " << Travel_period << "�ϰ� �����Ͽ����ϴ�." << endl;
	cout << "\n" << endl;

}
ostream &operator<<(ostream &os, const Daycalc &Dayobj) // cout << ��ü �� ���� �� ��¥�������� ����ϰ� ��
{
	os << Dayobj.m_nYear << "�� " << Dayobj.m_nMonth << "�� " << Dayobj.m_nDay << "�� ";
	
	return os;
}