%% LIF

N = 2^17;



V0 = -65;
V_RES = -65;
R_M = 0.125;
C_M = 1;
tau_M = R_M.*C_M;
I01 = 850;
I02 = 800;
Vth = 40;
I_min = (Vth - V_RES)/R_M;
tstart = 0;
duration = 2;
tspan = [0 2];

% I = @(t) I0*(t>=tstart)*(t<=tstart+duration);
% noise = I0*abs(wnoise(3,17)) + 0.8;
% I_noise = @(t) I_stochastic(t,noise,tspan,N);
% normalnoise = normrnd(2,I0,1,N);
% I_normalnoise = @(t) I_stochastic(t,normalnoise,tspan,N);
% I_sinusoidal = @(t) (I0*sin(t) + 4)*(t>=tstart)*(t<=tstart+duration);
f_LIF1 = @(t,V) (- (V - V0) + R_M.*I01)./tau_M;
f_LIF2 = @(t,V) (- (V - V0) + R_M.*I02)./tau_M;

[t1, V1] = generic_euler_1D(tspan,V0,N,f_LIF1,Vth,V_RES);
[t2, V2] = generic_euler_1D(tspan,V0,N,f_LIF2,Vth,V_RES);

line_width = 2;
font_size = 20;

plot(t1,V1,'LineWidth',line_width)
grid on
hold on
plot(t2,V2,'LineWidth',line_width   )
plot([0 2], [40 40],'r--','LineWidth',line_width)
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)






