function [log_like] = ll4a(x0,caseid,choice,price)
    % Parameter
    betabar_test = x0(1,1);
    betavar_test = x0(1,2);
    xi_test = [x0(1,3) x0(1,4) x0(1,5)];
    prod_fe_test = repmat(xi_test',sum(choice),1);
    
    % Representative utility (without error)
    %V = x0(1,1)*price + prod_fe_test ;

    % Log likelihood
   % V_exp = exp(V);
    %V_chosen = V_exp(choice==1);
   % V_sum=accumarray(caseid,V_exp);
   
   %Integrate the utility
   y0 = [betabar_test betavar_test];
  
   test2 = exp(z1 * price + prod_fe_test);
   test3 = accumarray(caseid,exp(z1 * price + prod_fe_test));
   test4 = exp(z1 * price_chosen) ./ accumarray(caseid,exp(z1 * price + prod_fe_test)) ;
   test5 = ( exp(z1 * price_chosen) ./ accumarray(caseid,exp(z1 * price + prod_fe_test)) ) .* exp(-(z1-betabar_test)^2/(2*betavar_test));
   
   %test6 = exp(-(z1-betabar_test)^2/(2*betavar_test));
    
    %F = @(x)1./(x.^3-2*x-5);
    %Q = quad(F,0,2); 
    
   Fnormexp = @(y) ( exp(y * price_chosen) ./ accumarray(caseid,exp(y * price + prod_fe_test)) ) .* exp(-(y-betabar_test)^2/(2*betavar_test))
   integral_choice = quadv(Fnormexp,betabar_test - (3 * betavar_test), betabar_test + (3 * betavar_test));
   log_like_per_sit = log(integral_choice) - log(sqrt(2*pi*betavar_test))
   log_like = -sum(log_like_per_sit);
   
   % like_vec = (V_chosen./V_sum);
    %log_like = -sum(log(like_vec));
    
    
    
end