load('../data/traintest.mat');
l = length(train_imagenames);
load('dictionaryRandom.mat');
dict_size=size(dictionary,1);
load('visionRandom.mat','train_features');

for i=1:dict_size
    h(i)=0;
    h(i)=sum(train_features(:,i) > 0);
    idf(i)=log(l/h(i));
end
save('IDFRandom.mat','idf');

load('dictionaryHarris.mat');
dict_size=size(dictionary,1);
load('visionHarris.mat','train_features');

for i=1:dict_size
    h(i)=0;
    h(i)=sum(train_features(:,i) > 0);
    idf(i)=log(l/h(i));
end
size(idf)
save('IDFHarris.mat','idf');
