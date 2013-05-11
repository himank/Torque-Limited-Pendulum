% Responsible for comparing state and updating state values
function [q_val,pre_state,pre_action,cur_state,cur_action] = get_action(theta,angular_velocity,reinf,q_val,pre_state,cur_state,pre_action,cur_action,alpha, beta, gamma)

pre_state = cur_state;
pre_action = cur_action;    
cur_state = findRegion(theta,angular_velocity);
%disp(cur_state);

fid = fopen('Successful Qvalues.log', 'a');
 
if (pre_action ~= -1)   
    if (cur_state == -1)  
        estimated_value = 0;  
    elseif (q_val(cur_state,1) <= q_val(cur_state,2)) 
        estimated_value = q_val(cur_state,2);         
    else 
        estimated_value = q_val(cur_state,1);
    end %if
    q_val(pre_state,pre_action) = q_val(pre_state,pre_action)+ alpha*(reinf+ gamma*estimated_value - q_val(pre_state,pre_action));
    
    fprintf(fid, '(Pre State %d, Pre Action %d) = (%f) \r\n', pre_state, pre_action, q_val(pre_state,pre_action));

end %if
    fclose(fid);

if ( q_val(cur_state,1) + (rand*beta) <= q_val(cur_state,2) )
     cur_action = 2;  
else
     cur_action = 1;  
end

