function [points] = getHarrisPoints(I, alpha, k)

image = I;
con = ones(3,3);

if size(I,3) == 3
    image = rgb2gray(I);
end

% sobelx = [1 0 -1; 2 0 -2; 1 0 -1];
% sobely = sobelx';

% img_x = conv2(image,sobelx,'same');
% img_y = conv2(image,sobely,'same');
[img_x,img_y] = imgradientxy(image);

img_x = conv2(img_x,con,'same');
img_y = conv2(img_y,con,'same');


Ixx = img_x.^2;
Iyy = img_y.^2;
Ixy = img_x.*img_y;
Iyx = img_y.*img_x;


sig_xx = conv2(Ixx,con,'same');
sig_xy = conv2(Ixy,con,'same');
sig_yx = conv2(Iyx,con,'same');
sig_yy = conv2(Iyy,con,'same');

% M = [sig_xx, sig_xy; sig_yx, sig_yy];
tr = k * ((sig_xx + sig_yy).^2);
d = ((sig_xx.*sig_yy) - (sig_yx.*sig_xy));

R = d - tr;


[~,sortIndex] = sort(R(:),'descend');  
                                                
maxIndex = sortIndex(1:alpha);

[points(:, 1), points(:, 2)] = ind2sub(size(I), maxIndex);

padh = padarray(R,[4,4]);

for i =1:alpha
    [maxv,maxind] = max(padh,[],'all', 'linear');
    if maxv == 0
        break
    end
    [x,y] = ind2sub(size(padh),maxind);
    
    points(i,1) = x-4;
    points(i,2) = y-4;
    sy = y - 1;
    ey = y + 1;
    sx = x - 1;
    ex = x + 1;
    padh(sx:ex,sy:ey) = 0;
end


end
