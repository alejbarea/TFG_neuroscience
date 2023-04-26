
tspan = linspace(0,100,1e3);
y = zeros(4,length(tspan));
y0 = [-65;0.5;0.5;0.06];

I = 0:0.01:50;
f = ones(1,length(I));
for k = 1:length(I)
    [t,y] = hheuler(I(k));
    over_th = 0;
    count = 0;
    contado = 0;
    tsegundo = 0;
    tprimero = 0;
    aux = y;
    for i = 1:length(y)
        if (aux(i) > 0) && over_th == 0
            count = count + 1;
            over_th = 1;
            t(i)
        end
        if (aux(i) < 0) && over_th == 1
            over_th = 0;
        end
        if count == 1 && contado == 0
            tprimero = t(i);
            contado = 1;
        end
        if count == 2
            tsegundo = t(i);
            break;
        end
    end
    if tsegundo == 0
        f(k) = 0;
    else
        f(k) = (1/(tsegundo - tprimero))*1000;
    end
    
end

line_width = 2;
font_size = 30;
plot(I,f,'LineWidth',line_width);
grid on



%xlabel('I (\muA \cdot cm^{-2})','FontSize',font_size)
%ylabel('f (Hz)','FontSize',font_size)

