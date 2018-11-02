import coremltools

caffe_model = ('FlowerClassifier/oxford102.caffemodel', 'FlowerClassifier/deploy.prototxt')

labels = 'FlowerClassifier/flower-labels.txt'

coreml_model = coremltools.converters.caffe.convert(
    caffe_model,
    class_labels=labels,
    image_input_names='data'
)

coreml_model.save('FlowerClassifier.mlmodel')
