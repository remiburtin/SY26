function imgDeco= decJPG(code)

parcoursZig=[1 9 2 3 10 17 25 18 ...
             11 4 5 12 19 26 33 41 ...
             34 27 20 13 6 7 14 21 ...
             28 35 42 49 57 50 43 36 ...
             29 22 15 8 16 23 40 37 ...
             44 51 58 59 52 45 38 41 ...
             24 32 38 46 53 60 61 54 ...
             47 40 48 55 62 63 56 64];
 
matQuant = [16 11 10 16 24  40  51  61;
          12 12 14 19 26  58  60  55;
          14 13 16 24 40  57  69  56;
          14 17 22 29 51  87  80  62;
          18 22 37 56 68  109 103 77;
          24 35 55 64 81  104 113 92;
          49 64 78 87 103 121 120 101;
          72 92 95 98 112 100 103 99];

iCode = 1;
iZig = 1;
oldFirst = 0;

zig = zeros(1,64);

while iCode ~= length(code) + 1,

    %Prise en compte du premier element du bloc
    zig(iZig) = code(iCode+1) + oldFirst;
    oldFirst = zig(iZig);

    iZig = iZig + 1;
    iCode = iCode + 2;
    while true
        if code(iCode) == 0 && code(iCode + 1) == 0 %Si on est à la fin d'un bloc
            iCode = iCode + 2;
            iZig = 1;
            break;
        else % C'est un triplet normal
            for i=1:code(iCode), %On met le bon nombre de 0
                zig(iZig) = 0;
                iZig = iZig + 1;
            end
            zig(iZig) = code(iCode + 2); %on ajoute le coefficient
            iZig = iZig + 1;
            iCode = iCode + 3; %on passe au triplet suivant
        end
    end
    
    block = zeros(8,8);
    
    %zig zag inverse
    block(parcoursZig) = zig;
    
    %quantification inverse
    block = block.*matQuant;
    
    %calcul DCT inverse
    block = round(MyIDCT(block))
    
    %Remettre le bloc dans une matrice
    %%%
    %%%
    
    
    zig = zeros(1,64);
end;



end