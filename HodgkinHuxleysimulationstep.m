
tspan = linspace(0,200,1e4);
y = zeros(4,length(tspan));

y0 = [-65;0.05;0.32;0.6];

I = 10;
hold on
grid on
line_width = 2;
font_size = 20;

[t,y] = ode45(@(t,y) odefun(t,y,I),tspan,y0);

figure(1)
hold on
plot(t,y(:,1),'LineWidth',line_width)
grid on
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
plot([114 114],[-80 50],'r--')
hold off