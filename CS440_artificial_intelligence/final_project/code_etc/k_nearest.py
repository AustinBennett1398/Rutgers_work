# k_nearest.py
import util
import math
class KNeighborsClassifier:
    def __init__( self, legalLabels):
        self.legalLabels = legalLabels
        self.type = "k_nearest"

    def euclidean(self, vector1, vector2):
        distance = 0.0
        for feature in vector1:
            distance += (vector1[feature] - vector2[feature])**2
        return math.sqrt(distance)

    def classify(self, trainingData, trainingLabels, testData, testLabels):
        guesses = []
        k = int(math.sqrt(len(trainingData)))  #for faces
        # k = 7 #for digits

        for datum in testData:
            counter = 0
            all_distances = []
            nearest = []
            label_counts = util.Counter()
            for train_datum in trainingData:
                all_distances.append((counter, self.euclidean(train_datum, datum)))
                counter += 1
            all_distances.sort(key=lambda x: x[1])
            for i in range(k):
                nearest.append(all_distances[i][0])
            for i in nearest:
                label_counts[(trainingLabels[i])] += 1
            guesses.append(label_counts.argMax())

        return guesses