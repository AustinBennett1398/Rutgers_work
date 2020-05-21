import matplotlib.pyplot as plt

def plot_digits(y, descriptor = 'accuracy'):
    digits = [500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, 4500, 5000]
    plt.plot(digits, y)
    plt.xlabel('# of data points used')
    if(descriptor == 'accuracy'):
        plt.ylabel('Test Accuracy %')
        plt.title('K-Nearest Neighbor test accuracy per sample size')
    else:
        plt.ylabel('Time in seconds')
        plt.title('K-Nearest Neighbor time per sample size')
    plt.show()

def plot_faces(y, descriptor = 'accuracy'):
    faces = [45, 90, 135, 180, 225, 270, 315, 360, 405, 451]
    plt.plot(faces, y)
    plt.xlabel('# of data points used')
    if(descriptor == 'accuracy'):
        plt.ylabel('Test Accuracy %')
        plt.title('Naive Bayes test accuracy per sample size')
    else:
        plt.ylabel('Time in seconds')
        plt.title('Naive Bayes time per sample size')
    plt.show()



if __name__ == '__main__':
    time = [447,	890	,1327,	1798,	2327,	2755,	3417,	3853	,4065,	4510]
    accuracy = [61.3,	66.6,	70	,70.8	,73.3,	73.5,	75	,76,	77.5,	78.2]
    plot_digits(time, descriptor = 'time')
    plot_digits(accuracy, descriptor = 'accuracy')

    # plot_faces(time, descriptor = 'time')
    # plot_faces(accuracy, descriptor = 'accuracy')