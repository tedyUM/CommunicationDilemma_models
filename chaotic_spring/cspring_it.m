clf;
% Define the time span and step size
t0 = 0;
tf = 55;
dt = 0.0005;
t = t0:dt:tf;

% Initial conditions: [x0, y0, z0, w0, v0]
s = zeros(length(t), 5);
c = zeros(length(t), 2);
s(1,:) = [1, 0, 0, 2, 0]; % s0
c(1,:) = [1, 0]; % s0
f(1,:) = [1, 0]; % s0

% Parameters for ellipse
k = 5; % coupling strength

% Loop to solve iteratively
for i=1:(length(t)-1)
    s(i+1,1) = s(i,1) + dt * (-((2*pi*(s(i,3)/100 + 0.3))^2)*s(i,2));
    s(i+1,2) = s(i,2) + dt * (k*s(i,1));
    % Rössler equations below
    s(i+1,3) = s(i,3) + dt * (-s(i,4) - s(i,5));
    s(i+1,4) = s(i,4) + dt * (s(i,3) + 0.1*s(i,4));
    s(i+1,5) = s(i,5) + dt * (0.1 + s(i,5)*(s(i,3) - 14));

    c(i+1,1) = c(i,1) + dt * (-c(i,2) + 5*(s(i,1) - c(i,1)));
    c(i+1,2) = c(i,2) + dt * (c(i,1) + 5*(s(i,2) - c(i,2)));

    f(i+1,1) = f(i,1) + dt * (-f(i,2) + 5*(c(i,1) - f(i,1)));
    f(i+1,2) = f(i,2) + dt * (f(i,1) + 5*(c(i,2) - f(i,2)));

end

plot(s(:,1), s(:,2));
