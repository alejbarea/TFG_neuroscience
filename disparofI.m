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



tspan = [0 1000];
tstart = 0;
duration = 1000;

N = 1e5;
V0 = -65;
w0 = 0;

I_list = 0:0.01:10;
f = ones(1,length(I_list));

for k = 1:length(I_list)
    pulse_data = struct('intensity',{I_list(k)},'tstart',{tstart},'duration',{duration});
    [t, V, ~] = INaIkeuler(tspan,pulse_data,data,N,V0,w0);
    over_th = 0;
    count = 0;
    aux = V;
    for i = 1:length(V)
        if (aux(i) > 0) && over_th == 0
            count = count + 1;
            over_th = 1;
        end
        if (aux(i) < 0) && over_th == 1
            over_th = 0;
        end
    end
    f(k) = count;
    
end
line_width = 2;
plot(I_list,f,'LineWidth',line_width)
hold on
grid on
ylabel('f (Hz)','FontSize',font_size)
xlabel('I (uA)','FontSize',font_size)