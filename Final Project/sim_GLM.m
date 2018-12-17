% He Feng & Huihao Chen
% Building a function which simulate the GLM. It will output the spike
% response.
function n = sim_GLM(f,h,b,s)

% Define the variables
T = length(s);
d = 15;
n = zeros(1,T);

for i = (d+1):T
    % Use a for loop to generate the power which introduced in the specd, and
    % it will be useful in the following procedure
    power = 0;
    for j = 1:d 
       power = power + s(i-j)*f(j) + n(i-j)*h(j);    
    end
    power = power+b;
    
    % Define each element in the spike response one by one.
    n(i) = poissrnd(exp(power));
    n(i) = min(n(i),1);
end



end