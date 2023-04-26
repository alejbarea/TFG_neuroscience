syms a b c v w I

eqn1 = v*(a - v)*(v - 1) - w + I == 0;
eqn2 = b*v - c*w == 0;

sol = solve([eqn1,eqn2],[v,w]);

jacob = jacobian([v*(a - v)*(v - 1) - w + I,b*v - c*w],[v,w]);


dI = 1e-3;
I_list = 0:dI:0.05;
for i = 1:length(I_list)

    I = I_list(i);
    a = 0.1;
    b = 0.01;
    c = 0.02;
    
    sols_v = subs(sol.v);
    sols_w = subs(sol.w);
    fixed_point_v = double(sols_v(1));
    fixed_point_w = double(sols_w(1));
    
    v = fixed_point_v;
    w = fixed_point_w;
    
    A = subs(jacob);
    autov = eig(A);
    autov_d = double(autov);
    if any(real(autov_d) >0)
        break
    end
end