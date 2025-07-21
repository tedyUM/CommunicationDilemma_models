%% Time parameters
dt = 0.01;
T = 30;
N = T/dt;

% Frequencies
beta_E = 2*pi*1;
beta_D = 2*pi*1;
beta_M = 2*pi*1;
beta_S = 2*pi*1;
beta_N = 2*pi*1;

% Couplings
k_EM = 1;
k_DM = 0.1;
k_MS = 0.1;
k_DS = 2;
k_NS = -1;
k_SN = 1;
k_DN = 1;

% Delay parameters
tau = 0.5;
delay_steps = round(tau/dt);

% Initialization
theta_E = zeros(1,N);
theta_D = zeros(1,N);
theta_M = zeros(1,N);
theta_S = zeros(1,N);
theta_N = zeros(1,N);

theta_E(1) = 0;
theta_D(1) = pi/6;
theta_M(1) = pi/4;
theta_S(1) = pi/2;
theta_N(1) = pi/3;

% Simulation
for t = 2:N
    dE = beta_E;
    dD = beta_D;
    dM = beta_M + k_EM*sin(theta_E(t-1) - theta_M(t-1)) + k_DM*sin(theta_D(t-1) - theta_M(t-1));

    if t > delay_steps
        theta_M_delayed = theta_M(t - delay_steps);
    else
        theta_M_delayed = theta_M(1);
    end

    dS = beta_S + k_MS*sin(theta_M_delayed - theta_S(t-1)) + ...
                  k_DS*sin(theta_D(t-1) - theta_S(t-1)) + ...
                  k_NS*sin(theta_N(t-1) - theta_S(t-1));
    dN = beta_N + k_SN*sin(theta_S(t-1) - theta_N(t-1)) + ...
                  k_DN*sin(theta_D(t-1) - theta_N(t-1));

    theta_E(t) = theta_E(t-1) + dt*dE;
    theta_D(t) = theta_D(t-1) + dt*dD;
    theta_M(t) = theta_M(t-1) + dt*dM;
    theta_S(t) = theta_S(t-1) + dt*dS;
    theta_N(t) = theta_N(t-1) + dt*dN;
end

% Plot
time = (0:N-1)*dt;
plot(time, sin(theta_M), 'b', time, sin(theta_S), 'r', time, sin(theta_E), 'k')
legend('M (Master)', 'S (Slave)', 'E (Input)')
xlabel('Time (s)')
ylabel('sin(Phase)')
