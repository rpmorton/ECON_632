function [log_like] = llnfxp(x,mle_data,beta,state_probs)
    % Parameters
    theta_test = [x(1,1) x(1,2) x(1,3)];
    
    %%
   
    val_info = value(theta_test(1,1),theta_test(1,2),theta_test(1,3),state_probs);
    val = val_info(:,3);
        
    
    %% Choice Probabilities
    prob_i0 = zeros(length(mle_data),1);
    pre_log_like = zeros(length(mle_data),1);
    for i = 1: rows(mle_data);
        demand_state_use = mle_data(i,1);
        last_operate = mle_data(i,3);
        val_i0 = sum( val .* (val_info(:,1) == demand_state_use) .* (val_info(:,2) == 0) );
        val_i1 = sum( val .* (val_info(:,1) == demand_state_use) .* (val_info(:,2) == 1) );

        prob_i0_num =  exp(beta * val_i0);
        prob_i0_den = prob_i0_num + exp(theta_test(1,1) + demand_state_use * theta_test(1,2) - (1 - last_operate) * theta_test(1,3) + beta * val_i1 );
        
        prob_i0(i,1) = prob_i0_num / prob_i0_den;
        pre_log_like(i,1) = log(prob_i0(i,1)) * (1 - mle_data(i,2)) + log( (1-prob_i0(i,1)) ) * mle_data(i,2);
        
    end;

    log_like = -sum(pre_log_like);
end