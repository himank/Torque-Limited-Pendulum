function Pendulum
    clear, clc, close all;

    global alpha beta gamma
    alpha = 0.2;  % learning rate parameter 
	beta = 0.01;    % magnitude of noise added to choice 
	gamma = 0.85;  % discount factor for future reinf 
    mp = 0.1; %mass of the pole
	g = 9.8;  
	length = 1;  %length of pole
	T = 0.02;  % Update time interval
    success = 0;   % succesee 0 times
	success_total = 0;
    reinf = 0;
    trial = 0;
    best = 0;
    success_theta = [];
    success_velocity = [];
    success_trail = [];
    g = gamma;
    
	[pre_state,cur_state,pre_action,cur_action,hinge,theta,angular_velocity] = resetState(beta);  % reset the pole to initial state
	q_val=zeros(36 ,2);
	h1 = figure;    % 
	
	while (success < 400)
        [q_val,pre_state,pre_action,cur_state,cur_action] = fetchValue(theta,angular_velocity,reinf,q_val,pre_state,cur_state,pre_action,cur_action,alpha, beta, gamma);
        
        % Force Based on action
        if (cur_action == 1)   
            F = -1;
        else
            F = 1;    
        end %if
        
        % Calculate torque factor, angular acceleration , angular velocity & theta
        factor = (0.5)*sign(angular_velocity*cos(theta));
        a_theta = F*(mp*g*sin(theta) - factor)/mp*(length^2);
        angular_velocity = angular_velocity + a_theta*T;
        theta = theta + angular_velocity*T;
        
        figure(h1);
        axis([-2 2 -1 1]);
        X=[hinge   hinge+cos(3*pi/2 + theta)];
        Y=[0.1  (0.1+sin(3*pi/2-theta))];
        obj = rectangle('Position',[hinge-0.2,0,0.4,0.1],'facecolor','c');
        obj2 = line(X,Y);
        
        hold on
        pause(0.00000000001)
        delete(obj)
        delete(obj2)
        [region] = findRegion(theta,angular_velocity);
        if (region == -1)  % if fail
            reinf = -1;
            trial = trial+1;
            if (success > best)
                best = success;
            end
            success=0;
            success_total = 0;
            success_theta = [];
            success_velocity = [];
            
            figure(h1);
            title(strcat('Trials  ',num2str(trial),', Best success : ',num2str(best)));
            predicted_value = 0;
            q_val(pre_state,pre_action)= q_val(pre_state,pre_action)+ alpha*(reinf+ gamma*predicted_value - q_val(pre_state,pre_action));
        	[pre_state,cur_state,pre_action,cur_action,hinge,theta,angular_velocity] = resetState(beta);  % reset the pole to initial state
            %disp('fail');
        else
            % Depicting a state when pendulum is upright with +- 20 degree
            % of margin so increase the counter
            if ((theta >= 0.83*pi) || (theta <= -0.83*pi))
                success=success+1;      
            end
            % For the purpose of creating graph
            success_total = success_total + 1;
            success_theta = [success_theta; theta*180/pi];
            success_velocity = [success_velocity; angular_velocity*180/pi];
            
            reinf = -cos(theta);    % Reward in terms of cos(Theta)
            
        end  %if (box
        
	end %while
    figure(h1);
    X=[hinge   hinge + cos(3*pi/2 + theta)];
    Y=[0.2  0.2 + sin(3*pi/2-theta)];
    rectangle('Position',[hinge - 0.2,0.1,0.4,0.1],'facecolor','c');
    line(X,Y);  
    hold on
        
    title(strcat('Run End at Trial',num2str(trial)));
    figure;
    axis([0 500 -200 200]);
    scatter(1:success_total, success_theta,'*');
    
    title('Theta Vs Success');
    figure;
    scatter(1:success_total, success_velocity,'*');
    title('Angular Velocity Vs Success');
    
    fid = fopen('SuccessLog_Theta.log', 'w');
    for i = 1:success_total
        fprintf(fid, 'At step %s (theta,angular_velocity) = (%f, %f) \r\n', num2str(i), success_theta(i), success_velocity(i));
    end    
    fclose(fid);
end

% Sign function
function [y] = sign(x)
    y = x./(abs(x)+(x==0)); 
end