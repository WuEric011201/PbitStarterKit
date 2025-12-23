% This code solves a simple max cut problem by sampling a system running at
% constant temperature and recording the lowest energy configuration

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

%%%

m = sign(2*rand(num_pbits,1)-1); % initial state of the p-bits

min_energy = 100;

num_samples = 10000;

for ii = 1:1:num_samples
    for jj = 1:1:num_pbits
        I_jj = beta*(J(jj,:)*m+h(jj));
        m(jj) = sign(tanh(I_jj)-2*rand+1);
    end

    energy = -0.5*m'*J*m-h'*m;
    if(energy<min_energy)
        min_energy = energy;
        best_state = m;
    end
end

min_energy
best_state

Look = 2.^(num_pbits-1:-1:0);
Look*(best_state+1)/2


% checking
for ii = 1:1:2^num_pbits
    m = (2*de2bi(ii-1,num_pbits,'left-msb')-1)';
    E(ii) = -0.5*m'*J*m-h'*m;
end

plot(0:1:2^num_pbits-1,E);
xlabel('States');
ylabel('Energy');

