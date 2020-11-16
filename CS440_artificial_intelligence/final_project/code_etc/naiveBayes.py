# naiveBayes.py
# -------------
# Licensing Information: Please do not distribute or publish solutions to this
# project. You are free to use and extend these projects for educational
# purposes. The Pacman AI projects were developed at UC Berkeley, primarily by
# John DeNero (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# For more info, see http://inst.eecs.berkeley.edu/~cs188/sp09/pacman.html

import util
import classificationMethod
import math
from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score
from sklearn.model_selection import StratifiedKFold

class NaiveBayesClassifier(classificationMethod.ClassificationMethod):
  """
  See the project description for the specifications of the Naive Bayes classifier.
  
  Note that the variable 'datum' in this code refers to a counter of features
  (not to a raw samples.Datum).
  """
  def __init__(self, legalLabels):
    self.legalLabels = legalLabels
    self.type = "naivebayes"
    self.k = 1 # this is the smoothing parameter, ** use it in your train method **
    self.automaticTuning = False # Look at this flag to decide whether to choose k automatically ** use this in your train method **
    
  def setSmoothing(self, k):
    """
    This is used by the main method to change the smoothing parameter before training.
    Do not modify this method.
    """
    self.k = k

  def train(self, trainingData, trainingLabels, validationData, validationLabels):
    """
    Outside shell to call your method. Do not modify this method.
    """  
      
    # might be useful in your code later...
    # this is a list of all features in the training set.
    self.features = list(set([ f for datum in trainingData for f in datum.keys() ]))
    
    if (self.automaticTuning):
        # kgrid = [0.001, 0.01, 0.05, 0.1, 0.5, 1, 5, 10, 20, 50]
        kgrid = [.001, .002, .003, .01, .02, .03, .1, .2, .3, 1, 2, 3, 10, 20, 30]
    else:
        kgrid = [self.k]
        
    self.trainAndTune(trainingData, trainingLabels, validationData, validationLabels, kgrid)
      
  def trainAndTune(self, trainingData, trainingLabels, validationData, validationLabels, kgrid):
    """
    Trains the classifier by collecting counts over the training data, and
    stores the Laplace smoothed estimates so that they can be used to classify.
    Evaluate each value of k in kgrid to choose the smoothing parameter 
    that gives the best accuracy on the held-out validationData.
    
    trainingData and validationData are lists of feature Counters.  The corresponding
    label lists contain the correct label for each datum.
    
    To get the list of all possible features or labels, use self.features and 
    self.legalLabels.
    """

    "*** YOUR CODE HERE ***"
    priors = util.Counter()
    feature_count_by_label = util.Counter()
    total_count_by_label = util.Counter()
    probability = dict()
    total_data = len(trainingData)

    #count prior data and features by label
    for x in range(total_data):
      cur_label = trainingLabels[x]
      priors[(cur_label)] += 1
      for feature, value in trainingData[x].items():
        #total times a particular feature appears for a particular label
        total_count_by_label[(feature, cur_label)] += 1
        #total times a particular feature AND particular value appears for a particular label
        feature_count_by_label[(feature, value, cur_label)] += 1

    for x in range(len(feature_count_by_label)):
      for key, value in feature_count_by_label.items():
        result = [a for a in key]
        feature = result[0]
        value = result[1]
        label = result[2]
        probability[(feature, value, label)] = feature_count_by_label[(feature, value, label)] / total_count_by_label[(feature, label)]
    #turn prior data into probabilities
    for x in priors:
      priors[(x)] = priors[(x)]/total_data
    self.priors = priors
    # self.total_count_by_label = total_count_by_label
    # self.feature_count_by_label = feature_count_by_label
    self.probability = probability
        
  def classify(self, testData):
    """
    Classify the data based on the posterior distribution over labels.
    
    You shouldn't modify this method.
    """
    guesses = []
    for datum in testData:
      posteriors = []
      for label in self.legalLabels:
        posteriors.append(self.priors[label])
        for feature, val in datum.items():
          if (feature, val, label) in self.probability:
            posteriors[label] *= self.probability[(feature, val, label)]
          else:
            pass
      guesses.append(posteriors.index(max(posteriors)))

    # guesses = []
    # for datum in testData:
    #   posteriors = []
    #   for label in self.legalLabels:
    #     posteriors.append(math.log(self.priors[label]))
    #     for feature, val in datum.items():
    #       if (feature, val, label) in self.probability:
    #         posteriors[label] *= math.log(self.probability[(feature, val, label)])
    #       else:
    #         pass
    #   guesses.append(posteriors.index(max(posteriors)))

    # print(guesses)
    return guesses
      
  def calculateLogJointProbabilities(self, datum):
    """
    Returns the log-joint distribution over legal labels and the datum.
    Each log-probability should be stored in the log-joint counter, e.g.
    logJoint[3] = <Estimate of log( P(Label = 3, datum) )>
    To get the list of all possible features or labels, use self.features and
    self.legalLabels.
    """
    logJoint = util.Counter()
    # for label in self.legalLabels:
    #   logJoint[label] = self.priors[label]
    #   for feature, num in datum:

      



    #     logJoint[label] = math.log(self.prior[label])
    #     for feat, value in datum.items():
    #         if value > 0:
    #             logJoint[label] += math.log(self.conditionalProb[feat,label])
    #         else:
    #             logJoint[label] += math.log(1-self.conditionalProb[feat,label])

    return logJoint

  def findHighOddsFeatures(self, label1, label2):
    """
    Returns the 100 best features for the odds ratio:
            P(feature=1 | label1)/P(feature=1 | label2)
    Note: you may find 'self.features' a useful way to loop through all possible features
    """
    featuresOdds = []

    for feat in self.features:
        featuresOdds.append((self.conditionalProb[feat, label1]/self.conditionalProb[feat, label2], feat))
    featuresOdds.sort()
    featuresOdds = [feat for val, feat in featuresOdds[-100:]]

    return featuresOdds
    

    
      
