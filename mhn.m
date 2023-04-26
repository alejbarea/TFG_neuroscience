alpha_n = @(V) 0.01.*((V + 55)./(1 - exp(-(V + 55)/10)));
beta_n = @(V) 0.125.*exp(-(V + 65)/80);
alpha_m = @(V) 0.1.*((V + 40)./(1 - exp(-(V + 40)/10)));
beta_m = @(V) 4.*exp(-(V + 65)./18);
alpha_h = @(V) 0.07.*exp(-(V + 65)/20);
beta_h = @(V) 1./(1 + exp(-(V+35)/10));

m_inf = @(V) alpha_m(V)./(alpha_m(V) + beta_m(V));
n_inf = @(V) alpha_n(V)./(alpha_n(V) + beta_n(V));
h_inf = @(V) alpha_h(V)./(alpha_h(V) + beta_h(V));

tau_m = @(V) 1./(alpha_m(V) + beta_m(V));
tau_n = @(V) 1./(alpha_n(V) + beta_n(V));
tau_h = @(V) 1./(alpha_h(V) + beta_h(V));

V = linspace(-100,40);

figure(1)
subplot(1,2,1)
hold on
grid on
line_width = 2;
font_size = 30;
plot(V,m_inf(V),'LineWidth',line_width,'Color','r')
plot(V,n_inf(V),'LineWidth',line_width,'Color','b')
plot(V,h_inf(V),'LineWidth',line_width,'Color','g')
legend({'m','n','h'},'Location','best','FontSize',font_size)
xlabel('V (mV)','FontSize',font_size)
ylabel('Probabilities','FontSize',font_size)
hold off


subplot(1,2,2)
hold on
grid on
plot(V,tau_m(V),'LineWidth',line_width,'Color','r')
plot(V,tau_n(V),'LineWidth',line_width,'Color','b')
plot(V,tau_h(V),'LineWidth',line_width,'Color','g')
legend({'m','n','h'},'Location','best','FontSize',font_size)
xlabel('V (mV)','FontSize',font_size)
ylabel('\tau (ms)','FontSize',font_size)

hold off