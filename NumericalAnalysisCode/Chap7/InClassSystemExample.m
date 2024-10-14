%% some stuff
w='hi';
function [f1,f2]=f(x, y1, y2)
    f1=y1-2*y2;
    if x<1
        f2=2*y1-4*y2;
    else
        f2=y1-4*y2;
    end
end
