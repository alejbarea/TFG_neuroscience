
tspan = linspace(0,200,1e4);
y = zeros(4,length(tspan));

y0 = [-65;0.05;0.32;0.6];

I = 10;
hold on
grid on
line_width = 2;
font_size = 20;

[t,V,m,n,h] = hheuler(I);

figure(1)
hold on
subplot(2,2,1)
hold on
plot(t,V,'LineWidth',line_width)
grid on
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
plot([50 50],[-100 50],'r--')
plot([150 150],[-100 50],'r--')
plot([0 200], [50 50],'g--')
plot([0 200], [-77 -77],'g--')
subplot(2,2,2)
plot(t,m,'LineWidth',line_width)
grid on
hold on
plot([50 50],[0 1],'r--')
plot([150 150],[0 1],'r--')
xlabel('t (ms)','FontSize',font_size)
ylabel('m','FontSize',font_size)
subplot(2,2,3)
hold on
plot(t,n,'LineWidth',line_width)
plot([50 50],[0 1],'r--')
plot([150 150],[0 1],'r--')
grid on
xlabel('t (ms)','FontSize',font_size)
ylabel('n','FontSize',font_size)
subplot(2,2,4)
hold on
plot(t,h,'LineWidth',line_width)
grid on
xlabel('t (ms)','FontSize',font_size)
ylabel('h','FontSize',font_size)
plot([50 50],[0 1],'r--')
plot([150 150],[0 1],'r--')
hold off
figure(2)
hold on
plot(V,h,'LineWidth',line_width)
plot(y0(1),y0(4),'ro','MarkerSize',10,'MarkerFaceColor','r')
ylabel('m','FontSize',font_size)
xlabel('V (mV)','FontSize',font_size)
hold off