function A= code(Vzig,diff,nb)

v_non_nul = find(Vzig ~= 0);

A = zeros(1,length(v_non_nul)*3-1+2);

A(1) = nb;
A(2) = diff;

for i=2:length(v_non_nul),
    A(3*(i-1)) = v_non_nul(i) - v_non_nul(i-1) - 1;
    A(3*(i-1)+1) = 8;
    A(3*(i-1)+2) = Vzig(v_non_nul(i));
end;

end