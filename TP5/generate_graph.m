Ws = [5,10,15];
Ns = [1,2,3];

i1 = imread('car1.png');
i2 = imread('car2.png');

res = zeros(length(Ns),length(Ws));

for i=1:length(Ns),
    for j=1:length(Ws),
        [time, output_image, error, res(i,j)] = block_matching_encode(i1,i2,Ns(i),Ws(j));
    end;
end;

plot(2*Ns+1,res)
set(gca,'XTick',2*Ns+1)
xlabel('M')
ylabel('MSD')
title('Evolution du MSD en fonction de la taille des blocs et de la fenetre de recherche')
legend('w = 5','w = 10', 'w = 15')