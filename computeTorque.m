function torque = computeTorque(force, momentArm)
% Computes joint torque
% force (N), momentArm (m)

torque = force .* momentArm;
end
