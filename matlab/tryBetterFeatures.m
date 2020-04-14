function [filterResponses] = tryBetterFeatures(I)
I = double(I);

if length(size(I)) == 2
    
    [L,a,b] = RGB2Lab(I(:,:),I(:,:), I(:,:));
else
    [L,a,b] = RGB2Lab(I(:,:,1),I(:,:,2), I(:,:,3));
    
end

wavelength = 20;
orientation = [0 45 90 135];
filterBank = gabor(wavelength,orientation);
% disp(filterBank)
filterBank = filterBank';

% disp(size(I))

filterResponses = imgaborfilt([L a b],filterBank);

