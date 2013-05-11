% When action is fail then reinitialise the pendulum position
function [pre_state,cur_state,pre_action,cur_action,hinge,theta,angular_velocity] = resetState(beta)  % reset the cart pole to initial state

pre_state = 1;
cur_state = 1;
pre_action = -1;  % -1 means no action been taken
cur_action = -1;
hinge = 0;     % the location of hinge
theta = rand*beta;   %the angle of pole
angular_velocity = rand*beta;    %the velocity of pole angle
