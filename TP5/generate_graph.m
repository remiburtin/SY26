Ws = [5,10,15];
Ns = [1,2,3];

i1 = imread('car1.png');
i2 = imread('car2.png');

msd = zeros(length(Ns),length(Ws));
time = zeros(length(Ns),length(Ws));
for i=1:length(Ns),
    for j=1:length(Ws),
        [time(i,j), output_image, error, msd(i,j)] = block_matching_encode(i1,i2,Ns(i),Ws(j));
    end;
end;

subplot(1,2,1)
plot(2*Ns+1,msd)
set(gca,'XTick',2*Ns+1)
xlabel('M')
ylabel('MSD')
title('Evolution du MSD en fonction de la taille des blocs et de la fenetre de recherche')
legend('w = 5','w = 10', 'w = 15')
subplot(1,2,2)
plot(2*Ns+1,time)
set(gca,'XTick',2*Ns+1)
xlabel('M')
ylabel('Temps')
title('Evolution du temps de traitement en fonction de la taille des blocs et de la fenetre de recherche')
legend('w = 5','w = 10', 'w = 15')