import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "./data/twitter-sanders-apple3.csv"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 666)

let model = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = model.evaluation(on: testingData)

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError)*100

let metadata = MLModelMetadata(author: "Jerry", shortDescription: "Tweets sentiment classification", license: "", version: "1.0", additional: [:])

try model.write(to: URL(fileURLWithPath: "./model/TwitterSentimentClassifier.mlmodel"), metadata: metadata)

