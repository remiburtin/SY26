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
    histogramme(round(list(i))+1) = histogramme(round(list(i))+1) + 1;
end

% Suppression des zeros
[val, index] = find (histogramme ~= 0) ;
histo_0 = histogramme(index);

% Creation des tables de correspondance
% pour pouvoir retrouver plus tard les bonnes 
% valeurs des differents pixels
corres = zeros(1, 256);

for i=1:length(index),
    corres(index(i)) = i;
end

list_0 = zeros(1,dim);

for i=1:dim,
    list_0(i) = corres(list(i)+1);
end

disp('Encodage de l''image');
tic % calcul du temps d'encodage/decodage
code = arithenco(list_0, histo_0);

disp('Decodage de l''image');
deco = arithdeco(code, histo_0, dim);
time = toc;
disp(['Duree encodage/decodage : ' num2str(time) 's.']);

% conversion vers les bonnes valeurs de niveaux de gris
deco_2 = zeros(1,dim);

for i=1:dim,
    deco_2(i) = index(deco(i));
end

% vecteur -> matrice 2D
imagedeco = reshape(deco_2, size(img,1), size(img,2));
imshow(imagedeco/256);

compression = 1-length(code)/(dim*8);
disp(['Taux de compression : ' num2str(compression)]);

return;

end