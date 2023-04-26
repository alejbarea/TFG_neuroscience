%% PARAMETERS
C_M = 1;
E_Na = 55;
E_K = -77;
E_L = -54.5;
g_Na = 120;
g_K = 36;
g_L = 0.3;
g = [g_Na,g_K,g_L];
E = [E_Na, E_K, E_L];


%% FUNCTIONS
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
global E_Na E_K E_L g_Na g_K g_L g E m_inf n_inf h_inf
syms m n h V_M
jacob = jacobian([- g_K*n^4*(V_M - E_K) - g_Na*h*m^3*(V_M - E_Na) - g_L*(V_M - E_L),(m_inf(V_M) - m)./tau_m(V_M),(n_inf(V_M) - n)./tau_n(V_M),(h_inf(V_M) - h)./tau_h(V_M)],[V_M,m,n,h]); 

figure(1)
hold on
I_list = 160:0.01:180;
l = length(I_list);
for i = 1:l
    fixed_point = calculate_fixed_point(I_list(i));
    V_M = fixed_point;
    m = m_inf(fixed_point);
    h = h_inf(fixed_point);
    n = n_inf(fixed_point);
    eigenvalues = eig(jacob_f(V_M,h,m,n));
    s = stability(eigenvalues);
    if s == 0
        plot(I_list(i),V_M,'ro','MarkerFaceColor','r')
    else
        plot(I_list(i),V_M,'ko','MarkerFaceColor','k')
    end
end
hold off
function x = calculate_fixed_point(I)
    global E_Na E_K E_L g_Na g_K g_L g E m_inf n_inf h_inf
    F = @(V) g_K.*n_inf(V).^4.*(V - E_K) + g_Na.*m_inf(V).^3.*h_inf(V).*(V - E_Na) + g_L.*(V - E_L) - I;
    x = fzero(F,-65);
end

function s = stability(eigenvalues)
    
    eigenvalues_real_part = real(eigenvalues);
    if any(eigenvalues_real_part > 0)
        s = 0;
    else
        s = 1;
    end
end


