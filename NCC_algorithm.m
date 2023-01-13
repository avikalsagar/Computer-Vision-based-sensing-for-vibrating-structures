frame_1 = imread('video30.jpg');
frame_2 = imread('video35.jpg');
frame_1gray = rgb2gray(frame_1);
frame_2gray = rgb2gray(frame_2);
T = imcrop(frame_1gray);

c1 = normxcorr2(T, frame_1gray);
c2 = normxcorr2(T, frame_2gray);

figure(1), surf(c1), shading flat
figure(2), surf(c2), shading flat

[ypeak1, xpeak1] = find(c1==max(c1(:)));
[ypeak2, xpeak2] = find(c2==max(c2(:)));