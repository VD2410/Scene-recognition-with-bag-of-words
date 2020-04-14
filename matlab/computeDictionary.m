load('../data/traintest.mat');
filterBank = createFilterBank();


dictionary = getDictionary(train_imagenames, 200, 100, 'random');
save('dictionaryRandom.mat', 'filterBank', 'dictionary');


dictionary = getDictionary(train_imagenames, 200, 100, 'harris');
save('dictionaryHarris.mat', 'filterBank', 'dictionary');

