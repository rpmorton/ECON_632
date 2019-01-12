%Created by RM on 2019.01.12 for ECON 632
%Part II: Programming

%%%%%%%%
%1. Underflow and Overflow
%%%%%%%%

val_over = 0;
loop_over = 1;

while loop_over > 0
    
        val_over = val_over + 100;
        val_test = log(exp(val_over));
        if val_test ~= val_over
               loop_over = -1;
        end;
        
end;

lowerbound_over = 0;
upperbound_over = val_over;
midpoint_over = (upperbound_over + lowerbound_over) / 2;
first = 1
tol = 10^(-14);

while abs(midpoint_over-midlast_over) > tol;
    
    if first > 0 
        midlast_over = 1
        first = -1
    else
        midlast_over = midpoint_over;
    end;
    midpoint_over = (upperbound_over + lowerbound_over) / 2;

    test_mid_over = log(exp(midpoint_over));
    if midpoint_over == test_mid_over
        lowerbound_over = midpoint_over
    else
        upperbound_over = midpoint_over
    end;
    
end;
bound_over = min(midpoint_over,midlast_over);

val_under = 0;
loop_under = 1;

while loop_under > 0
    
        val_under = val_under - 100;
        val_test = log(exp(val_under));
        if val_test ~= val_under
               loop_under = -1;
        end;
        
end;

lowerbound_under = val_under;
upperbound_under = 0;
midpoint_under = (upperbound_under + lowerbound_under) / 2;
midlast_under = 0;
first = 1;

tol = 10^(-14);

while abs(midpoint_under-midlast_under) > tol;
    
 if first > 0 
        midlast_under = 1
        first = -1
    else
        midlast_under = midpoint_under;
    end;
    midpoint_under = (upperbound_under + lowerbound_under) / 2;
    
    test_mid_under = log(exp(midpoint_under));
    if midpoint_under == test_mid_under
        upperbound_under = midpoint_under
    else
        lowerbound_under = midpoint_under
    end; 

end;
bound_under = max(midpoint_under,midlast_under);

bound_under
bound_over

%check_val = log(exp(bound_under));
%abs(check_val - bound_under)


%%%%%%%%
%2. Accumarray
%%%%%%%%

rand_vector = randi([-10 10],1,200);

deduped_vals = unique(rand_vector,'stable')
add_zeros = zeros(rows(deduped_vals'))
col_add_zeros = add_zeros(1:rows(add_zeros),1)
accum_output = horzcat(deduped_vals',col_add_zeros)

for num = 1:rows(deduped_vals') 
    compare_val = accum_output(num,1);
    val_counter = 0;
    
    last_row = rows(rand_vector');
    
    for i = 1:last_row
        if rand_vector(1,i) == compare_val
            val_counter = val_counter + 1;
        end;
        
        if i == last_row
            accum_output(num,2) = val_counter;
        end;
        
    end;
    
end;


        
        


