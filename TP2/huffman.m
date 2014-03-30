function compression = huffman(path)
global prob avglen dict;

% matrice de l'image
disp(['Lecture de l''image ' path]);
img = imread(path);

% initialisation vecteurs
histogramme = zeros(1,256); % occurences par niveaux de gris
prob = zeros(1,256); % probas (histo normalise)

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

% creation probas des niveaux de gris
disp('Creation vecteur des probalites des niveaux de gris');
for i=1:256,
    prob(i) = histogramme(i)/dim;
end

% creation vecteur de taille 256 [1, 2, 3, ... 256]
% correspond aux niveaux de gris
disp('Creation du vecteurs des differents symboles');
symbols = [1:256];

% creation du dictionnaire
disp('Creation du dictionnaire (via huffmandict())');
[dict,avglen] = huffmandict(symbols,prob); 
disp(['Longueur moyenne des mots encodes : ' num2str(avglen)])

% encodage de l'image (passer un vecteur ligne)
disp('Encodage de l''image');
tic % calcul du temps d'encodage/decodage
enco = huffmanenco (list, dict);

% decodage (retourne un vecteur)
disp('Decodage de l''image');
deco = huffmandeco(enco, dict);
time = toc;
disp(['Duree encodage/decodage : ' num2str(time) 's.']);

% reshape vecteur -> image 2D
imagedeco = reshape(deco, size(img,1), size(img,2));

imshow(imagedeco/256);

compression = 1-length(enco)/(dim*8);
disp(['Taux de compression : 1 - taille finale / taille initiale = ' num2str(compression)]);

compression2 = 1-avglen/8;
disp(['Taux de compression : 1 - longueur moyenne mot code / 8 = ' num2str(compression2)]);

return;
end

