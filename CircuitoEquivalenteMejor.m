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
%% DERIVED PARAMETERS
g_tot = sum(g);
tau_M = C_M/g_tot;
E_tot = g*E';
%% CUSTOM PARAMETERS
I_0 = [200,400,600,800];
E_tot = 0;
V_0 = 0;
t0 = 0;
tf = 40*1e-3;
N_points = 1e3;
t_end_pulse = 20*1e-3;
%% ODE

I = @(t) I_0*(t<=t_end_pulse);
I_green = @(t) I(t).*exp(t/tau_M);
V = @(t) V_0.*exp((t0 - t)./tau_M) + tau_M.*E_tot.*(1 - exp((t0 - t)./tau_M)) + exp(-t./tau_M).*integral(I_green,t0,t);

%% GRAPH PARAMETERS
line_width = 2;
font_size = 20;

%% PLOTTING SOLUTIONS

t = linspace(t0,tf,N_points);
figure(1)
hold on
y = ones(1,N_points);
for j = 1:4
    I = @(t) I_0(j)*(t<=20*1e-3);
    I_green = @(t) I(t).*exp(t/tau_M);
    V = @(t) V_0.*exp((t0 - t)./tau_M) + (E_tot/g_tot).*(1 - exp((t0 - t)./tau_M)) + (1/(g_tot*tau_M)).*exp(-t./tau_M).*integral(I_green,t0,t);
    for i = 1:N_points
            y(i) = V(t(i));
            
    end
    plot(t,y,'LineWidth',line_width)
    xlabel('t (ms)','FontSize',font_size)
    ylabel('V (mV)','FontSize',font_size)
    grid on
end
plot([t_end_pulse, t_end_pulse],[0,5],'LineStyle','--','Color','r')
legend({'I = 200 \muA \cdot cm^{-2}', 'I = 400 \muA \cdot cm^{-2}', 'I = 600 \muA \cdot cm^{-2}','I = 800 \muA \cdot cm^{-2}'},'Location','best','FontSize',font_size)
hold off





