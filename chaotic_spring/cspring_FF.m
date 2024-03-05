clf;
% Define the time span and step size
t0 = 0;
tf = 50;
dt = 0.0001; % Adjust the step size as needed for accuracy vs. computation time
t = t0:dt:tf;

% Initial conditions: [x0, y0, z0, w0, v0]
s = zeros(length(t), 5); % Stimulus
c = zeros(length(t), 2); % Sensory Cortex
f = zeros(length(t), 2); % Frontal Cortex
s(1,:) = [1, 0, 0, 2, 0]; % s0
c(1,:) = [1, 0]; % c0
f(1,:) = [1, 0]; % f0

% Coupling Strengths
ks = 5;     % Spring - Rössler
k_sc = 5;   % Stimulus - Sensory Cortex
k_cf = 5;   % Sensory Cortex - Frontal Cortex

% Time delay
tau = round(0.8/dt);

% Loop to solve iteratively
for i = 1:(length(t) - 1)
    % Update s
    s(i+1,1) = s(i,1) + dt * (-((2*pi*(s(i,3)/100 + 0.3))^2)*s(i,2));
    s(i+1,2) = s(i,2) + dt * (ks*s(i,1));
    s(i+1,3) = s(i,3) + dt * (-s(i,4) - s(i,5));
    s(i+1,4) = s(i,4) + dt * (s(i,3) + 0.1*s(i,4));
    s(i+1,5) = s(i,5) + dt * (0.1 + s(i,5)*(s(i,3) - 14));

    % Update c
    c(i+1,1) = c(i,1) + dt * (-c(i,2) + k_sc*(s(i,1) - c(i,1)));
    c(i+1,2) = c(i,2) + dt * (c(i,1) + k_sc*(s(i,2) - c(i,2)));

    % Update f with delays for c to f and self-delay for f
    if i > tau
        f(i+1,1) = f(i,1) + dt * (-f(i,2) + k_cf*(c(i-tau,1) - f(i,1)));
        f(i+1,2) = f(i,2) + dt * (f(i,1) + k_cf*(c(i-tau,2) - f(i,2)));
    else
        % Before delay, update normally
        f(i+1,1) = f(i,1) + dt * (-f(i,2) + k_cf*(c(i,1) - f(i,1)));
        f(i+1,2) = f(i,2) + dt * (f(i,1) + k_cf*(c(i,2) - f(i,2)));
    end
end

hold on;

plot(s(1:100000,1), 'LineWidth', 1);
plot(c(1:100000,1), 'LineWidth', 1);
plot(f(1:100000,1), 'LineWidth', 1);
hold off;
legend('Stimulus', 'Sensory Cortex', 'Frontal Cortex');
set(gca, 'FontSize', 12);
grid on;
