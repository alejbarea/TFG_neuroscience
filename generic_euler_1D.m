function [t,V] = generic_euler_1D(tspan,V0,N,f,Vth,Vres)
    
    % Initialization
    N1 = N+1;
    t = linspace(tspan(1),tspan(2),N1);
    h = t(2)-t(1);
    V = ones(1,N1);
    V(1) = V0;
    
    % Iteration

    for k = 1:N
        Vk = V(k);
        tk = t(k);
        if Vk < Vth
           V(k+1) = Vk + h*f(tk,Vk);
        else
            V(k+1) = Vres;
        end
        
    end
end