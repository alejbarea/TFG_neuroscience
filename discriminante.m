syms a b c I

discriminant = 18*(a+1)*(a+b/c)*I-4*((a+1)^3)*I+((a+1)^2)*((a+b/c)^2)-4*((a+b/c)^3)-27*I^2 == 0;
 
sol = solve(discriminant,I);

a = 0.1;
b = 0.01;
c = 0.1;
double(subs(sol))

