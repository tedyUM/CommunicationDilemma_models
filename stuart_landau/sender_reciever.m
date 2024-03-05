% Define the time span and step size
t0 = 0;
tf = 50;
dt = 0.001; % Adjusted for the dynamics of the Stuart-Landau model
t = t0:dt:tf;

% Initial conditions
sender = zeros(length(t), 2); % Complex number represented by two columns (real, imaginary)
receiver = zeros(length(t), 2);
sender(1,:) = [1, 0]; % Initial condition for sender
receiver(1,:) = [1, 0]; % Initial condition for receiver

% Parameters for the Stuart-Landau oscillator
alpha = 1;
omega_sender = 2*pi*1;
omega_receiver = 2*pi*1.1;
K = 0.5; % Coupling strength from sender to receiver
k_receiver = 0.5; % Self-feedback strength for receiver

% Time delay for interactions
tau = round(0.8/dt);

% Iteratively solve
for i = 1:(length(t) - 1)
    % Convert sender and receiver back to complex numbers for calculation
    sender_complex = sender(i,1) + 1i*sender(i,2);
    receiver_complex = receiver(i,1) + 1i*receiver(i,2);

    % Update sender (no coupling influence, evolves independently)
    sender_dot = (alpha + 1i*omega_sender - abs(sender_complex)^2) * sender_complex;
    sender(i+1,1) = real(sender_complex + dt * sender_dot);
    sender(i+1,2) = imag(sender_complex + dt * sender_dot);

    % Update receiver with delayed sender influence and self-feedback (both with delay)
    if i > tau
        sender_delayed = sender(i-tau,1) + 1i*sender(i-tau,2);
        receiver_delayed = receiver(i-tau,1) + 1i*receiver(i-tau,2);
        receiver_dot = (alpha + 1i*omega_receiver - abs(receiver_complex)^2) * receiver_complex + K * (sender_delayed - receiver_complex) - k_receiver * receiver_delayed;
    else
        % Before delay, only self-coupling without sender influence
        receiver_dot = (alpha + 1i*omega_receiver - abs(receiver_complex)^2) * receiver_complex;
    end
    receiver(i+1,1) = real(receiver_complex + dt * receiver_dot);
    receiver(i+1,2) = imag(receiver_complex + dt * receiver_dot);
end

% Plot the real parts of sender and receiver
hold on;
plot(t(1:10000), sender(1:10000,1), 'LineWidth', 2);
plot(t(1:10000), receiver(1:10000,1), 'LineWidth', 2);
hold off;
legend('Sender', 'Receiver');
set(gca, 'FontSize', 12);
grid on;
