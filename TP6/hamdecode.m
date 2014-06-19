function decode = hamdecode(r,H)

% Calcul du syndrome
s = mod(r*H', 2);
% Conversion de s (syndrome),
i = bi2de(s,2,'left-msb');

if i~= 0
    % Calcul du vecteur d'erreur
    i = i+1;
    table = syndtable(H)

    e = table(i,:);

    % Mot decode suppose emis
    decode = xor(r,e);
else
    decode = r;
end;

end