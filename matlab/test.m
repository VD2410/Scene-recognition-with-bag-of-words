% random ponits
a = imread('../data/landscape/sun_adbtakwewxdagnxp.jpg');
b = getRandomPoints(a, 500);
x = b(:,1);
y = b(:,2);
sz = 10;
figure
imshow(a);
title('Random')
hold on;
scatter(y,x,sz,'b');


% harris ponits

c = imread('../data/landscape/sun_adbtakwewxdagnxp.jpg');
d = getHarrisPoints(c, 500, 0.06);
x = d(:,1);
y = d(:,2);
sz = 10;
figure
imshow(c);
title('Harris')
hold on;
scatter(y,x,sz,'r');

visual = load('../data/landscape/sun_adbtakwewxdagnxp.mat');
RGB = label2rgb(cell2mat(struct2cell(visual)));
figure;
title('Harris')
imshow(RGB)

visual = load('../data/landscape/sun_adbtakwewxdagnxp_r.mat');
RGB = label2rgb(cell2mat(struct2cell(visual)));
figure;
title('Random')
imshow(RGB)


