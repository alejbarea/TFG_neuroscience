function value = int_estochastic(t,randdistrib,tspan,N,tau_M)
    T = tspan(2) - tspan(1);
    value = 0;
    for i =1:N
        if (t >= (T/N)*(i-1))
            
            if (t < (T/N)*i)
                value = value + randdistrib(i)*integral(@(s) exp(s/tau_M),(T/N)*(i-1),t);
            else
                value = value + randdistrib(i)*integral(@(s) exp(s/tau_M),(T/N)*(i-1),(T/N)*i);
            end
       


        
        end
    end
    