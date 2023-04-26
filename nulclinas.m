data = neuronaldata();
% Nernst Potentials
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


I = 0;
line_width = 2;
font_size = 20;
v_nullcline = @(V) (I - g_L*(V - E_L) -g_Na.*m_inf(V).*(V - E_Na))./(g_K*(V - E_K));
w_nullcline = @(V) w_inf(V);

v_graph_nullclines_span = linspace(-75,20,1e6);

figure(2)
marker_size = 10;
hold on
plot(v_graph_nullclines_span,v_nullcline(v_graph_nullclines_span),'LineWidth',line_width)
grid on
plot(v_graph_nullclines_span,w_nullcline(v_graph_nullclines_span),'LineWidth',line_width)
ylim([0,0.7])

plot(-65.9,0,'ro','MarkerSize',marker_size,'MarkerFaceColor','r')
plot(-56.3,0,'go','MarkerSize',marker_size,'MarkerFaceColor','g')
plot(-24.53, 0.523,'go','MarkerSize',marker_size,'MarkerFaceColor','g')
xlabel('V (mV)','FontSize',font_size)
ylabel('w','FontSize',font_size)
legend({'V nullcline','w nullcline', 'Stable equilibrium','Unstable equilibrium 1','Unstable equilibrium 2'},'FontSize',font_size)