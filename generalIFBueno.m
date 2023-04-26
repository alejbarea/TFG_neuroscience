%% LIF

N = 2^11;


delta_Vth = 5;
tau_Vth = 10;
V0 = -65;
V_RES = -65;

R_M = 10;
tau_M = 5;
C_M = 0.5;
I0 = 2.3;
Vth0 = -50;
tstart = 0;
Vth = Vth0;
f_Vth = @(t) Vth0;
duration = 20;
tspan = [0 200];

I = @(t) I0.*(t>=tstart).*(t<=tstart+duration);
noise = I0*abs(wnoise(3,17)) + 0.8;
I_noise = @(t) I_stochastic(t,noise,tspan,N);
normalnoise = normrnd(2,I0,1,N);
I_normalnoise = @(t) I_stochastic(t,normalnoise,tspan,N);
I_sinusoidal = @(t) (I0*sin(t) + 4)*(t>=tstart)*(t<=tstart+duration);
f_LIF = @(t,V) (- (V - V0) + R_M.*I(t))./tau_M;

[t, V] = generic_euler_1D(tspan,V0,N,f_LIF,Vth,V_RES);
% N1 = N+1;
% t = linspace(tspan(1),tspan(2),N1);
% f_V = @(t) V0 + (exp(-(t/tau_M))/C_M).*int_estochastic(t,normalnoise,tspan,N,tau_M);
% V = ones(1,N1);
% V(1) = V0;
% Vth = ones(1,N1);
% Vth(1) = Vth0;
% for k = 1:N
%     Vk = V(k);
%     tk = t(k);
%     Vthk = Vth(k);
%     Vth(k+1) = f_Vth(tk);
%     if Vk > Vthk
%         f_V = @(t) f_V(t) + (V_RES - Vthk)*(exp(-((t-tk)/tau_M)));
%         f_Vth = @(t) f_Vth(t) + delta_Vth*(exp(-((t-tk)/tau_Vth)));
%     end
%     V(k+1) = f_V(tk);
% end
 line_width = 2;
 font_size = 20;

plot(t,V,'LineWidth',line_width)
grid on
hold on
%plot([0 200], [-50 -50],'r--','LineWidth',line_width)
plot(t,Vth,'r--','LineWidth',line_width)
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)






