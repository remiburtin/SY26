H = hammgen(3);
m = [ 1 0 1 0 ];

c = hamcode([1 0 1 0], H)

cdecode = hamdecode( xor([0 1 0 0 0 0 0], c), H)