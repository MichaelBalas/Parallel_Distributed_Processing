import keras
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D
from keras.layers import Activation, Dropout, Flatten, Dense
from keras import backend as K
import matplotlib.pylab as plt
from matplotlib.ticker import MaxNLocator

# dimensions of our images.
img_width, img_height = 150, 150

train_data_dir = 'data/train'
validation_data_dir = 'data/validation'
nb_train_samples = 2000
nb_validation_samples = 800
epochs = 50
batch_size = 16

if K.image_data_format() == 'channels_first':
    input_shape = (3, img_width, img_height)
else:
    input_shape = (img_width, img_height, 3)

def createModel2():
	model = Sequential()
	model.add(Conv2D(32, (3, 3), input_shape=input_shape))
	model.add(Activation('relu'))
	model.add(MaxPooling2D(pool_size=(2, 2)))

	model.add(Conv2D(32, (3, 3)))
	model.add(Activation('relu'))
	model.add(MaxPooling2D(pool_size=(2, 2)))

	model.add(Conv2D(64, (3, 3)))
	model.add(Activation('relu'))
	model.add(MaxPooling2D(pool_size=(2, 2)))

	model.add(Flatten())
	model.add(Dense(64))
	model.add(Activation('relu'))
	model.add(Dense(1))
	model.add(Activation('sigmoid'))
	return model

model2 = createModel2()
model2.compile(loss='binary_crossentropy',
              optimizer='rmsprop',
              metrics=['accuracy'])

# this is the augmentation configuration we will use for training

train_datagen2 = ImageDataGenerator(rescale=1. / 255)

# this is the augmentation configuration we will use for testing:
# only rescaling
test_datagen = ImageDataGenerator(rescale=1. / 255)

train_generator2 = train_datagen2.flow_from_directory(
    train_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

validation_generator = test_datagen.flow_from_directory(
    validation_data_dir,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='binary')

history2 = model2.fit_generator(
    train_generator2,
    steps_per_epoch=nb_train_samples // batch_size,
    epochs=epochs,
    validation_data=validation_generator,
    validation_steps=nb_validation_samples // batch_size)

### Without Data Augmentation or Downsampling ###
# Loss Curves
plt.figure(3)
plt.xlim(0,epochs)
plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))
plt.plot(history2.history['loss'], 'r', linewidth=3.0)
plt.plot(history2.history['val_loss'], 'b', linewidth=3.0)
plt.legend(['Training loss', 'Validation Loss'], fontsize=18)
plt.xlabel('Epochs', fontsize=16)
plt.ylabel('Loss', fontsize=16)
plt.gca().spines['top'].set_position(('data',0))
plt.gca().spines['right'].set_position(('data',0))
plt.title('Loss Curve', fontsize=24)
# Accuracy Curves
plt.figure(4)
plt.xlim(0,epochs)
plt.ylim(0,1)
plt.gca().xaxis.set_major_locator(MaxNLocator(integer=True))
plt.plot(history2.history['acc'], 'r', linewidth=3.0)
plt.plot(history2.history['val_acc'], 'b', linewidth=3.0)
plt.legend(['Training Accuracy', 'Validation Accuracy'], fontsize=18)
plt.xlabel('Epochs', fontsize=16)
plt.ylabel('Accuracy', fontsize=16)
plt.title('Accuracy Curve', fontsize=24)
plt.gca().spines['top'].set_position(('data',0))
plt.gca().spines['right'].set_position(('data',0))
plt.show()


#model2.save_weights('model_withoutAugmentation.h5')


