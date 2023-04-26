function [t,V,w] = INaIkeuler(tspan,pulse_data,data,N,V0,w0)
    E_K = data.nernst_potentials.E_K;
    E_Na = data.nernst_potentials.E_Na;
    E_L = data.nernst_potentials.E_L;
    % Conductances
    g_K = data.conductances.g_K;
    g_Na = data.conductances.g_Na;
    g_L = data.conductances.g_L;
    % Steady-State of the w and m gates
    w_inf = data.steady_states.n_inf;
    m_inf = data.steady_states.m_inf;
    % Time constant of the w-gate
    tau_w = data.time_constants.tau_n;
    % Other parameters
    c_M = data.other_params.c_M;

    I0 = pulse_data.intensity;
    tstart = pulse_data.tstart;
    duration = pulse_data.duration;
    
    I = I0*pulse_generator(tspan(2) - tspan(1),tstart,duration,N);
    
    N1 = N+1;
    t = linspace(tspan(1),tspan(2),N1);
    h = t(2) - t(1);
    V = ones(1,N1);
    w = ones(1,N1);
    V(1) = V0;
    w(1) = w0;
    hC = h/c_M;
    for k=1:N
        Vk = V(k);
        Ik = I(k);
        wk = w(k);
        V(k+1) = V(k) + hC*(Ik - g_L*(Vk - E_L) - g_Na*m_inf(Vk)*(Vk - E_Na) - g_K*wk*(Vk - E_K));
        w(k+1) = w(k) + h*((w_inf(Vk) - wk)/tau_w(Vk));
    end




end




