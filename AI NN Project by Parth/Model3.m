%Parth Joshi 1126914 COMP 4475 AI Project

rng("default");

% Partitioning the data set to have 70% training, 30% testing
partition = cvpartition(dataset.StarType, "HoldOut", 0.3);
trainingSet = training(partition);
testingSet = test(partition);
tblTrain = dataset(trainingSet, :);
tblTest = dataset(testingSet, :);

% Split testing data so the overall data partition is 70% training, 15%
% testing, 15% validation
partition = cvpartition(tblTest.StarType, "HoldOut", 0.5);
validationSet = training(partition);
testingSet = test(partition);
tblValidation = tblTest(validationSet, :);
tblTest = tblTest(testingSet, :);

% Model 3
mdl3 = fitcnet(tblTrain, "StarType", "ValidationData", tblValidation, "Verbose", 1, "Standardize", true);

% Calculate accuracy
accuracy3 = 1 - loss(mdl3, tblTest, "StarType");

% Display confusion chart
confusionchart(tblTest.StarType, predict(mdl3,tblTest));

% Compare training cross-entropy loss and validation cross-entropy loss 
iteration = mdl3.TrainingHistory.Iteration;
trainLosses = mdl3.TrainingHistory.TrainingLoss;
valLosses = mdl3.TrainingHistory.ValidationLoss;
plot(iteration, trainLosses, "--", iteration, valLosses, "-");
legend(["Training","Validation", "Training","Validation"]);
xlabel("Iteration");
ylabel("Cross-Entropy Loss");