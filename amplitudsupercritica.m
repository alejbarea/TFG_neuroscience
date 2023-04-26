tspan = linspace(0,100,1e3);
y = zeros(4,length(tspan));
y0 = [-65;0.5;0.5;0.06];

I = 65:0.5:200;
A = ones(1,length(I));
for k = 1:length(I)
    [t,y] = hheuler(I(k));
    A(k) = max(y(t > 10)) - min(y(t > 10));
    
end

line_width = 2;
font_size = 20;
plot(I,A,'LineWidth',line_width);
grid on



xlabel('I (\mu A \cdot cm^{-2})','FontSize',font_size)
ylabel('V_{p-p} (mV)','FontSize',font_size)
shg