% He Feng & Huihao Chen
% this program is to find a fitting distribution 
% for the inter-spike interval
clc;
close all;

% load the data 
ISIsimulated = importdata('ISIsimulated.txt');
[l,k] = size(ISIsimulated);
% find the inter-spike interval
isi = zeros(l,1);
for i = 1:1:(l-1)
    isi(i) = ISIsimulated(i+1) - ISIsimulated(i);
end
figure;
histogram(isi);

% plot a standard gamma distribution
x = 0:0.1:12;
gam_standard = 800*gampdf(3,2.5,x);
hold on;
plot(x,gam_standard);
title('Data Histogram and Poisson Distribution');

% chi-square test on the isi
pd = fitdist(isi,'Gamma');
h = chi2gof(isi,'CDF',pd);