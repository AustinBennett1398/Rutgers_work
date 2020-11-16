import matplotlib.pyplot as plt
import keras
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import Dense, Conv2D, Flatten, BatchNormalization, MaxPooling2D, Dropout

import os
from sklearn.model_selection import train_test_split
import pandas as pd
from PIL import Image
import cv2
import glob
import numpy as np
from skimage.io import imread
from skimage.transform import resize

class My_Custom_Generator(keras.utils.Sequence) :
  
  def __init__(self, image_filenames, labels, batch_size) :
    self.image_filenames = image_filenames
    self.labels = labels
    self.batch_size = batch_size
    
    
  def __len__(self) :
    return (np.ceil(len(self.image_filenames) / float(self.batch_size))).astype(np.int)
  
  
  def __getitem__(self, idx) :
    batch_x = self.image_filenames[idx * self.batch_size : (idx+1) * self.batch_size]
    batch_y = self.labels[idx * self.batch_size : (idx+1) * self.batch_size]
    
    return np.array([
            resize(imread(file_name), (img_rows, img_cols, 3))
               for file_name in batch_x]), np.array(batch_y)

batch_size = 32
num_classes = 15 #{'BAS', 'EBO', 'EOS', 'KSC', 'LYA', 'LYT', 'MMZ', 'MOB', 'MON', 'MYB', 'MYO', 'NGB', 'NGS', 'PMB', 'PMO'}
epochs = 3

image = Image.open("E:/439/FOLDER_WITH_ALL/NGB_0085.tiff")
img_rows, img_cols = image.size

img_dir = 'E:/439/FOLDER_WITH_ALL'
# img_dir = 'E:/439/MYO'
img_dir_one = 'E:/439/test'
img_extension = '*tiff'
data_path = os.path.join(img_dir, img_extension)
data_path_1image = os.path.join(img_dir_one, img_extension)
files = glob.glob(data_path)
# files= glob.glob(data_path_1image)
data = []
labels = []
for f1 in files:
    # classification = f1[11:14]
    classification = f1[23:26]
    if(classification == 'BAS'):
        labels.append(0)
    elif(classification == 'EBO'):
        labels.append(1)
    elif(classification == 'EOS'):
        labels.append(2)
    elif(classification == 'KSC'):
        labels.append(3)
    elif(classification == 'LYA'):
        labels.append(4)
    elif(classification == 'LYT'):
        labels.append(5)
    elif(classification == 'MMZ'):
        labels.append(6)
    elif(classification == 'MOB'):
        labels.append(7)
    elif(classification == 'MON'):
        labels.append(8)
    elif(classification == 'MYB'):
        labels.append(9)
    elif(classification == 'MYO'):
        labels.append(10)
    elif(classification == 'NGB'):
        labels.append(11)
    elif(classification == 'NGS'):
        labels.append(12)
    elif(classification == 'PMB'):
        labels.append(13)
    elif(classification == 'PMO'):
        labels.append(14)

    # img = cv2.imread(f1, 1)
    # data.append(img)
    data.append(f1)



x_train, x_test, y_train, y_test = train_test_split(data, labels, test_size=0.2)



#one-hot encode target column
y_train = to_categorical(y_train, num_classes=num_classes)
y_test = to_categorical(y_test, num_classes=num_classes)
# print(y_train[0])


my_training_batch_generator = My_Custom_Generator(x_train, y_train, batch_size)
my_validation_batch_generator = My_Custom_Generator(x_test, y_test, batch_size)

#create model
model = Sequential()

# add model layers
model.add(Conv2D(32, kernel_size=3, activation='relu', input_shape=(img_rows,img_cols,3)))
model.add(Conv2D(64, (3, 3)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))


#compile model using accuracy to measure model performance
model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

#train the model
# model.fit(x_train, y_train, validation_data=(x_test, y_test), epochs=1, batch_size=batch_size)
model.fit_generator(generator=my_training_batch_generator,
                   steps_per_epoch = int(14692 // batch_size),
                   epochs = epochs,
                   verbose = 1,
                   validation_data = my_validation_batch_generator,
                   validation_steps = int(3673 // batch_size))

#predict first 20 images in the test set
model.predict(x_test[:20])

