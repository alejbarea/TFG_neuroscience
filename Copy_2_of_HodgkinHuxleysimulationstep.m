
tspan = linspace(0,200,1e4);
y = zeros(4,length(tspan));

y0 = [-65;0.05;0.32;0.6];

I = 10;
hold on
grid on
line_width = 2;
font_size = 20;
hold on
[t,V,m,n,h] = hheuler(I(i));

hold on
plot(h,n,'ro','MarkerFaceColor','r','MarkerSize',1)
grid on

ajuste = polyfitn(h,n,1);
f_ajuste = @(t) polyval(ajuste.Coefficients,t);

a = - 1./ajuste.Coefficients(1);
b = a.*ajuste.Coefficients(2);
plot(h,f_ajuste(h),'k','LineWidth',line_width)
xlabel('h','FontSize',font_size)
ylabel('n','FontSize',font_size)
hold off