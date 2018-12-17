% He Feng & Cuihao Chen
% Generating a function to fit the GLM.
function [f,h,offset,stats] = fit_GLM(s,n)
T = length(s);
d = 15;

% Building the input matrix.
A = zeros(T,30);
for i = (d+1):T
    array_s = [s(i-1),s(i-2),s(i-3),s(i-4),s(i-5),s(i-6),s(i-7),s(i-8),...
        s(i-9),s(i-10),s(i-11),s(i-12),s(i-13),s(i-14),s(i-15)];
    array_n = [n(i-1),n(i-2),n(i-3),n(i-4),n(i-5),n(i-6),n(i-7),n(i-8),...
        n(i-9),n(i-10),n(i-11),n(i-12),n(i-13),n(i-14),n(i-15)];
    A(i,:) = [array_s array_n];    
end

% Building the output matrix.
B = zeros(T,1);
for j = 1:T
   B(j,:) = n(j); 
end

% Generate the coefficients and standard errors by using glmfit function.
[coe,~,stats] = glmfit(A,B,'poisson','link','log');
% Define the offset and the output filters.
offset = coe(1);
f = zeros(1,15);
h = zeros(1,15);
for k = 1:15
   f(k) = coe(k+1);
   h(k) = coe(k+16);
end


end











