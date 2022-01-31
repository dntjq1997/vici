import csv
f = open('Electricvehicle.csv', 'r', encoding='cp949')
data = csv.reader(f)

for row in data:
    print(row)

-------------------------------------------------------------

import csv
import matplotlib.pyplot as plt
f = open('Electricvehicle.csv', 'r', encoding='cp949')
data = csv.reader(f)
next(data)
year19 = []
year21 = []
gu = []

for row in data :
    if row[1] != '' and row[2] != '':          
        year19.append(float(row[1]))   
        year21.append(float(row[2]))
        if row[0] :
            gu.append(str(row[0]))
        
plt.figure(figsize=(10, 5))
plt.rc('font', family='Malgun Gothic')
plt.plot(year19, 'hotpink', linewidth=2, label='2019.06')   
plt.plot(year21, 'skyblue', linewidth=2, label='2021.01')
plt.title('서울시 전기차 등록 수 ')
plt.xlabel('서울시 자치구 (강남구-중랑구)')
plt.ylabel('전기차 등록 수')
plt.xticks(range(25), gu, rotation=90)
plt.legend()
plt.show()

-------------------------------------------------------------

import csv
import matplotlib.pyplot as plt
f = open("ElectricvehicleTOP10.csv","r",encoding='cp949')
data = csv.reader(f)
next(data)

increase = []

for row in data :
    if row[-1] != '':
        increase.append(float(row[-1]))

plt.figure(figsize=(10, 6))
plt.rc('font',family='Malgun Gothic')
plt.title("전기차 증가율 TOP 10 자치구")
plt.xticks([0,1,2,3,4,5,6,7,8,9], ['구로', '중구', '은평','강북','중랑','금천','강서','성북','영등포','동대문'])
plt.bar(range(10),increase, color='dodgerblue')
plt.show()
    
