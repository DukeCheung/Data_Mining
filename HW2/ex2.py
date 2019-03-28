import numpy as np
import matplotlib.pyplot as plt
from numpy import *


# z = ax+by+c

def standardize(X):
    m, n = X.shape
    for i in range(0, n):
        arr = X[:, i]
        meanVal = arr.mean(axis=0)
        std = arr.std(axis=0)
        if std != 0:
            X[:, i] = (arr-meanVal)/std
        else:
            X[:, i] = 0
    return X
    
def test(a, b, c, data):
    
    length, n = data.shape
    error = 0.0

    for i in range(0, length):
        x = data[i, 0]
        y = data[i, 1]
        z = data[i, 2]
        f = (a * x) + (b * y) + c
        error += (1/float(length))*np.power((f - z), 2)
    return error
    
def gradient_descent(a, b, c, data, learning_rate):
    gradient_a = 0.0
    gradient_b = 0.0
    gradient_c = 0.0
    length, n = data.shape

    for i in range(0, length):
        x = data[i, 0]
        y = data[i, 1]
        z = data[i, 2]
        gradient_a += (1/float(length)) * (((a * x) + (b * y) + c) - z) * x
        gradient_b += (1/float(length)) * (((a * x) + (b * y) + c) - z) * y 
        gradient_c += (1/float(length)) * (((a * x) + (b * y) + c) - z)
    next_a = a - (learning_rate * gradient_a)
    next_b = b - (learning_rate * gradient_b)
    next_c = c - (learning_rate * gradient_c)
    return [next_a, next_b, next_c]
def run():
    trainingData = np.genfromtxt('dataForTraining.txt',
                         delimiter=' ')
    testData = np.genfromtxt('dataForTesting.txt',
                                delimiter = ' ')
    learning_rate = 0.0002

    trainingData = standardize(trainingData)
    testData = standardize(testData)
    a = 0.0
    b = 0.0
    c = 0.0
    num_iteration = 1500000
    errorForTraining = []
    errorForTesting = []
    for i in range(0, num_iteration):
        a, b, c = gradient_descent(a, b, c, trainingData, learning_rate)
        if i % 100000 == 0 and i != 0:
            errorForTraining.append(test(a, b, c, trainingData))
            errorForTesting.append(test(a, b, c, testData))
    X = []
    for i in range(1, 15):
        X.append(i*100000)
    plt.figure(1)
    plt.plot(X, errorForTraining)
    plt.plot(X, errorForTesting)
    plt.title('BGD with learning rate = 0.0002')
    plt.xlabel('Iterations')
    plt.ylabel('Error')
    plt.show()
if __name__ == '__main__':
    run()
