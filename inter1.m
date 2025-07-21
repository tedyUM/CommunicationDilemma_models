% Time span
t_start = 0;
t_end = 6;
dt = 0.001;
tspan = t_start:dt:t_end;
N = length(tspan);
% Natural frequencies
beta_S = 4;
beta_F = 4;
beta_N = 4;
beta_I = 4;

% Couplings
k_IS = 1;
k_SF = 1;
k_NF = -100;
k_FN = 1;

% Delay parameters
tau = 0.1;               % seconds
delay_steps = round(tau/dt);

% Initialize phases
theta_I = zeros(1,N);
theta_X = zeros(1,N);
theta_Y = zeros(1,N);
theta_N = zeros(1,N);

% Initial conditions
theta_I(1) = 0;
theta_X(1) = 0.897117;
theta_Y(1) = 4.88914;
theta_N(1) = pi/4;

% Simulation loop
for t = 2:N
    dI = beta_I;
    dS = beta_S + k_IS*sin(theta_I(t-1) - theta_X(t-1));

    if t > delay_steps
        s_delay = theta_X(t - delay_steps);
    else
        s_delay = theta_X(1); % hold initial value during transient
    end

    dF = beta_F + k_SF*sin(s_delay - theta_Y(t-1)) + k_NF*sin(theta_N(t-1) - theta_Y(t-1));
    dN = beta_N + k_FN*sin(theta_Y(t-1) - theta_N(t-1));

    theta_I(t) = theta_I(t-1) + dt*dI;
    theta_X(t) = theta_X(t-1) + dt*dS;
    theta_Y(t) = theta_Y(t-1) + dt*dF;
    theta_N(t) = theta_N(t-1) + dt*dN;
end

%% Plot
%time = (0:N-1)*dt;
%plot(time, sin(theta_X), 'b', time, sin(theta_Y), 'r', time, sin(theta_I), 'k')
%legend('S (Sensory Cortex)', 'F (PFC)', 'I (Input)')
%xlabel('Time (s)')
%ylabel('sin(Phase)')
create_fig
