function sol = fixedpointnum(I) 
    E_K = -77;
    E_Na = 55;
    E_L = -54.5;
    g_L = 0.3;
    g_Na = 120;
    g_K = 36;
    c_M = 1;
    alpha_n = @(V) 0.01.*((V + 55)./(1 - exp(-(V + 55)/10)));
    beta_n = @(V) 0.125.*exp(-(V + 65)/80);
    alpha_m = @(V) 0.1.*((V + 40)./(1 - exp(-(V + 40)/10)));
    beta_m = @(V) 4.*exp(-(V + 65)./18);
    alpha_h = @(V) 0.07.*exp(-(V + 65)/20);
    beta_h = @(V) 1./(1 + exp(-(V+35)/10));
        
    m_inf = @(V) alpha_m(V)./(alpha_m(V) + beta_m(V));
    n_inf = @(V) alpha_n(V)./(alpha_n(V) + beta_n(V));
    h_inf = @(V) alpha_h(V)./(alpha_h(V) + beta_h(V));
        
    tau_m = @(V) 1./(alpha_m(V) + beta_m(V));
    tau_n = @(V) 1./(alpha_n(V) + beta_n(V));
    tau_h = @(V) 1./(alpha_h(V) + beta_h(V));
    
    f = @(y) [- g_K.*(y(3).^4).*(y(1) - E_K) - g_Na.*y(4).*y(2).^3.*(y(1) - E_Na) - g_L.*(y(1) - E_L) + I,(m_inf(y(1)) - y(2))./tau_m(y(1)),(n_inf(y(1)) - y(3))./tau_n(y(1)),(h_inf(y(1)) - y(4))./tau_h(y(1))];
    
    x0 = [-60,0,0.5,0.5];
    
    options = optimoptions('fsolve','MaxFunctionEvaluations',1e5,'MaxIterations',1e5);
    sol = fsolve(f,x0,options);
end