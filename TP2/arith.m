function compression = arith(path)

% matrice de l'image
disp(['Lecture de l''image ' path]);
img = imread(path);

% initialisation vecteurs
histogramme = zeros(1,256); % occurences par niveaux de gris


composantes = size(img, 3); % Taille de la 3eme dimension 

if (composantes == 3) % conversion en gris si image couleur
    disp('Image couleur : conversion en gris');
    img = rgb2gray(img);
end

dim = size(img,1)*size(img,2); % nombre de pixels dans l'image
list=reshape(double(img), 1, dim); % images en ligne (vecteur)

% creation histogramme
for i=1:dim,
    histogramme(round(list(i))) = histogramme(round(list(i))) + 1;
end

[val, index] = find (histogramme ~= 0) ;
histo_0 = histogramme(index);

corres = zeros(1, 256);

for i=1:length(index),
    corres(index(i)) = i;
end

list_0 = zeros(1,dim);

for i=1:dim,
    list_0(i) = corres(list(i));
end

disp('Encodage de l''image');
tic % calcul du temps d'encodage/decodage
code = arithenco(list_0, histo_0);

disp('Decodage de l''image');
deco = arithdeco(code, histo_0, dim);
time = toc;
disp(['Duree encodage/decodage : ' num2str(time) 's.']);

deco_2 = zeros(1,dim);

for i=1:dim,
    deco_2(i) = index(deco(i));
end

imagedeco = reshape(deco_2, size(img,1), size(img,2));

imshow(imagedeco/256);

compression = 1-length(code)/(dim*8);
disp(['Taux de compression : 1 - taille finale / taille initiale = ' num2str(compression)]);


return;

end