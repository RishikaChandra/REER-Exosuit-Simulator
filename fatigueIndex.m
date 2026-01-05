function fatigue = fatigueIndex(torqueArray, dt)
% Cumulative fatigue over time
% torqueArray = torque at each time step
% dt = time step (s)

fatigue = sum(torqueArray .* dt);  % element-wise multiplication
end

