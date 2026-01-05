% REER Load & Fatigue Analysis
% Scenario: Emergency responder lifting load
% Objective: Compare joint torque and fatigue
% Human-only vs Exosuit-assisted lifting
%
% Assumptions:
% 1. Vertical lift
% 2. Quasi-static motion
% 3. Torque = Force * moment arm
% 4. Constant assist ratio
% 5. Fatigue ∝ torque × time
% Physical parameters
mass = 25;            % load in kg
g = 9.81;             % gravity (m/s^2)
momentArm = 0.4;      % joint moment arm (m)
assistRatio = 0.4;    % 40% exosuit assistance
% Forces
humanForce = mass * g;
assistedForce = humanForce * (1 - assistRatio);
% Joint torques
torqueHuman = computeTorque(humanForce, momentArm);
torqueAssisted = computeTorque(assistedForce, momentArm);
disp([torqueHuman torqueAssisted])
% Time parameters
liftTime = 10;   % seconds
% Fatigue calculation
fatigueHuman = fatigueIndex(torqueHuman, liftTime);
fatigueAssisted = fatigueIndex(torqueAssisted, liftTime);
fatigueReductionPercent = ...
    (1 - fatigueAssisted / fatigueHuman) * 100;

fprintf("Fatigue reduction: %.2f %%\n", fatigueReductionPercent);
% Visualization labels
labels = categorical({'Human Only','With Exosuit'});
labels = reordercats(labels, {'Human Only','With Exosuit'});

% Data arrays
torques = [torqueHuman, torqueAssisted];
fatigueVals = [fatigueHuman, fatigueAssisted];

% Torque comparison plot
figure;
bar(labels, torques);
ylabel('Joint Torque (Nm)');
title('Joint Torque Comparison');

% Fatigue comparison plot
figure;
bar(labels, fatigueVals);
ylabel('Fatigue Index');
title('Fatigue Reduction with Exosuit');
% Range of loads
loadWeights = 10:5:50;  % kg
torqueHumanArray = zeros(size(loadWeights));
torqueAssistedArray = zeros(size(loadWeights));
fatigueHumanArray = zeros(size(loadWeights));
fatigueAssistedArray = zeros(size(loadWeights));

for i = 1:length(loadWeights)
    humanF = loadWeights(i) * g;
    assistedF = humanF * (1 - assistRatio);

    torqueHumanArray(i) = computeTorque(humanF, momentArm);
    torqueAssistedArray(i) = computeTorque(assistedF, momentArm);

    fatigueHumanArray(i) = fatigueIndex(torqueHumanArray(i), liftTime);
    fatigueAssistedArray(i) = fatigueIndex(torqueAssistedArray(i), liftTime);
end
figure;
plot(loadWeights, torqueHumanArray, '-o', 'LineWidth', 2);
hold on;
plot(loadWeights, torqueAssistedArray, '-o', 'LineWidth', 2);
xlabel('Load Weight (kg)');
ylabel('Joint Torque (Nm)');
legend('Human Only','With Exosuit');
title('Torque vs Load Weight');
grid on;

figure;
plot(loadWeights, fatigueHumanArray, '-o', 'LineWidth', 2);
hold on;
plot(loadWeights, fatigueAssistedArray, '-o', 'LineWidth', 2);
xlabel('Load Weight (kg)');
ylabel('Fatigue Index');
legend('Human Only','With Exosuit');
title('Fatigue vs Load Weight');
grid on;
