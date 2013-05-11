% Divide the states into multiple regions so that we can put the value into
% that particular region that suits us.

function [region] = findRegion(theta,angular_velocity)
    move = pi/180;  
    %region = -1;    
     
     if (theta > 200*move || theta < -200*move)
        region = -1;
       % disp(theta);
        return;
     end %if
    
    if (theta == -180*move || theta == 180*move)        
        region = 1;
    
    elseif (theta >= 178*move)
        region = 2;
    elseif (theta >= 176*move)
        region = 3;    
    elseif (theta >= 174*move)
        region = 4;    
    elseif (theta >= 172*move)
        region = 5;    
    elseif (theta >= 170*move)
        region = 6;
    
    
    
    elseif (theta <= -178*move)        
        region = 7;
    
    elseif (theta <= -176*move)        
        region = 8;
    
    elseif (theta <= -174*move)        
        region = 9;
        
    elseif (theta <= -172*move)        
        region = 10;
    
    elseif (theta <= -170*move)        
        region = 11;    
    
    else
        region = 12;
    end  %if
    
%     if (angular_velocity > 360*move || angular_velocity < -360*move)  
%         %region = region + 12;
%     elseif (angular_velocity >= 240*move)  
%         region = region + 20;
%     elseif (angular_velocity >= 120*move)  
%         region = region + 40;
%     elseif (angular_velocity >= move)  
%         region = region + 60;
%     elseif (angular_velocity >= -120*move)  
%         region = region + 80;
%     elseif (angular_velocity >= -240*move)  
%         region = region + 100;
%     elseif (angular_velocity >= -360*move)  
%         region = region + 120;
%     end
    if (angular_velocity > -50*move && angular_velocity < 50*move)
        region = region + 12;
    else
        region = region + 24;
    end 
  
    
   
    