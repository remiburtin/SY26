function histogramme = img_hist(img)

histogramme = zeros(1,256);

composantes = size(img, 3)

if (composantes == 3)
    img = rgb2gray(img);
end

dim = size(img,1)*size(img,2);
list=reshape(double(img), 1, dim);

for i=1:dim,
    histogramme(round(list(i))) = histogramme(round(list(i))) + 1;
end

return;

end