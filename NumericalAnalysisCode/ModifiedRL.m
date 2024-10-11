function val=fzerox1(x1)
    y1=0.6;
    y2=1-y1;
    T=318.15; % K
    P1sat=exp(16.59158-3643.31/(T-33.424)); %kPa
    P2sat=exp(14.25326-2665.54/(T-53.424)); %kPa
    A=2.771-0.00523*T;
    AC1=exp(A*(1-x1)^2);
    AC2=exp(A*x1^2);
    val=1/(y1/AC1/P1sat+y2/AC2/P2sat)-x1*AC1*P1sat-(1-x1)*AC2*P2sat;
end

options=optimset('Display','off');
x1sol=fzero(@fzerox1,0.6,options);
disp(x1sol)