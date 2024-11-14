%%
x0=0; y1_0=2; y2_0=2;
syms x y1 y2 dx
dy1dx=-y1^2+y2;
dy2dx=y1-4*y2^2;
JAC=jacobian([dy1dx,dy2dx],[y1,y2]);
JAC_x0=subs(JAC,[x,y1,y2],[x0,y1_0,y2_0])
%% eigenvalue
eigenvalue=vpa(eig(JAC_x0))
%% step size based on stability
step_size=2/max(abs(eigenvalue))
%% Local truncation error
dy1dx_2=-2*y1*dy1dx+dy2dx;
dy2dx_2=dy1dx-8*y2*dy2dx;
LTE1=abs(dy1dx_2/2*dx^2);
LTE2=abs(dy2dx_2/2*dx^2);
LTE1_x0=subs(LTE1,[x,y1,y2,dx],[x0,y1_0,y2_0,0.1])
LTE2_x0=subs(LTE2,[x,y1,y2,dx],[x0,y1_0,y2_0,0.1])
%% find best step size
TOL=0.001;
step_size_1=sqrt(abs(2*TOL/dy1dx_2));
step_size_2=sqrt(abs(2*TOL/dy2dx_2));
step_size_1_x0=vpa(subs(step_size_1,[x,y1,y2],[x0,y1_0,y2_0]))
step_size_2_x0=vpa(subs(step_size_2,[x,y1,y2],[x0,y1_0,y2_0]))
