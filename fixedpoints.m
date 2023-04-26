data = neuronaldata();
% Nernst Potentials

% Conductances

% Steady-State of the w and m gates
w_inf = data.steady_states.n_inf;
m_inf = data.steady_states.m_inf;
% Time constant of the w-gate
tau_w = data.time_constants.tau_n;
% Other parameters
E_K = -77;
E_Na = 60;
E_L = -80;
g_L = 8;
g_Na = 20;
g_K = 10;
c_M = 1;
global c_M g_K g_Na g_L E_K E_Na E_L w_inf m_inf

f = @(y) [I - g_L.*(y(1) - E_L) -g_Na.*m_inf(y(1)).*(y(1) - E_Na) - g_K.*y(2).*(y(1) - E_K),(w_inf(y(1)) - y(2))./tau_w(y(1))];

syms V w
I_list = 0:0.01:10;

jacob = jacobian([(I - g_L*(V - E_L) -g_Na*m_inf(V)*(V - E_Na) - g_K*w*(V - E_K))/c_M, (w_inf(V) - w)/tau_w(V)],[V,w]);
jacob_f = matlabFunction(jacob);
numero_I = length(I_list);
hold on
for i = 1:numero_I
    fixed_points = fixed_points_calc(I_list(i));
    fixed_points_w = w_inf(fixed_points);
    dif_elements = sum(sum(fixed_points==fixed_points'));
    if dif_elements == 1
        V = fixed_points(1);
        w = fixed_points_w(1);
        eigenvalues = eig(jacob_f(V,w));
        s = stability_point(eigenvalues);
            if s == 0
                plot(I_list(i),V,'ro','MarkerFaceColor','r')
            else
                plot(I_list(i),V,'ko','MarkerFaceColor','k')
            end
    else
        for j = 1:3
            V = fixed_points(j);
            w = fixed_points_w(j);
            eigenvalues = eig(jacob_f(V,w));
            s = stability_point(eigenvalues);
            if s == 0
                plot(I_list(i),V,'ro','MarkerFaceColor','r')
            else
                plot(I_list(i),V,'ko','MarkerFaceColor','k')
            end
        end
    end
end

function [fixed_points] = fixed_points_calc(I)
global c_M g_K g_Na g_L E_K E_Na E_L w_inf m_inf
    f = @(y) I - g_L.*(y - E_L) -g_Na.*m_inf(y).*(y - E_Na) - g_K.*w_inf(y).*(y - E_K);
    p1 = fzero(f,-65);
    p2 = fzero(f,-50);
    p3 = fzero(f,-24);
    fixed_points = [p1,p2,p3];
end

function s = stability_point(eigenvalues)
    eigenvalues = real(eigenvalues);
    if any(eigenvalues > 0)
        s = 0;
    else
        s = 1;
    end
end




