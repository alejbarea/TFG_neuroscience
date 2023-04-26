function [t,w,v] = hhsimpleuler(N,tspan,w0,v0,a,b,pulse_data,data)
    %% STORING DATA
    % Nernst Potentials
    E_K = data.nernst_potentials.E_K;
    E_Na = data.nernst_potentials.E_Na;
    E_L = data.nernst_potentials.E_L;
    % Conductances
    g_K = data.conductances.g_K;
    g_Na = data.conductances.g_Na;
    g_L = data.conductances.g_L;
    % Steady-State of the w and m gates
    w_inf = @(v) a*data.steady_states.n_inf(v);
    m_inf = data.steady_states.m_inf;
    % Time constant of the w-gate
    tau_w = data.time_constants.tau_n;
    % Other parameters
    c_M = data.other_params.c_M;

    %% INITIALISATION
    N1 = N+1;
    t = linspace(tspan(1),tspan(2),N1);
    w = ones(1,N1);
    v = w;
    w(1) = w0;
    v(1) = v0;
    h = t(2) - t(1);

    %% PULSE GENERATION
    % Pulse Data
    I0 = pulse_data.intensity;
    tstart = pulse_data.tstart;
    duration = pulse_data.duration;

    I = I0*pulse_generator(tspan(2)-tspan(1),tstart,duration,N);

    %% EULER ALGORITHM

    for k =1:N
        vk = v(k);
        wk = w(k);
        Ik = I(k);
        gtot = g_K*((wk/a)^4) + g_Na*(b - wk)*(m_inf(vk)^3) + g_L;
        Etot = (g_K*((wk/a)^4)*E_K + g_Na*(b - wk)*(m_inf(vk)^3)*E_Na + g_L*E_L)/gtot;
        v(k+1) = vk + h*c_M*(-gtot*(vk - Etot) + Ik);
        w(k+1) = wk + h*(w_inf(vk) - wk)/tau_w(vk);
    end

end