% He Feng & Huihao Chen
% this is the pogram to find filters for the given data
clc;
close all;

t = 0:1:19;
% Given the stim filter and spike filter.
f = 20*exp(-t);
h = -200*exp(-t);

% import the given data
stim1 = importdata('binned_stim_cell_1.txt');
spike1 = importdata('binned_spikes_cell_1.txt');

stim2 = importdata('binned_stim_cell_2.txt');
spike2 = importdata('binned_spikes_cell_2.txt');

% plot and label the graphics for the first data
[f_fit1,h_fit1,offset1,stats1] = fit_GLM20(stim1,spike1);
% calculate the mean square standard error
stimMSE1 = mean(stats1.se(2:21));
spikeMSE1 = mean(stats1.se(26:41));
figure;
subplot(2,1,1);
plot(t,f_fit1);
hold on
errorbar(t,f_fit1,f_fit1-f,'.');
ylabel('stimulus filter');
title('data 1');
subplot(2,1,2);
plot(t,h_fit1);
hold on
errorbar(t,h_fit1,h_fit1-h,'.');
ylabel('spike filter');
xlabel('time');

% plot and label the graphics for the second data
figure;
[f_fit2,h_fit2,offset2,stats2] = fit_GLM20(stim2,spike2);
% calculate the mean square standard error
stimMSE2 = mean(stats2.se(2:21));
spikeMSE2 = mean(stats2.se(26:41));
t = 0:1:19;
subplot(2,1,1);
plot(t,f_fit2);
hold on
errorbar(t,f_fit2,f_fit2-f,'.');
ylabel('stimulus filter');
title('data 2');
subplot(2,1,2);
plot(t,h_fit2);
hold on
errorbar(t,h_fit2,h_fit2-h,'.');
ylabel('spike filter');
xlabel('time');


