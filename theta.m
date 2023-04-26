a = 1;
b = 1;
c = 1;
I_1 = 2;
N = 1e5;
V_th = pi;
V0 = 0;
I0 = 2.0001;
tspan = [0 1000];
I = @(t) I0;
f = @(t,V) c.*(1 - cos(V)) + (a*b)/c.*(1 + cos(V)).*(I(t) - I_1);

line_width = 2;
font_size = 20;
[t1, V1] = generic_euler_1D(tspan,V0,N,f,V_th,- V_th);
plot(t1,V1,'LineWidth',line_width)
hold on
plot(tspan, [pi pi],'r--')
xlabel('t (ms)','FontSize',font_size)
ylabel('\theta','FontSize',font_size)
grid on
hold off