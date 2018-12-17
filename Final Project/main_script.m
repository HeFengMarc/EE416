% He Feng & Huihao Chen
clc;
close all;

% Define the variables.
m=0.3;
v=0.1;
s=m+v*randn(1,18000);
t = 0:1:14;
% Given the stim filter and spike filter.
f = 20*exp(-t);
h = -200*exp(-t);
b = -15;

% Generate the discretized stimulus.
stim = zeros(1, 2000);
stim = [stim s];

% Plot the stimulus filter.
figure
subplot(4,1,1);
plot(t,f);
hold on;
xlim([-1,15]);
ylim([-5,25]);
ylabel('stimulus filter');

% Plot the spike filter.
subplot(4,1,2);
plot(t,h);
xlim([-1,15]);
ylim([-3,3]);
ylabel('spike filter');
hold on;

% Plot the stimulus response.
subplot(4,1,3);
plot(stim);
xlim([-1000,22000]);
ylim([-0.2 0.7]);
ylabel('stimulus');

% Plot the spike response.
subplot(4,1,4);
spike = sim_GLM(f,h,b,stim);
plot(spike);
xlim([-1000,22000]);
ylim([-0.1 1.1]);
ylabel('spike response');

% Generate a new stim filter and spike filter by using the fitting function
% Plot the new stimulus filter on the same plot of the original stimulus
% filter.
[f_fit, h_fit, offset, stats] = fit_GLM(stim, spike);
subplot(4,1,1);

plot(t,f_fit);
hold on
errorbar(t,f_fit,f_fit-f,'.');



% Plot the new spike filter on the same plot of the original spike filter.
subplot(4,1,2);
plot(t,h_fit);
hold on
errorbar(t,h_fit,h_fit-h,'.');


