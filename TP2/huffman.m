function compression = huffman(path)

% matrice de l'image
img = imread(path);

% initialisation vecteurs
histogramme = zeros(1,256); % occurences par niveaux de gris
prob = zeros(1,256); % probas (histo normalisé)

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

% création probas des niveaux de gris
for i=1:256,
    prob(i) = histogramme(i)/dim;
end

% création vecteur de taille 256 [1, 2, 3, ... 256]
% correspond aux niveaux de gris
symbols = [1:256];

% création du dictionnaire
[dict,avglen] = huffmandict(symbols,prob); 

% encodage de l'image (passer un vecteur ligne)
enco = huffmanenco (list, dict);

% décodage (retourne un vecteur)
% deco = huffmandeco(enco, dict);

% reshape vecteur -> image 2D
% imagedeco = reshape(deco, size(img,1), size(img,2));

% imshow(imagedeco/256);

% subplot(2,1,1);
% 
% plot(histogramme);
% 
% subplot(2,1,2);
% 
% plot(prob);

compression = 1-length(enco)/(dim*8);

compression2 = 1-avglen/8;

compression

compression2

return;

end

