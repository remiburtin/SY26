m = 4;

%Longueur du mot code (15)
n = 2^m-1;

%Longueur du message
k = 5;

%Message aleatoire
msg = gf(randi([0 1],1,k));

%Calcul polynome generateur
[gen, t] = bchgenpoly(n,k);

%Codage du message
code = bchenc(msg,n,k)

%Ajout de t erreurs aleatoires
code_bruite = code + randerr(1,n,t)

%Decodage
[msg_decode,nb_err] = bchdec(code_bruite,n,k)