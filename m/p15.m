clear; close all; clc;
n = 0:99;
Fs = 5; %kHz
colF0 = [0.5, 2, 3, 4.5]; %kHz


for F0 = colF0
    figure
    x = sin(2*pi*F0/Fs *n);
    stem(n, x)
    title(sprintf("x(n) - F0 = %0.1f", F0))
    xlabel("Muestras (n)")
    ylabel("x(n)")
end

F0 = 2 %kHz
Fs = 50 %kHz
x = sin(2*pi*F0/Fs *n);
figure
stem(n, x)
title(sprintf("x(n) - f0 = %0.2f", F0/Fs))
xlabel("Muestras (n)")
ylabel("x(n)")

figure
y = x(1:2:end);
nf = 1:2:length(x);
stem(nf, y)
title(sprintf("y(n)"))
xlabel("Muestras (n)")
ylabel("y(n)")