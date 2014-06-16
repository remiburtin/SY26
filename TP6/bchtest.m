m = 5;

%Longueur du mot code
n = 2^m-1;

%Longueur du message
k = 16;

%Message aleatoire
msg = gf(randi([0 1],1,k));

%Calcul polynome generateur
[gen, t] = bchgenpoly(n,k);

%Codage du message
code = bchenc(msg,n,k);

%Ajout de t erreurs aleatoires
code_bruite = code + randerr(1,n,t);

%Decodage
[msg_decode,nb_err] = bchdec(code_bruite,n,k);