function [t,v,w] = FitzHughEuler(a,b,c,pulse_data,N,v0,w0,tspan)
    N1 = N+1;
    t = linspace(tspan(1),tspan(2),N1);
    h = (t(2) - t(1));
    I0 = pulse_data.intensity;
    tstart = pulse_data.tstart;
    duration = pulse_data.duration;
    tsim = tspan(2) - tspan(1);
    I = I0*pulse_generator(tsim,tstart,duration,N);

    v = ones(1,N1);
    w = ones(1,N1);
    v(1) = v0;
    w(1) = w0;
    for k =1:N
        vk = v(k);
        wk = w(k);
        Ik = I(k);
        v(k+1) = vk + h*(vk*(a - vk)*(vk - 1) - wk + Ik);
        w(k+1) = wk + h*(b*vk - c*wk);
    end
end