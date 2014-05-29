function imgEnco= codJPG(img, quality)

zig=[1 9 2 3 10 17 25 18 ...
     11 4 5 12 19 26 33 41 ...
     34 27 20 13 6 7 14 21 ...
     28 35 42 49 57 50 43 36 ...
     29 22 15 8 16 23 40 37 ...
     44 51 58 59 52 45 38 41 ...
     24 32 38 46 53 60 61 54 ...
     47 40 48 55 62 63 56 64];

if (strcmp(class(img),'char'))
    disp(['Lecture de l''image ' img]);
    img = imread(img);
end

if (size(img, 3) == 3) % conversion en gris si image couleur
    disp('Image couleur : conversion en gris');
    img = rgb2gray(img);
end

blocks = mat2cell(img,8*ones(1,size(img,1)/8),8*ones(1,size(img,2)/8));
oldFirst = 0;

imgEnco = [];

for i=1:size(blocks,1)*size(blocks,2),
    blockDCT = MyDCT(double(cell2mat(blocks(i))));
    QM=QuantM(quality);
    Dq= round(blockDCT./QM);
    Vzig=Dq(zig);
    
    A= code(Vzig,Vzig(1) - oldFirst,8);
    oldFirst = Vzig(1);
    imgEnco = [imgEnco A];
end;

%Calcul du taux de compression
size_img = size(img,1)*size(img,2)*8;
size_enco = length(imgEnco)*8;
compression = (1 - (size_enco / size_img))*100

%Decodage de l'image pour pouvoir calculer le SNR
imgDeco = decJPG(imgEnco, quality);

%Mise de l'image originale et quantifie sous forme de liste
list=reshape(double(img), 1, size_img/8);
list_quant=reshape(double(imgDeco), 1, size_img/8);

%Calcul distortion
distortion = mean((list-list_quant).^2)
%Calcul NMSE
nmse = distortion/var(list)
%Calcul du rapport signal sur bruit
snr = -10*log10(nmse)

end