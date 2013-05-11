
	
 		Torque Limited Pendulum 

The task is to swing up and stabilize a single pendulum at the upright position based on energy control using reinforcement learning. The pendulum is hanging to a fixed point.

In this system, 0 radian corresponds to minimum potential energy (when the pendulum is hanging down still) and +- pi is the position of maximum potential energy. Now each trial will start from 
x (0) = (theta(0),0) and then theta will be selected from in range [-pi, pi]. A trial lasted till the time pendulum stabilizes in the upright position and for this particular simulation I am taking a counter which depicts success i.e. if pendulum reaches near to the goal (+- 10 degree) then that counter will increase and to succeed pendulum should cover atleast 400 success in a trial.

In this simulation, value of reward is taken as -cos(theta) i.e. 
Reinf = -cos(theta) In case of success 
Reinf = -1 If theta reaches greater/lesser than pi/-pi. 

The equation of motion is: 
	I*alpha = mglsin(theta) - u(t) 		(1)
		m: mass of rod 
		l: length of the rod 
		alpha = Angular acceleration. 
		theta = Angular Position. 
		w = Angular frequency 
		u(t) = torque to the pendulum (which will change at each instant of time) 

	w = w(prev) + alpha*T 		(2)
	theta = theta(prev) + w*T 		(3)
	U(t) = umaxsign(w*cos(theta)) 	(4)

In this problem, the agent must learn to combine two policies,
  
A Swing Up Policy - The agent must learn to build enough momentum to swing the pendulum upright. 

A Balance Policy - Learn to balance when reached the goal point. 

Environment is divided into state space to represent multiple states for which agent will check the maximum value and decide action based on that. Two actions are used Left and Right. Left action depict push pendulum towards left and similarly right action to push pendulum towards right. 
When the theta falls out of the range then trial fails and new trial start with all position reinitialized to initial state.

Future work: This system can be extended or improved by optimizing the torque function more aptly and dividing the state space more keenly. This system consider upright position from (-170 to -180 degree && 170 to 180 degree) that is with around 10 percent loss in accuracy. 