function [filterResponses] = extractFilterResponses(I, filterBank)
I = double(I);

if length(size(I)) == 2
    
    [L,a,b] = RGB2Lab(I(:,:),I(:,:), I(:,:));
else
    [L,a,b] = RGB2Lab(I(:,:,1),I(:,:,2), I(:,:,3));
    
end
% disp(size(I))
row = size(I,1);
col = size(I,2);
n_filter = 3 * size(filterBank, 1);
filterResponses = zeros(row,col,n_filter);

for i = 1:1:size(filterBank,1)
    
%     disp(size(conv2(L,filterBank{i},'same')))
    
    filterResponses(:,:,3*i-2) = imfilter(L,filterBank{i});
    
    filterResponses(:,:,3*i-1) = imfilter(a,filterBank{i});
    
    filterResponses(:,:,3*i) =  imfilter(b,filterBank{i});

end