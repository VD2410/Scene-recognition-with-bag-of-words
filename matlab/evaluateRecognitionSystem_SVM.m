load('../data/traintest.mat');


%Harris
load('dictionaryHarris.mat');


size_dict=size(dictionary,1);
len_test = length(test_imagenames);
load('visionHarris.mat');

t=templateSVM('KernelFunction','linear');

classifier = fitcecoc(train_features,train_labels,'Learners',t);

save('visionSVMHarris.mat','classifier');

correct=0;
incorrect=0;
CHarris=zeros(8,8);

for i=1:len_test
    wordMap=load(['../data/', strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
    test_features = getImageFeatures(wordMap.wordMap, size_dict);
    outputLabel=predict(classifier,test_features);
    CHarris(test_labels(i),outputLabel)=CHarris(test_labels(i),outputLabel)+1;
    if (outputLabel==test_labels(i))
        correct=correct+1;
    else
        incorrect=incorrect+1;
    end
end
total=correct+incorrect;
accuracy=correct/total;
fprintf("Accuracy with Harris")
disp(accuracy)
disp(CHarris);
%Random

load('dictionaryRandom.mat');


size_dict=size(dictionary,1);
load('visionRandom.mat')

t=templateSVM('KernelFunction','linear');

classifier = fitcecoc(train_features,train_labels,'Learners',t);

save('visionSVMRandom.mat','classifier');

correct=0;
incorrect=0;
CRandom=zeros(8,8);

for i=1:len_test
    wordMap=load(['../data/', strrep(test_imagenames{i},'.jpg','_r.mat')],'wordMap');
    test_features=getImageFeatures(wordMap.wordMap, size_dict);
    outputLabel=predict(classifier,test_features);
    CRandom(test_labels(i),outputLabel)=CRandom(test_labels(i),outputLabel)+1;
    if (outputLabel==test_labels(i))
        correct=correct+1;
    else
        incorrect=incorrect+1;
    end
end
total=correct+incorrect;
accuracyRandom=correct/total;
fprintf("Accuracy with Random")
disp(accuracy)
disp(CRandom);