function [t,V,m,n,h] = hheuler(I0)   
    E_K = -77;
    E_Na = 50;
    E_L = -54.4;
    g_L = 0.3;
    g_Na = 120;
    g_K = 36;
    c_M = 1;
    T = 20;
    
    alpha_n = @(V) 0.01.*((V + 55)./(1 - exp(-(V + 55)/10)));
    beta_n = @(V) 0.125.*exp(-(V + 65)/80);
    alpha_m = @(V) 0.1.*((V + 40)./(1 - exp(-(V + 40)/10)));
    beta_m = @(V) 4.*exp(-(V + 65)./18);
    alpha_h = @(V) 0.07.*exp(-(V + 65)/20);
    beta_h = @(V) 1./(1 + exp(-(V +35)/10));
    m_inf = @(V) alpha_m(V)./(alpha_m(V) + beta_m(V));
    n_inf = @(V) alpha_n(V)./(alpha_n(V) + beta_n(V));
    h_inf = @(V) alpha_h(V)./(alpha_h(V) + beta_h(V));
    tau_m = @(V) 1./(alpha_m(V) + beta_m(V));
    tau_n = @(V) 1./(alpha_n(V) + beta_n(V));
    tau_h = @(V) 1./(alpha_h(V) + beta_h(V));
    
    tspan = 30;
    tstart = 0;
    N = 1e5;
    duration = 30;
    
    
    I_pulse = pulse_generator(tspan,tstart,duration,N);
    
    
    I = I0*I_pulse;
    
    
    t = linspace(0,tspan,N+1);
    V = zeros(1,N+1);
    m = zeros(1,N+1);
    h = zeros(1,N+1);
    n = zeros(1,N+1);
    
    V(1) =-65; 
    m(1) = 0.05;
    h(1) = 0.6;
    n(1) = 0.32;
    dt = t(2) - t(1);
    dtcm = dt/c_M;
    for k = 1:N
        Vk = V(k);
        nk = n(k);
        hk = h(k);
        mk = m(k);
        V(k+1) = Vk + dtcm*(- g_Na*hk*mk^3*(Vk - E_Na) - g_K*nk^4*(Vk - E_K) - g_L*(Vk - E_L) + I(k));
        n(k+1) = nk + dt*((n_inf(Vk) - nk)/tau_n(Vk));
        h(k+1) = hk + dt*((h_inf(Vk) - hk)/tau_h(Vk));
        m(k+1) = mk + dt*((m_inf(Vk) - mk)/tau_m(Vk));
    end
    


end










