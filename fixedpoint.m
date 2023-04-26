syms V_M E_K E_L E_Na m n h c_M g_K g_L g_Na
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
eqn = - g_K*n^4*(V_M - E_K) - g_Na*h*m^3*(V_M - E_Na) - g_L*(V_M - E_L) == 0;

solve(eqn, V_M)

jacob = jacobian([- g_K*n^4*(V_M - E_K) - g_Na*h*m^3*(V_M - E_Na) - g_L*(V_M - E_L),(m_inf(V_M) - m)./tau_m(V_M),(n_inf(V_M) - n)./tau_n(V_M),(h_inf(V_M) - h)./tau_h(V_M)],[V_M,m,n,h]);
E_K = -77;
E_Na = 50;
E_L = -54.4;
g_L = 0.3;
g_Na = 120;
g_K = 36;
c_M = 1;

I = 9.5:0.1:10;
l = length(I);
for k = 1:l
    sol = fixedpointnum(I(k));
    V_M = sol(1);
    m = sol(2);
    n = sol(3);
    h = sol(4);
    jacob_eval = subs(jacob);
    
    eigenvalues = eig(jacob_eval);
    
    arrayfun(@(x) double(x),eigenvalues)

end




