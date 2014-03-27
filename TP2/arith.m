function code = arith(path)

% matrice de l'image
img = imread(path);

% initialisation vecteurs
histogramme = zeros(1,256); % occurences par niveaux de gris


composantes = size(img, 3); % Taille de la 3eme dimension 

if (composantes == 3) % conversion en gris si image couleur
    img = rgb2gray(img);
end

dim = size(img,1)*size(img,2); % nombre de pixels dans l'image
list=reshape(double(img), 1, dim); % images en ligne (vecteur)

% création histogramme
for i=1:dim,
    histogramme(round(list(i))) = histogramme(round(list(i))) + 1;
end

histogramme

[val, index] = find (histogramme ~= 0) ;
histo_0 = histogramme(index);
%alphabet = linspace(1, length(histo_0), length(histo_0));

corres = zeros(1, 256);

for i=1:length(index),
    corres(index(i)) = i;
end

list_0 = zeros(1,dim);

for i=1:dim,
    list_0(i) = corres(list(i));
end

code = arithenco(list_0, histo_0);

deco = arithdeco(code, histo_0, dim);

deco_2 = zeros(1,dim);

for i=1:dim,
    deco_2(i) = index(deco(i));
end

imagedeco = reshape(deco_2, size(img,1), size(img,2));

imshow(imagedeco/256);

return;

end