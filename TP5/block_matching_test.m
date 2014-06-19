W = 15;
N = 3;

i1 = imread('garden1.jpg');
i2 = imread('garden2.jpg');

%i1 = imread('man1.jpg');
%i2 = imread('man2.jpg');

%i1 = imread('car1.jpg');
%i2 = imread('car2.jpg');

%i1 = imread('girl1.jpg');
%i2 = imread('girl2.jpg');

[time, output_image, error, msd] = block_matching_encode(i1,i2,N,W)