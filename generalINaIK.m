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


I = 6;

tspan = [0 100];
tstart = 0;
duration = 100;
pulse_data = struct('intensity',{I},'tstart',{tstart},'duration',{duration});
N = 1e5;
V0 = -65;
w0 = 0;


[t, V, w] = INaIkeuler(tspan,pulse_data,data,N,V0,w0);
figure(1)
hold on
subplot(1,2,1)
line_width = 2;
font_size = 20;
plot(t,V,'LineWidth',line_width)

xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
grid on
subplot(1,2,2)
plot(t,w,'LineWidth',line_width)

xlabel('t (ms)','FontSize',font_size)
ylabel('w','FontSize',font_size)
grid on



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
plot(V,w,'LineWidth',line_width)
plot(V0,w0,'ro','MarkerSize',marker_size,'MarkerFaceColor','r')
plot(-24.22,0.54,'go','MarkerSize',marker_size,'MarkerFaceColor','g')
xlabel('V (mV)','FontSize',font_size)
ylabel('w','FontSize',font_size)
legend({'V nullcline','w nullcline', 'Solution','Initial condition','Unstable equilibrium'},'FontSize',font_size)
f = @(t,y) [I - g_L.*(y(1) - E_L) -g_Na.*m_inf(y(1)).*(y(1) - E_Na) - g_K.*y(2).*(y(1) - E_K),(w_inf(y(1)) - y(2))./tau_w(y(1))];



% I_list = 4.4:0.001:4.5;
% new_v_span = linspace(-70,-50,1e7);
% for i =1:length(I_list)
%     v_nullcline = @(V) (I_list(i) - g_L*(V - E_L) -g_Na.*m_inf(V).*(V - E_Na))./(g_K*(V - E_K));
%     calc = v_nullcline(new_v_span);
% 
%     m = min(calc);
%     k = w_nullcline(m);
%     if m > k
%         break;
%     end
% end