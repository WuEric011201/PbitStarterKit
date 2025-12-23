% This code simulates a single p-bit at constant temperature T = 1. For a
% given p-bit input I_i, we apply the p-bit update rule, then record the
% state of the p-bit. We do this 100000 times (100000 "sweeps"). We then
% plot the average state of the p-bit, <m>, as a function of I_i.

clear;
clc;
rng(123);

fontsize = 20;

% Sigmoid Plot

num_sweeps = 100000;
I_i_vals = linspace(-4,4,21);
avg_m_vals = [];

for i = I_i_vals
    statevec = zeros(num_sweeps, 1);
    statevec(1) = 2 * randi([0, 1]) - 1;
    for j = 1:num_sweeps
        statevec(j) = sign(tanh(i) - 2*rand()+1);
    end
    avg_m_vals = [avg_m_vals, mean(statevec)];
end

custom_color = [0, .447, .741];
figure;
plot(I_i_vals, tanh(I_i_vals), '--', 'Color', 'black');
hold on;
plot(I_i_vals, avg_m_vals ,'o', 'Color', custom_color);

y = ylabel('$m_i$', 'Interpreter', 'latex');
x = xlabel('$I_i$' , 'Interpreter' , 'latex');
ylim([-1.1,1.1]);
xlim([-4,4]);
legendObj = legend('$\tanh(I_i)$','$\langle m_i \rangle$', 'Interpreter', 'latex');
legendObj.LineWidth = .5;
set(legendObj, 'Position', [0.635,      0.5,      0.23832,      0.17763]);

set(legendObj, 'FontSize', 14);
set(y, 'FontSize', fontsize);
set(x, 'FontSize', fontsize);
