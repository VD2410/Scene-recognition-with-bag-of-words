 I = imread('../data/desert/sun_adpbjcrpyetqykvt.jpg');
 J = createFilterBank() ;
 disp(size(J))
 K = tryBetterFeatures(I);
 i = size(J,1);
 figure;
 imshow(K(:,:,1),[]);
 figure;
 imshow(K(:,:,2),[]);
 figure;
 imshow(K(:,:,3),[]);
 figure;
 imshow(K(:,:,4),[]);