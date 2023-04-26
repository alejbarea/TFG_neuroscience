mu = 3;
sigma = 0.5;
f1 = @(theta) (1 - cos(theta)) + (1 + cos(theta)).*mu;
g1 = @(theta) (1 + cos(theta)).*sigma;
theta_domain = [-pi, pi];
N_t = 1000;
N_v = 1000;
T = 2;

theta_mesh = linspace(-pi,pi,N_v+2);
t_mesh = linspace(0,T,N_t+1);

delta_t = t_mesh(2) - t_mesh(1);
delta_v = theta_mesh(2) - theta_mesh(1);
theta_internal_mesh = theta_mesh(2:end-1);
f1_eval = f1(theta_mesh);
g1sq_eval = g1(theta_mesh).^2;

term_0 = (1/delta_t + g1sq_eval./(delta_v^2));
term_1 = (f1_eval./(2*delta_v) - g1sq_eval./(2*delta_v^2));
term_menos1 = (-f1_eval./(2*delta_v) - g1sq_eval./(2*delta_v^2));

sigma_initial = 0.5;
P0 = @(x) exp(-(x).^2 / (2*sigma_initial^2)) / (sigma_initial * sqrt(2*pi));

P = zeros(N_t+1,N_v+2);
P(1,:) = P0(theta_mesh);

A = zeros(N_v+2,N_v+2);
A = diag(term_0,0) + diag(term_1(2:end),1) + diag(term_menos1(1:end-1),-1);
aux_1 = A(:,1);
A(:,1) = A(:,end);
A(:,end) = aux_1;
%A(1,end) = 0;
%A(end,1) = 0;
%invA = inv(A);

for j = 2:(N_t+1)
    b = (P(j-1,:)./delta_t)';
    P(j,:) = A\b;
end
font_size = 20;
figure(1)
surf(theta_mesh,t_mesh,P,'EdgeColor','none')
xlabel('V (a. u.)','FontSize',font_size)
ylabel('t (a. u.)','FontSize',font_size)
zlabel('P','FontSize',font_size)

trapz(theta_mesh,P(end,:))
shg
J = f1_eval(end).*P(:,end) - 0.5.*((g1sq_eval(end-1)*P(:,end-1) - g1sq_eval(2)*P(:,2) )/2.*delta_v);
figure(2)
line_width = 2;
plot(t_mesh,J,'LineWidth',line_width)
xlabel('t (a. u.)','FontSize',font_size)
ylabel('J (a. u.)','FontSize',font_size)