import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from keras.models import Sequential
from keras.layers import LSTM, Dropout, Dense, Activation
from keras.callbacks import TensorBoard, ModelCheckpoint, ReduceLROnPlateau
import datetime
import pandas_datareader.data as web
import mpl_finance
import matplotlib.ticker as ticker

# 데이터셋 불러오기
data = pd.read_csv('C:/Users/anwls/OneDrive/바탕 화면/BTC-USD.csv')
data.head()

open_prices = data['Open'].values

# open
seq_len = 50
sequence_length = seq_len + 1

open_result = []
for index in range(len(open_prices) - sequence_length):
    open_result.append(open_prices[index: index + sequence_length])

normalized_data = []
for window in open_result:
    normalized_window = [((float(p) / float(window[0])) - 1) for p in window]
    normalized_data.append(normalized_window)

open_result = np.array(normalized_data)

row = int(round(open_result.shape[0] * 0.9))
train = open_result[:row, :]
np.random.shuffle(train)

open_x_train = train[:, :-1]
open_x_train = np.reshape(open_x_train, (open_x_train.shape[0], open_x_train.shape[1], 1))
open_y_train = train[:, -1]
open_x_test = open_result[row:, :-1]
open_x_test = np.reshape(open_x_test, (open_x_test.shape[0], open_x_test.shape[1], 1))
open_y_test = open_result[row:, -1]

open_x_train.shape, open_x_test.shape

# high
high_prices = data['High'].values

seq_len = 50
sequence_length = seq_len + 1

high_result = []
for index in range(len(high_prices) - sequence_length):
    high_result.append(high_prices[index: index + sequence_length])

normalized_data = []
for window in high_result:
    normalized_window = [((float(p) / float(window[0])) - 1) for p in window]
    normalized_data.append(normalized_window)

high_result = np.array(normalized_data)

row = int(round(high_result.shape[0] * 0.9))
train = high_result[:row, :]
np.random.shuffle(train)

high_x_train = train[:, :-1]
high_x_train = np.reshape(high_x_train, (high_x_train.shape[0], high_x_train.shape[1], 1))
high_y_train = train[:, -1]

high_x_test = high_result[row:, :-1]
high_x_test = np.reshape(high_x_test, (high_x_test.shape[0], high_x_test.shape[1], 1))
high_y_test = high_result[row:, -1]

high_x_train.shape, high_x_test.shape

# low
low_prices = data['Low'].values

seq_len = 50
sequence_length = seq_len + 1

low_result = []
for index in range(len(low_prices) - sequence_length):
    low_result.append(low_prices[index: index + sequence_length])

normalized_data = []
for window in low_result:
    normalized_window = [((float(p) / float(window[0])) - 1) for p in window]
    normalized_data.append(normalized_window)

low_result = np.array(normalized_data)

row = int(round(low_result.shape[0] * 0.9))
train = low_result[:row, :]
np.random.shuffle(train)

low_x_train = train[:, :-1]
low_x_train = np.reshape(low_x_train, (low_x_train.shape[0], low_x_train.shape[1], 1))
low_y_train = train[:, -1]

low_x_test = low_result[row:, :-1]
low_x_test = np.reshape(low_x_test, (low_x_test.shape[0], low_x_test.shape[1], 1))
low_y_test = low_result[row:, -1]

low_x_train.shape, low_x_test.shape

# close
close_prices = data['Close'].values

seq_len = 50
sequence_length = seq_len + 1

close_result = []
for index in range(len(close_prices) - sequence_length):
    close_result.append(close_prices[index: index + sequence_length])

normalized_data = []
for window in close_result:
    normalized_window = [((float(p) / float(window[0])) - 1) for p in window]
    normalized_data.append(normalized_window)

close_result = np.array(normalized_data)

row = int(round(close_result.shape[0] * 0.9))
train = close_result[:row, :]
np.random.shuffle(train)

close_x_train = train[:, :-1]
close_x_train = np.reshape(close_x_train, (close_x_train.shape[0], close_x_train.shape[1], 1))
close_y_train = train[:, -1]

close_x_test = close_result[row:, :-1]
close_x_test = np.reshape(close_x_test, (close_x_test.shape[0], close_x_test.shape[1], 1))
close_y_test = close_result[row:, -1]

close_x_train.shape, close_x_test.shape

# 모델 생성
model = Sequential()
model.add(LSTM(50, return_sequences=True, input_shape=(50, 1)))
model.add(LSTM(64, return_sequences=False))
model.add(Dense(1, activation='linear'))
model.compile(loss='mse', optimizer='rmsprop')
model.summary()

# 모델 학습
model.fit(open_x_train, open_y_train, validation_data=(open_x_test, open_y_test), batch_size=10, epochs=20)
model.fit(high_x_train, high_y_train, validation_data=(high_x_test, high_y_test), batch_size=10, epochs=20)
model.fit(low_x_train, low_y_train, validation_data=(low_x_test, low_y_test), batch_size=10, epochs=20)
model.fit(close_x_train, close_y_train, validation_data=(close_x_test, close_y_test), batch_size=10, epochs=20)

# 예측
open_pred = model.predict(open_x_test)
high_pred = model.predict(high_x_test)
low_pred = model.predict(low_x_test)
close_pred = model.predict(close_x_test)

fig = plt.figure(facecolor='white', figsize=(30, 20))

plt.subplot(221)
plt.title("Open")
plt.plot(open_y_test, label='True')
plt.plot(open_pred, label='Prediction')
plt.legend()


#fig = plt.figure(facecolor='white', figsize=(15, 7))

plt.subplot(222)
plt.title("High")
plt.plot(high_y_test, label='True')
plt.plot(high_pred, label='Prediction')
plt.legend()


#fig = plt.figure(facecolor='white', figsize=(15, 7))

plt.subplot(223)
plt.title('Low')
plt.plot(low_y_test, label='True')
plt.plot(low_pred, label='Prediction')
plt.legend()


#fig = plt.figure(facecolor='white', figsize=(15, 7))

plt.subplot(224)
plt.title('Close')
plt.plot(close_y_test, label='True')
plt.plot(close_pred, label='Prediction')
plt.legend()
plt.show()

#예측한 값을 바탕으로  DataFrame 생성
open = []
high = []
low = []
close = []
for i in range(0,len(open_pred)):
    open.append(open_pred[i, 0])
    high.append(high_pred[i, 0])
    low.append(low_pred[i, 0])
    close.append(close_pred[i, 0])
df = pd.DataFrame(open)
df.columns = ['Open']
df['High'] = high
df['Low'] = low
df['Close'] = close
print(df)


#예측한 값을 이용하여 candle 차트 출력
fig = plt.figure(figsize=(12, 8))
ax = fig.add_subplot(111)
mpl_finance.candlestick2_ohlc(ax, df['Open'], df['High'], df['Low'], df['Close'], width=0.5, colorup='r', colordown='b')
plt.title("BTC-USD Prediction Chart")
plt.show()