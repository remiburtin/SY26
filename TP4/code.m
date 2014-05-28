function A= code(Vzig,diff,nb)

% Indexes des coefficients non nuls.
v_non_nul = find(Vzig ~= 0);

% Initialisation du vecteur contenant le bloc encode.
A = zeros(1,length(v_non_nul)*3-1+2);

% Initialisation des deux premieres valeurs deu bloc encode.
A(1) = nb;
A(2) = diff;

% Ecriture des triplets
for i=2:length(v_non_nul),
    A(3*(i-1)) = v_non_nul(i) - v_non_nul(i-1) - 1;
    A(3*(i-1)+1) = nb;
    A(3*(i-1)+2) = Vzig(v_non_nul(i));
end;

end