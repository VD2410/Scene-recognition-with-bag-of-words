load('../data/traintest.mat');
len_test = length(test_imagenames);
len_train = length(train_imagenames);

% Harris
load('visionHarris.mat');
load('dictionaryHarris.mat');
dict_size = size(dictionary,1);

distance_chi2 = zeros(len_train, 1); 
distance_euclidean = zeros(len_train, 1); 

correct_chi2 = 0;
correct_euclidean = 0;

C_euclidean = zeros(8, 8);
C_chi2 = zeros(8, 8);

%find closest neighbor for each image
for i=1:len_test
    wordMap=load(['../data/', strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
    test_features = getImageFeatures(wordMap.wordMap, dict_size);
    for j=1:len_train
        train_feature = train_features(j, :);
        distance_chi2(j) = getImageDistance(test_features, train_feature, 'chi2');
        distance_euclidean(j) = getImageDistance(test_features, train_feature, 'euclidean');     
    end
    
%     disp(min(distance_chi2))
%     disp(min(distance_euclidean))
    
    [~, min_index_chi2] = min(distance_chi2);
    [~, min_index_eucledian] = min(distance_euclidean);
    label_chi2 = train_labels(min_index_chi2);
    label_euclidean = train_labels(min_index_eucledian);
    


    if (label_chi2 == test_labels(i))
        correct_chi2 = correct_chi2 + 1;
    end
    
    if (label_euclidean == test_labels(i))
        correct_euclidean = correct_euclidean + 1;
    end
    
    C_chi2(test_labels(i), label_chi2) = C_chi2(test_labels(i), label_chi2) + 1;
    C_euclidean(test_labels(i), label_euclidean) = C_euclidean(test_labels(i), label_euclidean) + 1;
    
%     disp(correct_chi2)
%     disp(correct_euclidean)
    
end
disp(correct_chi2)
disp(correct_euclidean)
fprintf('Harris and chi2  %4.2f \n', correct_chi2/len_test);
fprintf('Confusion matrix is: \n');
disp(C_chi2);

fprintf('\n Harris and Euclidean %4.2f \n', correct_euclidean/len_test);
fprintf('Confusion Matrix: \n');
disp(C_euclidean);


%  Random
load('visionRandom.mat');
load('dictionaryRandom.mat');
dict_size = size(dictionary,1);

distance_chi2 = zeros(len_train, 1); 
distance_euclidean = zeros(len_train, 1); 

correct_chi2 = 0;
correct_euclidean = 0;

C_euclidean = zeros(8, 8);
C_chi2 = zeros(8, 8);

%find closest neighbor for each image
for i=1:len_test
    wordMap=load(['../data/', strrep(test_imagenames{i},'.jpg','_r.mat')],'wordMap');
    test_features = getImageFeatures(wordMap.wordMap, dict_size);
    for j=1:len_train
        train_feature = train_features(j, :);
        distance_chi2(j) = getImageDistance(test_features, train_feature, 'chi2');
        distance_euclidean(j) = getImageDistance(test_features, train_feature, 'euclidean');     
    end
    
    [~, min_index_chi2] = min(distance_chi2);
    [~, min_index_eucledian] = min(distance_euclidean);
    label_chi2 = train_labels(min_index_chi2);
    label_euclidean = train_labels(min_index_eucledian);
    
    C_chi2(test_labels(i), label_chi2) = C_chi2(test_labels(i), label_chi2) + 1;
    C_euclidean(test_labels(i), label_euclidean) = C_euclidean(test_labels(i), label_euclidean) + 1;

    if (label_chi2 == test_labels(i))
        correct_chi2 = correct_chi2 + 1;
    end
    
    if (label_euclidean == test_labels(i))
        correct_euclidean = correct_euclidean + 1;
    end
    
end

fprintf('Random and chi2  %4.2f \n', correct_chi2/len_test);
fprintf('Confusion matrix is: \n');
disp(C_chi2);

fprintf('\n Random and Euclidean %4.2f \n', correct_euclidean/len_test);
fprintf('Confusion Matrix: \n');
disp(C_euclidean);
