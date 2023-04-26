
tspan = linspace(0,100,1e3);
y = zeros(4,length(tspan));
y0 = [-65;0.5;0.5;0.06];

I = 0:0.01:50;
f = ones(1,length(I));
for k = 1:length(I)
    [t,y] = hheuler(I(k));
    over_th = 0;
    count = 0;
    aux = y;
    for i = 1:length(y)
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
font_size = 20;
plot(I,f,'LineWidth',line_width);
grid on


title('Frequency depending on the intensity of the step current','FontSize',font_size)
xlabel('I (\mu A)','FontSize',font_size)
ylabel('f (Hz)','FontSize',font_size)

