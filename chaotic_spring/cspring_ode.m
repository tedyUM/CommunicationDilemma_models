clf
% Define the time span
tspan = [0, 100];

% Initial conditions: [x0, y0]
s0 = [1,0,0,2,0];

k = 5; % coupling strength

% Solve the system of differential equations
[t, s] = ode45(@(t,s) [-((2*pi*(s(3)/100 + 0.3))^2)*s(2); ...
                        k*s(1); ...
                        % Rössler equations below
                        -s(4) - s(5); ...
                        s(3) + 0.1*s(4); ...
                        0.1 + s(5)*(s(3) - 14)], tspan, s0);


plot(s(:,1), s(:,2))
