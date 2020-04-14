function [ h ] = getImageFeatures(wordMap, dictionarySize)

% h(i) should be equal to the number of times visual word i occurred in the word map

h = zeros(1, dictionarySize);

for i=1:dictionarySize
    h(i) = sum(wordMap(:) == i);
end
h = h/(norm(h, 1));

end