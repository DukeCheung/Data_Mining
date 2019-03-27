import numpy as np
import matplotlib.pyplot as plt
from numpy import *


# z = ax+by+c

def test(a, b, c, arr):
    
    length = len(arr)
    area = arr['area']
    distance = arr['distance']
    price = arr['price']
    error = 0.0

    for i in range(0, length):
        x = area[i]
        y = distance[i]
        z = price[i]
        f = (a * x) + (b * y) + c
        error += (1/float(length))*np.power((f - z), 2)
    return error
    
def gradient_descent(a, b, c, data, learning_rate):
    gradient_a = 0.0
    gradient_b = 0.0
    gradient_c = 0.0
    area = data['area']
    distance = data['distance']
    price = data['price']
    length = len(area)

    for i in range(0, length):
        x = area[i]
        y = distance[i]
        z = price[i]
        gradient_a += (1/float(length)) * (((a * x) + (b * y) + c) - z) * x
        gradient_b += (1/float(length)) * (((a * x) + (b * y) + c) - z) * y 
        gradient_c += (1/float(length)) * (((a * x) + (b * y) + c) - z)
    next_a = a - (learning_rate * gradient_a)
    next_b = b - (learning_rate * gradient_b)
    next_c = c - (learning_rate * gradient_c)
    return [next_a, next_b, next_c]

data = np.genfromtxt('dataForTraining.txt',
                     delimiter=' ',
                     names=['area', 'distance', 'price'])
testSet = np.genfromtxt('dataForTesting.txt',
                            delimiter = ' ',
                            names = ['area', 'distance', 'price'])
learning_rate = 0.00015
a = 0.0
b = 0.0
c = 0.0
num_iteration = 1500000
errorForTraining = []
errorForTesting = []
for i in range(0, num_iteration):
    a, b, c = gradient_descent(a, b, c, data, learning_rate)
    if i % 100000 == 0 and i != 0:
        errorForTraining.append(test(a, b, c, data))
        errorForTesting.append(test(a, b, c, testSet))
min_training = min(errorForTraining)
max_training = max(errorForTraining)
min_testing = min(errorForTesting)
max_testing = max(errorForTesting)
for i in range(0, len(errorForTraining)):
               errorForTraining[i] = float(errorForTraining[i]-min_training)/(max_training-min_training)

for i in range(0, len(errorForTesting)):
               errorForTesting[i] = float(errorForTesting[i]-min_testing)/(max_testing-min_testing)

X = []
for i in range(1, 15):
    X.append(i*100000)
plt.figure(1)
plt.plot(X, errorForTraining)
plt.plot(X, errorForTesting)
plt.title('BGD with learning rate = 0.00015')
plt.xlabel('Iterations')
plt.ylabel('Error')
plt.show()
        
    
