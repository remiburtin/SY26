function compression = huffman(path)
global prob avglen dict histogramme histo_0 corres index;

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

% Creation histogramme
for i=1:dim,
    histogramme(round(list(i))+1) = histogramme(round(list(i))+1) + 1;
end

% Suppression des zeros
[val, index] = find (histogramme ~= 0) ;
histo_0 = histogramme(index);

prob = zeros(1,length(histo_0)); % initialisation "prob" (histo normalise)

disp('Creation vecteur des probalites des niveaux de gris');
for i=1:length(histo_0),
    prob(i) = histo_0(i)/dim;
end

disp('Creation du vecteurs des differents symboles')
disp(['(nombre de symboles : ' num2str(length(histo_0)) ')']);
symbols = [1:length(histo_0)];

disp('Creation du dictionnaire (via huffmandict())');
[dict,avglen] = huffmandict(symbols,prob); 
disp(['Longueur moyenne des mots encodes : ' num2str(avglen)])

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

% encodage de l'image (passer un vecteur ligne)
disp('Encodage de l''image');
tic % calcul du temps d'encodage/decodage
enco = huffmanenco (list_0, dict);

% decodage (retourne un vecteur)
disp('Decodage de l''image');
deco = huffmandeco(enco, dict);
time = toc;
disp(['Duree encodage/decodage : ' num2str(time) 's.']);

% on remet les bonnes valeurs des pixels
deco_2 = zeros(1,dim);
for i=1:dim,
    deco_2(i) = index(deco(i));
end

% reshape vecteur -> image 2D
imagedeco = reshape(deco_2, size(img,1), size(img,2));

imshow(imagedeco/256);

compression = 1-length(enco)/(dim*8);
disp(['Taux de compression : 1 - taille finale / taille initiale = ' num2str(compression)]);

compression2 = 1-avglen/8;
disp(['Taux de compression : 1 - longueur moyenne mot code / 8 = ' num2str(compression2)]);

return;
end

