a = 0.1;
b = 0.01;
c = 0.1;
I = 0;
nulcline1 = @(V) V.*(a - V).*(V - 1) + I;
nulcline2 = @(V) (b/c)*V;

hold on
x = linspace(-0.4,1);

plot(x,nulcline1(x))

plot(x,nulcline2(x))

