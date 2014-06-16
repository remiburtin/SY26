function [ c ] = hamcode( m, H )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

M = size(H, 1);
n = size(H, 2);

% H = [H(1:3,4:7) H(1:3,1:3)];

G = [H(1:M,(n-M):n)' eye(n-M)];

c = m*G;

c = mod(c,2)

end

