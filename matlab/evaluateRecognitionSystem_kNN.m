
fprintf('Running kNN \n');
load('../data/traintest.mat');
load('visionHarris.mat');
load('dictionaryHarris.mat');
dict_size = size(dictionary,1);


len_test = length(test_imagenames);
len_train = length(train_imagenames);

classes = zeros(len_test, 40);

correct_perK = zeros(40, 1);

distance = zeros(len_train, 1);

confusion = zeros(8, 8);

%classify each image
for k = 1:40
    for i=1:len_test
        correct = zeros(8,1);
        
        wordMap=load(['../data/', strrep(test_imagenames{i}(1:end-4),'.jpg','.mat')],'wordMap');
        test_features = getImageFeatures(wordMap.wordMap, dict_size);
        
        for s=1:len_train
            train_feature = train_features(s, :);
            distance(s) = getImageDistance(test_features, train_feature, 'chi2');   
        end
        
        %find k nearest neighbors
        [~, sortedI] = sort(distance);
        knearest = sortedI(1:k);
        
        %loop through each neighbor and get its vote
        for n=1:k
            label = train_labels(knearest(n));
            correct(label) = correct(label) + 1;
        end
        
        %find label with maximum votes
        [~, class] = max(correct);
        
        classes(i, k) = class;
        
        realL = test_labels(i);
        if realL == class
            correct_perK(k) = correct_perK(k) + 1;
        end
        
    end
end

[~, bestk] = max(correct_perK);
accuracies = correct_perK ./ len_test;

%fill in confusion matrix for bestK
for i=1:len_test 
    real = test_labels(i);   
    j = classes(i, bestk);
    confusion(real, j) = confusion(real, j) + 1;
end
[v,i] = max(accuracies);
fprintf("Harris and Euclidean Best accuracy is")
disp(v)
fprintf("at K")
disp(i)
disp(confusion);
plot(accuracies);