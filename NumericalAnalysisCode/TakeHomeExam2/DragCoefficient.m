function Cd = DragCoefficient(Re,v)
    if Re<10e-4
        Cd=240000;
    elseif Re<0.2
        Cd=24/Re;
    elseif Re<1000
        Cd=24/Re*(1+0.14*Re^0.7);
    elseif Re<2000
        Cd=21.12/Re+6.3/sqrt(Re)+0.25;
    else
        Ma=v/343;
        Cd0=21.12/Re+6.3/sqrt(Re)+0.25;
        Cd=Cd0*((1-0.445*Ma+4.84*Ma^2-9.73*Ma^3+6.93*Ma^4)/sqrt(1+1.2*Ma*Cd0));
    end
end

