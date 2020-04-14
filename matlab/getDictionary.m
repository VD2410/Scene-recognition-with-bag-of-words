function [dictionary] = getDictionary(imgPaths, alpha, K, method)


filter_bank = createFilterBank();
% 
pixel_responses = zeros(alpha*length(imgPaths), 3*size(filter_bank,1));

for i = 1:length(imgPaths)
    img_path = strcat('../data/', imgPaths{i});
    
    img = imread(img_path);
    
    img = double(img)/255;
    
    filter_response = extractFilterResponses(img, filter_bank);
%     filter_response = tryBetterFeatures(img);
    

    if method == "random"
        points = getRandomPoints(img,alpha);
    end
    
    if method == "harris"
        points = getHarrisPoints(img,alpha,0.05);
    end
    

    ptr = (i-1)*alpha;
    
    for p = 1:alpha
        
    
        pixel_responses(p+ptr,:) = filter_response(points(p,1), points(p,2), :);
    
    end
    
end

[~, dictionary] = kmeans(pixel_responses, K, 'EmptyAction', 'drop');
