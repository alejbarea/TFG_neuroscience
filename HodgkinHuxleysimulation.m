
tspan = linspace(0,150,1e5);
y = zeros(4,length(tspan));
y0 = [-64.9797;0.5;0.5;0.06];

I = 1:0.1:2.5;
hold on
grid on
line_width = 2;
font_size = 20;
for k = 1:length(I)
    [t,y] = ode45(@(t,y) odefun(t,y,I(k)),tspan,y0);
    plot(t,y(:,1),'LineWidth',line_width)
    title('Hodgkin-Huxley equations under Dirac delta-like pulse','FontSize',font_size)
    xlabel('t (ms)','FontSize',font_size)
    ylabel('V (mV)','FontSize',font_size)
end
plot([30,30],[-100,100],'r--')
xlim([25,50])
ylim([-80,40])


legend({'I = 1 uA','I = 1.5 uA','I = 2.0 uA','I = 2.5 uA'},'FontSize',font_size)

hold off