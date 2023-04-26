function I = I_stochastic(t,randdistrib,tspan,N)
    T = tspan(2) - tspan(1);
    for i =1:N
        if ((t  < (T/N)*i) && (t >= (T/N)*(i-1) ))
            I = randdistrib(i);
            return
        end
    end
    I = 0;


end