path = "C:\Users\avika\OneDrive\Desktop\Fall 2022\Prin & App of Sensors\Project\Test1_WhiteNoise1 (1).avi";
obj = VideoReader(path);   %Reads video data from file
N = obj.NumFrames;  %Total number of frames from video frame
h = obj.Height;  %Height of video frame in pixels
w = obj.Width;   % Width of video frame in pixels
Fs = obj.FrameRate;   %Frame rate of video in pixels
dt = 1/Fs;

t = 0:dt:(N-1)*dt;  %Generates time instants
frame1 = im2double(rgb2gray(read(obj, 1)));
T = imcrop(frame1);
[mt, nt] = size(T);
imshow(frame1);
 [x, y] = ginput(2);
l_known = max(abs(x(2)-x(1)), abs(y(2) - y(1)));
D_known = input('Input the known physical distance (Units: mm)');
SF = D_known/l_known;
px = round(h/20);
py = round(w/20);
ROI_frame1 = frame1(round(y(1) - px): round(y(2) + px), round(x(1) - py): round(x(2) + py), :);
[mr, nr] = size(ROI_frame1);
T(mt + 1: mr,:) = 0;
T(:, nt+1:nr) = 0;

buf2ft = fft2(T);
usfac = 50;

V = zeros(N, 2);
Disp_P = zeros(N, 2);
Disp_S = zeros(N, 2);
for i = 1:N
    framei = im2double(rgb2gray(read(obj, i)));
    ROI_framei = framei(round(y(1) - px): round(y(2) + px), round(x(1) - py): round(x(2) + py));

    buf1ft = fft2(ROI_framei);
    [output, Greg] = dftregistration(buf1ft, buf2ft, usfac);
    V(i,:) = [output(3), output(4)];
    Disp_P(i, :) = V(i, :) - V(1, :);
    Disp_S(i, :) = Disp_P(i, :)*SF;
end

save Displacement.mat Disp_S