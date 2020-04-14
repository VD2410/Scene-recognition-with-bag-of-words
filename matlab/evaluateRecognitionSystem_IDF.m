load('../data/traintest.mat');
len_test = length(test_imagenames);
len_train = length(train_imagenames);
%Harris
load('dictionaryHarris.mat');
dict_size=size(dictionary,1);
load('visionHarris.mat');
load('IDFHarris.mat');
correctEuclid=0;
incorrectEuclid=0;
correctChi2=0;
incorrectChi2=0;
CeuclideanHarris=zeros(8,8);
Cchi2Harris=zeros(8,8);

for i=1:len_test

    wordMapStruct=load(['../data/', strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');

    test_features=getImageFeatures(wordMapStruct.wordMap, dict_size);
    for s=1:len_train
        train_feature = train_features(s, :);
        distEuclid(s) = getImageDistance(test_features, train_feature, 'euclidean');   
    end
    [distMinEuclid,IminEuclid]=min(distEuclid);
    outputLabelEuclid=train_labels(IminEuclid);
    CeuclideanHarris(test_labels(i),train_labels(IminEuclid))=CeuclideanHarris(test_labels(i),train_labels(IminEuclid))+1;
    if (outputLabelEuclid==test_labels(i))
        correctEuclid=correctEuclid+1;
    else
        incorrectEuclid=incorrectEuclid+1;
    end
    for s=1:len_train
        train_feature = train_features(s, :);
        distChi2(s) = getImageDistance(test_features, train_feature, 'chi2');   
    end
    [distMinChi2,IminChi2]=min(distChi2);
    outputLabelChi2=train_labels(IminChi2);
    Cchi2Harris(test_labels(i),train_labels(IminChi2))=Cchi2Harris(test_labels(i),train_labels(IminChi2))+1;
    if (outputLabelChi2==test_labels(i))
        correctChi2=correctChi2+1;
    else
        incorrectChi2=incorrectChi2+1;
    end
end

totalEuclid=correctEuclid+incorrectEuclid;
accuracyEuclideanHarris=correctEuclid/totalEuclid;
fprintf("Confusion matrix Harris Euclidean");
disp(accuracyEuclideanHarris)
disp(CeuclideanHarris);
totalChi2=correctChi2+incorrectChi2;
accuracyChi2Harris=correctChi2/totalChi2;
fprintf("Confusion matrix Harris Chi2");
disp(accuracyChi2Harris)
disp(Cchi2Harris);

%Random
load('../data/traintest.mat');
len_test = length(test_imagenames);

%Harris
load('dictionaryRandom.mat');
dict_size=size(dictionary,1);
load('visionRandom.mat');
load('IDFRandom.mat','idf');
correctEuclid=0;
incorrectEuclid=0;
correctChi2=0;
incorrectChi2=0;
CeuclideanHarris=zeros(8,8);
Cchi2Harris=zeros(8,8);

for i=1:len_test

    wordMapStruct=load(['../data/', strrep(test_imagenames{i},'.jpg','_r.mat')],'wordMap');

    test_features=getImageFeatures(wordMapStruct.wordMap, dict_size);
    
    for s=1:len_train
        train_feature = train_features(s, :);
        distEuclid(s) = getImageDistance(test_features, train_feature, 'euclidean');   
    end
    [distMinEuclid,IminEuclid]=min(distEuclid);
    outputLabelEuclid=train_labels(IminEuclid);
    CeuclideanHarris(test_labels(i),train_labels(IminEuclid))=CeuclideanHarris(test_labels(i),train_labels(IminEuclid))+1;
    if (outputLabelEuclid==test_labels(i))
        correctEuclid=correctEuclid+1;
    else
        incorrectEuclid=incorrectEuclid+1;
    end
    for s=1:len_train
        train_feature = train_features(s, :);
        distChi2(s) = getImageDistance(test_features, train_feature, 'chi2');   
    end
    [distMinChi2,IminChi2]=min(distChi2);
    outputLabelChi2=train_labels(IminChi2);
    Cchi2Harris(test_labels(i),train_labels(IminChi2))=Cchi2Harris(test_labels(i),train_labels(IminChi2))+1;
    if (outputLabelChi2==test_labels(i))
        correctChi2=correctChi2+1;
    else
        incorrectChi2=incorrectChi2+1;
    end
end

totalEuclid=correctEuclid+incorrectEuclid;
accuracyEuclideanHarris=correctEuclid/totalEuclid;
fprintf("Confusion matrix Random Euclidean");
disp(accuracyEuclideanHarris)
disp(CeuclideanHarris);
totalChi2=correctChi2+incorrectChi2;
accuracyChi2Harris=correctChi2/totalChi2;

fprintf("Confusion matrix Random Chi2");
disp(accuracyChi2Harris)
disp(Cchi2Harris);