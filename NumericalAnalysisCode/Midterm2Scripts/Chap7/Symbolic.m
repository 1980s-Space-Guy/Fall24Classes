% Clear Workspace
syms y(x)
Dy=diff(y,x,1);
D2y=diff(y,x,2);
D3y=diff(y,x,3);
f(x)=D3y+3.2*D2y+4.81*Dy;
y=dsolve(f==0,y(0)==3.4,Dy(0)==-4.6,D2y(0)==9.91);
disp(y)