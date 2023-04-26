function I_pulse = pulse_generator(tspan,tstart,duration,N)
    I_pulse = [zeros(1,(tstart/tspan)*N),ones(1,(duration/tspan)*N + 1)];
    I_pulse = [I_pulse,zeros(1,N+1-length(I_pulse))];





end