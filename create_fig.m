clf;
hold on

% Plot and stem the first data set
[peaks, locs] = findpeaks(sin(theta_I), tspan);
plot(tspan, sin(theta_I), 'b', 'LineWidth', 8);
stem(locs, peaks, 'v', 'filled', 'LineStyle', 'none', 'MarkerSize', 7, 'color', 'b', 'LineWidth', 9);

% Plot and stem the second data set
[peaks, locs] = findpeaks(sin(theta_X), tspan);
plot(tspan, sin(theta_X), 'g', 'LineWidth', 8);
stem(locs, peaks, 'v', 'filled', 'LineStyle', 'none', 'MarkerSize', 7, 'color', 'g', 'LineWidth', 9);

% Plot and stem the third data set
[peaks, locs] = findpeaks(sin(theta_Y), tspan);
plot(tspan, sin(theta_Y), 'r', 'LineWidth', 8);
stem(locs, peaks, 'v', 'filled', 'LineStyle', 'none', 'MarkerSize', 7, 'color', 'r', 'LineWidth', 9);

% Set the remaining axes properties
grid on;
set(gca, 'GridAlpha', 1, 'GridLineStyle', '--');
set(gcf, 'Color', 'w');
hold off;
set(gca, 'XColor', 'none', 'YColor', 'none');
