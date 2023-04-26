% We set the value of the constants

tauM = 1;
Etot = -10;
V0 = 0;
t0 = 0;
tsim = 4;
% We now define the pulse, in this case a rectangular one
t1 = 1;
t2 = 10;
I0 = [50,30,10,2];
line_width = 2;


hold on
for j = 1:4
    I = @(t) I0(j).*(t-t1>=0).*(t2-t>=0);
    I_integrand = @(t) I(t) .* exp(t/tauM);

    t = linspace(t0,tsim);

    V = @(t) V0.*exp((t0 - t)/tauM) + tauM*Etot.*(1 - exp((t0 - t)/tauM)) + exp(-t/tauM).*I0(j).*(t-t1>=0);

    for i = 1:length(t)
        y(i) = V(t(i));
        
    end
    plot(t,y,'LineWidth',line_width)
end
shg
title_font_size = 30;
axis_font_size = 30;
legend_font_size = 20;
legend({'I = 50 A', 'I = 30 A', 'I = 10 A','I = 2 A',' '},'Location','best','FontSize',legend_font_size)
plot([t1, t1],[-10,15],'LineStyle','--','Color','r')

grid on

xlabel('t (s)','FontSize',axis_font_size)
ylabel('V (mV)','FontSize',axis_font_size)