t = 0:0.001:1;
A = 1;
tau = 250e-3; % [s] 
f = 1 / (2 * tau);
s = abs(A * sin(2*pi*f*t));
figure
plot(t, s)


k = -3:1:3;
ck = 2 * A ./ (pi * (1 - 4 * k.^2));
pds = abs(ck) .^2; 
figure
stem(k,pds)



c = [2/3, 0, 1/6, 0, 2/3, 3/2, 2/3, 0, 1/6, 0, 2/3];
figure
k = -5:5;
stem(k, c)

k = -7:7;
c = [1, 1/2, 1/4, 0, 1/4, 1/2, 1, 2, 1, 1/2, 1/4, 0, 1/4, 1/2, 1];
c = c.^2
stem(k, c)
