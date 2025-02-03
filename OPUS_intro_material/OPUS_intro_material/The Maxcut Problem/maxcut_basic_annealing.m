% This code solves a basic maxcut problem via simulated annealing (SA)

clc;
clearvars; 
close all;

num_pbits = 5;
beta = 3;

J = zeros(num_pbits,num_pbits);

% list of non-zero elements of J matrix
J(1,2) = 1;
J(2,1) = 1;
J(2,3) = 1;
J(3,2) = 1;
J(3,5) = 1;
J(5,3) = 1;
J(4,5) = 1;
J(5,4) = 1;
J(2,4) = 1;
J(4,2) = 1;
J(1,4) = 1;
J(4,1) = 1;

J = -J;

h = zeros(num_pbits,1); % column vector

plot(graph(J))

%%%

m = sign(2*rand(num_pbits,1)-1); % initial state of the p-bits
num_samples = 100000;

beta = linspace(0.1,5,num_samples);   % how the temperature (beta) goes down (up)

% Initialize energy tracking
energy_over_time = zeros(1, num_samples);

figure;
plot(1:1:num_samples,beta);
xlabel('Samples/Time');
ylabel('beta = 1/T');
title('Annealing Schedule (linear)');

for ii = 1:1:num_samples
    for jj = 1:1:num_pbits
        I_jj = beta(ii)*(J(jj,:)*m+h(jj));   % notice that every time beta is changing
        m(jj) = sign(tanh(I_jj)-2*rand+1);
    end
    % Calculate and store the energy at this step
    energy_over_time(ii) = -0.5*m'*J*m - h'*m;
end

Look = 2.^(num_pbits-1:-1:0);

fprintf('Actual correct answers are 6, 9 22 and 25.\n')
fprintf('After annealing we found the state %d\n',Look*(m+1)/2);

figure;
% checking
for ii = 1:1:2^num_pbits
    m = (2*de2bi(ii-1,num_pbits,'left-msb')-1)';
    E(ii) = -0.5*m'*J*m-h'*m;
end

plot(0:1:2^num_pbits-1,E);
xlabel('States');
ylabel('Energy');
title('Actual Energy Landscape')

% Plot Energy vs. Sweep (additional plot)
figure;
plot(1:num_samples, energy_over_time, 'r');
xlabel('Monte Carlo Sweeps');
ylabel('Ising Energy');
title('Ising Energy vs. Sweep');
