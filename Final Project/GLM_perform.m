% He Feng & Huihao Chen
% Section 4.3 of the final project
clc;
close all;

m=0.3;
v=0.1;

% Define the ideal filters and other variables.
t = 0:1:14;
f = 20*exp(-t);
h = -200*exp(-t);
b = -15;
d = 15;

% List the time samples.
num_sample = [1000,3000,10000,30000];

figure(1)
%% Display each errors as the function of stimulus length. 
% Generate four groups of samples with diverse sample length.
for i = 1:4
    number = num_sample(i);
    offset_error = zeros(1,6);
    new_offset = zeros(1,6);
    mean_standard_stim = zeros(1,6);
    % Generate each length for six trails.
    for j = 1:6 
        
        %% Plot the offset errors as the function of numbers of samples.
        subplot(3,3,1);
        s=m+v*randn(1,number*0.9);
        stim = [zeros(1,number*0.1) s];
        spike = sim_GLM(f,h,b,stim);
        % count the spikes number
        s_counts = size(find(spike == 1));
        [f_fit, h_fit, offset, stats] = fit_GLM(stim, spike);
        % find the absolute value of the difference between the ideal
        % offset and new generated offset.
        new_offset(j) = abs(b-offset);
        semilogx(number,new_offset(j),'b.','MarkerSize',10);
        hold on
        xlabel('Number of Samples');
        ylabel('offset error');
        
        %% Plot the offset errors as the function of spike counts.
        subplot(3,3,4);
        semilogx(s_counts(2),new_offset(j),'b.','MarkerSize',10); 
        hold on
        xlabel('Spike Counts');
        ylabel('offset error');
        
        %% Plot the RMSE as the function of stimulus length.
        subplot(3,3,2);
        total_stim = 0;
        sum_stim = 0;
        sum_spike = 0;
        % Generate the RMSE for stimulus filter.
        for k1 = 1:size(f_fit)
            sum_stim = sum_stim + (f(k1)-f_fit(k1))^2;      
        end
        output_stim = sqrt((1/d)*sum_stim);
        loglog(number,output_stim,'b.','MarkerSize',10);  
        hold on
       
        % Generate the RMSE for the spike filter.
        for k2 = 1:size(h_fit)
            sum_spike = sum_spike + (h(k2)-h_fit(k2))^2;      
        end
        output_spike = sqrt((1/d)*sum_spike);
        loglog(number,output_spike,'r.','MarkerSize',10);  
        hold on
        xlabel('Number of Samples');
        ylabel('RMSE');
        
        %% Plot the RMSE as the function of spike counts.
        subplot(3,3,5);
        loglog(s_counts(2),output_stim,'b.','MarkerSize',10);
        hold on
        loglog(s_counts(2),output_spike,'r.','MarkerSize',10);
        hold on
        xlabel('Spike Counts');
        ylabel('RMSE');
        
        %% Plot the mean standard error as the function of stimulus length.
        subplot(3,3,3);
        sum_sderr_stim = 0;
        sum_sderr_spike = 0;
        std_error = stats.se;
        % Generate the mean standard error for the stimulus filter.
        for g1 = 2:16
            sum_sderr_stim = sum_sderr_stim + std_error(g1);
        end
        output_stim = sum_sderr_stim/d;
        loglog(number,output_stim,'b.','MarkerSize',10);
        hold on
       
        % Generate the mean standard error for the spike filter.
        for g2 = 22:31
            sum_sderr_spike = sum_sderr_spike + std_error(g2);
        end
        output_spike = sum_sderr_spike/(d-5);
        loglog(number,output_spike,'r.','MarkerSize',10);
        hold on
        xlabel('Number of Samples');
        ylabel('Mean Standard Error'); 
        
        %% Plot the mean standard error as the function of spike counts.
        subplot(3,3,6);
        loglog(s_counts(2),output_stim,'b.','MarkerSize',10);
        hold on
        loglog(s_counts(2),output_spike,'r.','MarkerSize',10);
        hold on
        xlabel('Spike Counts');
        ylabel('Mean Standard Error'); 
        
        
        
        
    end     
end

%% Generating the function by changing offset.
b = [-14, -16, -18];
length = 10000;
for i = 1:3
    new_offset = zeros(1,6);
    
    for j = 1:6
        s=m+v*randn(1,length*0.9);
        stim = [zeros(1,length*0.1) s];
        spike = sim_GLM(f,h,b(i),stim);
        [f_fit, h_fit, offset, stats] = fit_GLM(stim, spike);
        s_counts = size(find(spike == 1));
        
        % Generate the offset errors as the function of spike number.
        new_offset(j) = abs(b(i)-offset);
        
        %% Generate the offset errors as the function of spike counts.
        subplot(3,3,7)
        semilogx(s_counts(2),new_offset(j),'b.','MarkerSize',10)
        hold on
        xlabel('spike counts');
        ylabel('offset errors');
        
        %% Generate the RMSE as the function of spike counts.
        subplot(3,3,8)
        total_stim = 0;
        sum_stim = 0;
        sum_spike = 0;
        % Generate the RMSE for stimulus filter.
        for k1 = 1:size(f_fit)
            sum_stim = sum_stim + (f(k1)-f_fit(k1))^2;      
        end
        output_stim = sqrt((1/d)*sum_stim);
        loglog(s_counts(2),output_stim,'b.','MarkerSize',10);  
        hold on
        % Generate the RMSE for the spike filter.
        for k2 = 1:size(h_fit)
            sum_spike = sum_spike + (h(k2)-h_fit(k2))^2;      
        end
        output_spike = sqrt((1/d)*sum_spike);
        loglog(s_counts(2),output_spike,'r.','MarkerSize',10);  
        hold on
        xlabel('spike counts');
        ylabel('RMSE');
        
        %% Generate the mean standard error as the function of spike counts.
        subplot(3,3,9);
        sum_sderr_stim = 0;
        sum_sderr_spike = 0;
        std_error = stats.se;
        for g1 = 2:16
            sum_sderr_stim = sum_sderr_stim + std_error(g1);
        end
        output_stim = sum_sderr_stim/d;
        loglog(s_counts(2),output_stim,'b.','MarkerSize',10);
        hold on
        
        for g2 = 22:31
            sum_sderr_spike = sum_sderr_spike + std_error(g2);
        end
        output_spike = sum_sderr_spike/(d-5);
        loglog(s_counts(2),output_spike,'r.','MarkerSize',10);
        hold on
        xlabel('spike counts');
        ylabel('Mean Standard Error');
    
    end
end



