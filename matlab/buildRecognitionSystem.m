fprintf('Running 2.3 \n');
load('../data/traintest.mat', 'train_imagenames', 'train_labels');
len = length(train_imagenames);

load('dictionaryHarris.mat', 'filterBank', 'dictionary');
dict_size = size(dictionary,1);
train_features = zeros(len,dict_size);
for i=1:len
    wordMap = load(['../data/', strrep(train_imagenames{i},'.jpg','.mat')],'wordMap');
    train_features(i, :) = getImageFeatures(wordMap.wordMap, dict_size);
end
save('visionHarris.mat', 'dictionary', 'filterBank', 'train_features','train_labels');


load('dictionaryRandom.mat', 'filterBank', 'dictionary');
dict_size = size(dictionary,1);
train_features = zeros(len,dict_size);
for i=1:len
    wordMap = load(['../data/', strrep(train_imagenames{i},'.jpg','_r.mat')],'wordMap');
    train_features(i, :) = getImageFeatures(wordMap.wordMap, dict_size);
end
save('visionRandom.mat', 'dictionary', 'filterBank', 'train_features', 'train_labels'); 

                       