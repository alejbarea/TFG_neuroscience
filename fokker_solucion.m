N_t = 6000;
N_v = 115;
T = 1.5;
P = ones(N_t+1,N_v+2);
V_rest = -65;
V_reset = V_rest;
V_th = 40;
A = V_reset - 20;
sigma_fok = 3;
C_M = 1;
mu = 800;
tau_M = 0.125;
R_M = tau_M/C_M;
F = @(V)  - (V- V_rest - R_M.*mu);
Fprima = @(V) -1;
V_mesh = linspace(A,V_th,N_v+2);
T_mesh = linspace(0,T,N_t+1);
delta_V = V_mesh(2) - V_mesh(1);
delta_T = T/(N_t+1);
sigma_gauss = 1;
sigma_initial = 5;
g = @(x) exp(-(x-V_reset).^2 / (2*sigma_gauss^2)) / (sigma_gauss * sqrt(2*pi));
P = ones(N_t+1,N_v+2);
P0 = @(x) exp(-(x-V_reset).^2 / (2*sigma_initial^2)) / (sigma_initial * sqrt(2*pi));
P(1,:) = P0(V_mesh);
P(:,1) = zeros(N_t+1,1);
P(:,N_v+2) = zeros(N_t+1,1);
V_internal_mesh = V_mesh(2:end);
FV = F(V_mesh);
FVprima = Fprima(V_mesh)*ones(1,N_v+2);
term_0 = (-FVprima/tau_M - (sigma_fok^2/(tau_M^2*delta_V^2)));
term_menos1 = FV/(2*tau_M*delta_V)+ (sigma_fok^2/(2*tau_M^2*delta_V^2));
term_1 = (sigma_fok^2/(2*tau_M^2*delta_V^2))-FV/(2*tau_M*delta_V);
G_eval = g(V_mesh);
Q = 1;
J = zeros(1,N_t+1);
for j=2:(N_t+1)
    for k =1:10
    for i=2:(N_v+1)
        if k == 1
        J(j) = (sigma_fok^2/(2.*(tau_M^2).*delta_V^2)).*(P(j-1,N_v+1));
        else
        J(j) = (sigma_fok^2/(2.*(tau_M^2).*delta_V^2)).*(P(j,N_v+1));
        end
        P(j,i) = P(j-1,i) + delta_T.*(term_0(i)*P(j-1,i)+term_1(i)*P(j-1,i+1)+term_menos1(i)*P(j-1,i-1)+J(j)*G_eval(i));
        
    end

    end
end

figure(1)
line_width = 2;
font_size = 20;
surf(V_mesh,T_mesh,P,'EdgeColor','none')
xlabel('V (a. u.)','FontSize',font_size)
ylabel('t (a. u.)','FontSize',font_size)
zlabel('P','FontSize',font_size)
shg
trapz(V_mesh,P(end,:))
figure(2)
plot(T_mesh,J,'LineWidth',line_width)
xlabel('t (a. u.)','FontSize',font_size)
ylabel('J (a. u.)','FontSize',font_size)
figure(3)
plot(V_mesh,P(end,:),'LineWidth',line_width)
xlim([-85, max(V_mesh)])
xlabel('V (a. u.)','FontSize',font_size)
ylabel('P','FontSize',font_size)