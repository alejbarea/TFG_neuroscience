syms V(t) I I1 V1 a b
ode = diff(V,t) == a*(I - I1) + b*(V - V1)^2;
ySol(t) = dsolve(ode);