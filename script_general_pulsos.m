a = 1.202;
b = 1.028;
I = 10;
data = neuronaldata();
N = 1e5;
tspan = [0 100];
tstart = 0;
duration = 100;
pulse_data = struct('intensity',{I},'tstart',{tstart},'duration',{duration});
v0 = -64.906961098102300;
w0 = 0.383562564736404;
[t, w, v] = hhsimpleuler(N,tspan,w0,v0,a,b,pulse_data,data);


line_width = 2;
font_size = 20;

figure(1)
subplot(1,2,1)
hold on
plot(t,v,'LineWidth',line_width)
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
grid on
subplot(1,2,2)
plot(t,w,'LineWidth',line_width)
xlabel('t (ms)','FontSize',font_size)
ylabel('w','FontSize',font_size)
grid on








