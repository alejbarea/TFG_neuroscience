a = 0.1;
b = 0.01;
c = 0.1;
I = 0.010031498535578;
N = 1e5;
tspan = [0 1000];
tstart = 0;
duration =1000;
pulse_data = struct('intensity',{I},'tstart',{tstart},'duration',{duration});
v0 = 0.2;
w0 = 0.1;
[t, v,w] = FitzHughEuler(a,b,c,pulse_data,N,v0,w0,tspan);

line_width = 2;
font_size = 20;
marker_size = 8;
figure(1)
hold on
plot(t,v,'LineWidth',line_width)
xlabel('t (ms)','FontSize',font_size)
ylabel('V (mV)','FontSize',font_size)
grid on
hold off
figure(2)
hold on


nulcline_v = @(v) v.*(a - v).*(v - 1) + I;
nulcline_w = @(v) (b/c)*v;


f = @(t,y) [y(1)*(a - y(1))*(y(1) - 1) - y(2) + I, b*y(1) - c*y(2)];
nflechas = 30;
xspan = [-0.4 1];
yspan = [-0.5 0.5];
x = linspace(xspan(1),xspan(2),nflechas);
y = linspace(yspan(1),yspan(2),nflechas);
xaux = linspace(xspan(1),xspan(2),1e4);
yaux = linspace(yspan(1),yspan(2),1e4);
plot(xaux,nulcline_w(xaux),'LineWidth',line_width)
plot(xaux,nulcline_v(xaux),'LineWidth',line_width)
[x, y] = meshgrid(x,y);
plot(v,w,'LineWidth',line_width)
plot(0,0,'ro','MarkerSize',marker_size,'MarkerFaceColor','r')
plot(0.23,0.023,'go','MarkerSize',marker_size,'MarkerFaceColor','g')
plot(0.87,0.087,'ro','MarkerSize',marker_size,'MarkerFaceColor','r')
xlabel('V (mV)','FontSize',font_size)
ylabel('w','FontSize',font_size)
legend({'w nullcline','V nullcline','Stable Equilibrium 1','Unstable Equilibrium','Stable Equilibrium 2'},'Location','best','FontSize',font_size)
u = zeros(size(x));
v = zeros(size(y));
scale = 1.4;
taux = 0;
for i = 1:numel(x)
    yprima = f(taux,[x(i);y(i)]);
    u(i) = yprima(1);
    v(i) = yprima(2);
end

quiver(x,y,u,v,scale,'filled')
xlim(xspan)
ylim(yspan)

