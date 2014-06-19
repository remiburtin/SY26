W = 15;
N = 3;

avi = aviread('garden.avi');

i1 = avi(2).cdata;
i2 = avi(5).cdata;

[time, output_image, error, msd] = block_matching_encode(i1,i2,N,W)