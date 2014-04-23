debit = 2;

img_name = 'lena';
img_ext = 'bmp';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);

img_name = 'airfield512x512';
img_ext = 'tif';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);

img_name = 'boats512x512';
img_ext = 'tif';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);

img_name = 'bridge512x512';
img_ext = 'tif';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);

img_name = 'harbour512x512';
img_ext = 'tif';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);

img_name = 'peppers512x512';
img_ext = 'tif';
[img, disto] = lloyd_max_2_1(strcat(img_name,'.',img_ext), debit);
imwrite(img/256 , strcat(img_name, '_quant_lloyd_', num2str(2^debit), '_niveaux.', img_ext), img_ext);