%%% Parameters
beta_X = 4;
beta_Y = 4;
k = 1;
epsilon = 1;
r_I = 1.0;
omega_I = 4; % Fixed omega_I
tau_1 = 0.2;
tau_2 = 0.1;
r_X = 1;  % Constant radius for X
r_X = 1;  % Constant radius for X
r_Y = 1;  % Constant radius for Y

% Initial conditions
theta_X0 = 0.897117;
theta_Y0 = 4.88914;

initial_conditions = [theta_X0; theta_Y0];

% Time span
t_start = 0;
t_end = 4;
dt = 0.001;
tspan = t_start:dt:t_end;

% Convert delays to number of time steps
tau_1_steps = round(tau_1 / dt);
tau_2_steps = round(tau_2 / dt);

% Initialize solution arrays
theta_X = zeros(size(tspan));
theta_Y = zeros(size(tspan));
theta_I = omega_I * tspan;

% Set initial conditions
theta_X(1) = theta_X0;
theta_Y(1) = theta_Y0;

% Euler's method
for i = 2:length(tspan)
    % Indices for delayed terms
    idx_tau_1 = max(1, i - tau_1_steps);
    idx_tau_2 = max(1, i - tau_2_steps);

    theta_I_tau_1 = theta_I(idx_tau_1);
    theta_I_tau_2 = theta_I(idx_tau_2);

    % Phase reduced model equations
    dtheta_X = beta_X + k * sin(theta_I_tau_1 - theta_X(i-1));
    dtheta_Y = beta_Y + epsilon * sin(theta_I_tau_2 - theta_Y(i-1));

    % Update phase angles using Euler's method
    theta_X(i) = theta_X(i-1) + dtheta_X * dt;
    theta_Y(i) = theta_Y(i-1) + dtheta_Y * dt;
end

% Plot results
%clf;
%plot(tspan, sin(theta_X), 'b', tspan, sin(theta_Y), 'r', tspan, sin(theta_I), 'g');
%title('Phase Angles \theta_X, \theta_Y and \theta_I');
%xlabel('Time');
%ylabel('Phase Angles');
%legend('\theta_X', '\theta_Y', '\theta_I');
create_fig
