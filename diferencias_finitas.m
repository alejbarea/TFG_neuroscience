N = 1000;
V_rest = -65;
V_reset = V_rest;
V_th = 40;
A = V_reset - 20;
sigma_fok = 3;
Q = 1.5933;
mu = 800;
C_M = 1;
tau_M = 0.125;
R_M = tau_M./C_M;
F = @(V)  - (V- V_rest - R_M*mu);
Fprima = @(V) -1;
V_mesh = linspace(A, V_th,N+2);
h = V_mesh(2) - V_mesh(1);
h2 = h^2;
V_internal_mesh = V_mesh(2:(N+1));
FprimaV = Fprima(V_internal_mesh).*ones(1,N);
FV = F(V_internal_mesh);
term_0 = (-FprimaV/tau_M - (sigma_fok^2/(tau_M^2*h^2)));
term_1 = FV/(2*tau_M*h)+ (sigma_fok^2/(2*tau_M^2*h^2));
term_menos1 = (sigma_fok^2/(2*tau_M^2*h^2))-FV/(2*tau_M*h);
sigma_gauss = 1;
g = @(x) exp(-(x-V_reset).^2 / (2*sigma_gauss^2)) / (sigma_gauss * sqrt(2*pi));
sol = ones(1,N+2);
sol(1) = 0;
sol(N+2) = 0;

finite_diff_matrix = ones(N,N);
finite_diff_matrix = diag(term_0, 0) + diag(term_1(2:end),-1) + diag(term_menos1(1:end-1),1);
b = -(Q.*g(V_internal_mesh))';
sol(2:N+1) = finite_diff_matrix \ b;
Q = Q./trapz(V_mesh,sol);
plot(V_mesh,sol,'LineWidth',line_width)
xlim([-80 max(V_mesh)])
ylim([-0.005 0.045])

xlabel('V (a. u.)','FontSize',font_size)
ylabel('P','FontSize',font_size)
hold on






