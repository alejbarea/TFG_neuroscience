I = 2:2:10;

l = length(I);

line_width = 2;
font_size = 20;
hold on
grid on
for i = 1:l
    [t, V] = hheuler(I(i));
    
    plot(t,V,'LineWidth',line_width)
end
xlim([25, 50])
title('Hodgkin-Huxley equations under Dirac delta-like pulse','FontSize',font_size)
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
legend({'I = 2 \mu A','I = 4 \mu A','I = 6 \mu A','I = 8 \mu A','I = 10 \mu A',},'FontSize',font_size)