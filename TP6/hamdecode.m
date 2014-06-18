function decode = hamdecode(r,H)
% Calcul du syndrome

s = mod(r*H', 2);
i = bi2de(s,2,'left-msb');

% Calcul du vecteur d'erreur
i = i+1;
table = syndtable(H);

e = table(i,:);

% Mot decode suppose emis

decode = xor(r,e);

end