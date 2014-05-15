function B = MyIDCT(D)
X = zeros(8,8);
C = [1/sqrt(2) 1 1 1 1 1 1 1];

for i=0:7,
    for j=0:7,
        X(i+1,j+1) = C(i+1)/2*cos(((2*(j)+1)*pi*(i))/16);
    end;
end;

B = single(X' * (D * X));

end