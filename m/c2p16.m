clear; close all; clc

% 16.1
x = [1, 2, 4];
h = ones(1,5);
conv(x,h)

% 16.2
x = [1, 2, -1];
h = x;
conv(x,h)

% 16.3
x = [0, 1, -2, 3, -4];
h = [1/2, 1/2, 1, 1/2];
conv(x,h)

% 16.8
x = [1, 1, 2];
h = ones(1, 25);
conv(x,h)

% 16.11
n = 0:15;
x = (1/2) .^ n;
h = (1/4) .^ n;
conv(x,h)