function data = neuronaldata()
    E_K = -77;
    E_Na = 50;
    E_L = -54.4;
    g_L = 0.3;
    g_Na = 120;
    g_K = 36;
    c_M = 1;
    
    conductances = struct('g_Na',{g_Na},'g_K',{g_K},'g_L',{g_L});
    nernst_potentials = struct('E_Na',{E_Na},'E_K',{E_K},'E_L',{E_L});
        
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
    
    time_constants = struct('tau_m',{tau_m},'tau_n',{tau_n},'tau_h',{tau_h});
    steady_states = struct('m_inf',{m_inf},'n_inf',{n_inf},'h_inf',{h_inf});
    other_params = struct('c_M',{c_M});
    data = struct('conductances',{conductances},'nernst_potentials',{nernst_potentials},'time_constants',time_constants,'steady_states',steady_states,'other_params',other_params);
end