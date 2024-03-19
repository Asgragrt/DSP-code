clear; close all; clc;
N = 500;
n = 0:N;
f0 = 1/50;
x = sin(2*pi*f0*n);

quantificationLevels = [64, 128, 256];
quantLevel = 64;
%{
xq1_1 = quantizer(x, quantLevel, 1, 'truncation');
xq1_2 = quantizer2(x, quantLevel, 1, 'truncation');
xq1_3 = quantizer3(x, quantLevel, 1, 'truncation');


plot(n, x)
plot(n, xq1_1)
plot(n, xq1_2)
plot(n, xq1_3)
plot(n, xq1_1-xq1_2)
plot(n, xq1_1-xq1_3)

meaner1 = mean(abs(x-xq1_1).^2)
meaner2 = mean(abs(x-xq1_2).^2)
meaner3 = mean(abs(x-xq1_3).^2)
%}
%{
xq1_1 = quantizer(x, quantLevel, 1, 'rounding');
xq1_2 = quantizer2(x, quantLevel, 1, 'rounding');
xq1_3 = quantizer3(x, quantLevel, 1, 'rounding');


plot(n, x)
plot(n, xq1_1)
plot(n, xq1_2)
plot(n, xq1_3)
plot(n, xq1_1-xq1_2)
plot(n, xq1_1-xq1_3)

meaner1 = mean(abs(x-xq1_1).^2)
meaner2 = mean(abs(x-xq1_2).^2)
meaner3 = mean(abs(x-xq1_3).^2)
%}

testAmount = 10000;
testAmount2 = 100;
mean1 = 0;
t1 = tic;
for j = 1:testAmount2
    tic
    for i = 1:testAmount
        xq2_2 = quantizer2(x, quantLevel, 1, 'truncation');
    end
    mean1 = mean1 + toc;
end
toc(t1)

mean1 = mean1 / testAmount2

mean2 = 0;
t2 = tic;
for j = 1:testAmount2
    tic
    for i = 1:testAmount
        xq2_3 = quantizer3(x, quantLevel, 1, 'truncation');
    end
    mean2 = mean2 + toc;
end
toc(t2)

mean2 = mean2 / testAmount2


mean3 = 0;

t1 = tic;
for j = 1:testAmount2
    tic
    for i = 1:testAmount
        xq2_2 = quantizer2(x, quantLevel, 1, 'rounding');
    end
    mean3 = mean3 + toc;
end
toc(t1)

mean3 = mean3 / testAmount2

mean4 = 0;
t2 = tic;
for j = 1:testAmount2
    tic
    for i = 1:testAmount
        xq2_3 = quantizer3(x, quantLevel, 1, 'rounding');
    end
    mean4 = mean4 + toc;
end
toc(t2)

mean4 = mean4 / testAmount2


function quantizedSignal = quantizer(signal, levelsCount, expectedMax, type)
    levels = linspace(-expectedMax, expectedMax, levelsCount);
    quantizedSignal = zeros(1,length(signal));
    
    if strcmp(type, 'truncation')
        
        for i=1:length(signal)
            lesserValues = levels(levels <= signal(i));
            quantizedSignal(i) = lesserValues(end);
        end
        
    elseif strcmp(type, 'rounding')
        for i=1:length(signal)
            lesserValues = levels(levels <= signal(i));
            greaterValues = levels(levels >= signal(i));
            distanceBelow = signal(i) - lesserValues(end);
            distanceAbove = greaterValues(1) - signal(i);
            
            if distanceBelow < distanceAbove
                quantizedSignal(i) = lesserValues(end);
            else
                quantizedSignal(i) = greaterValues(1);
            end
            
        end
        
    else
        error("Not a proper type of quantization")
    end
end

function quantizedSignal = quantizer2(signal, levelsCount, expectedMax, type)
    expectedMin = -expectedMax;
    levels = linspace(expectedMin, expectedMax, levelsCount);
    quantizedSignal = zeros(1,length(signal));
    
    step = levels(2) - levels(1);
    
    if strcmp(type, 'truncation')
        
        for i=1:length(signal)
            index = floor((signal(i) - expectedMin)/ step) + 1;
            quantizedSignal(i) = levels(index);
        end
        
    elseif strcmp(type, 'rounding')
        for i=1:length(signal)
            index = round((signal(i) - expectedMin)/ step) + 1;
            quantizedSignal(i) = levels(index);
            
        end
        
    else
        error("Not a proper type of quantization")
    end
end

function quantizedSignal = quantizer3(signal, levelsCount, expectedMax, type)
    expectedMin = -expectedMax;
    levels = linspace(expectedMin, expectedMax, levelsCount);
    quantizedSignal = zeros(1,length(signal));
    
    step = levels(2) - levels(1);
    
    if strcmp(type, 'truncation')
        
        indexes = floor((signal - expectedMin)/ step) + 1;
        quantizedSignal = levels(indexes);
        
    elseif strcmp(type, 'rounding')
        indexes = round((signal - expectedMin)/ step) + 1;
        quantizedSignal = levels(indexes);
        
    else
        error("Not a proper type of quantization")
    end
end