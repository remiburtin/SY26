debit = 2;

img_name = 'lena';
img_ext = 'bmp';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);

img_name = 'airfield512x512';
img_ext = 'tif';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);

img_name = 'boats512x512';
img_ext = 'tif';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);

img_name = 'bridge512x512';
img_ext = 'tif';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);

img_name = 'harbour512x512';
img_ext = 'tif';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);

img_name = 'peppers512x512';
img_ext = 'tif';
strcat(img_name,'.',img_ext)
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
compression = huffman(img);