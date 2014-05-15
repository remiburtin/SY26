function D = MyDCT(B)
X = zeros(8,8);
Y = zeros(8,8);
C = [1/sqrt(2) 1 1 1 1 1 1 1];

for i=0:7,
    for j=0:7,
        X(i+1,j+1) = C(i+1)/2*cos(((2*(j)+1)*pi*(i))/16);
    end;
end;

Y = X;
D = X * B * Y';

%%%%%% DCT INVERSE %%%%%%
D2 = D * Y;
D3 = Y'*D2;

end