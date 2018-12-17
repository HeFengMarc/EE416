% He Feng & Huihao Chen
% this function is based on the former fit_GLM
function [f,h,offset,stats] = fit_GLM20(s,n)
    T = length(s);
    d = 20;
    A = zeros(T,40);
    % build the matrix A
    for i = (d+1):T
        array_s = [s(i-1),s(i-2),s(i-3),s(i-4),s(i-5),s(i-6),s(i-7),s(i-8),...
                   s(i-9),s(i-10),s(i-11),s(i-12),s(i-13),s(i-14),s(i-15),...
                   s(i-16),s(i-17),s(i-18),s(i-19),s(i-20)];
        array_n = [n(i-1),n(i-2),n(i-3),n(i-4),n(i-5),n(i-6),n(i-7),n(i-8),...
                   n(i-9),n(i-10),n(i-11),n(i-12),n(i-13),n(i-14),n(i-15),...
                   n(i-16),n(i-17),n(i-18),n(i-19),n(i-20)];
        A(i,:) = [array_s array_n];    
    end
    % interpose n to get B
    B = n';
    %B = squeeze(B);
    %input = [1:1:T; [array_s array_n];
    %output = n;
    [coe,~,stats] = glmfit(A,B,'poisson','link','log');

    offset = coe(1);
    f = zeros(1,20);
    h = zeros(1,20);
    % assign the values in coe to f_fit and h_fit
    for k = 1:20
        f(k) = coe(k+1);
        h(k) = coe(k+21);
    end
    
end