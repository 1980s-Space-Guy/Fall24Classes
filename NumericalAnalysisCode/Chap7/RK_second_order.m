f1=@(x,y1,y2) y1-2*y2;
f2=@(x,y1,y2) 2*y1-4*y2;

x(1)=0;
y1(1)=0;
y2(1)=1;

n=1;
xf=0.5;
step=(xf-x(1))/n;

for i=1:n
    x(i+1)=x(i)+step; %#ok<SAGROW>
    k11=step*f1(x(i),y1(i),y2(i));
    k21=step*f2(x(i),y1(i),y2(i));

    k12=step*f1(x(i)+1/2*step,y1(i)+1/2*k11,y2(i)+1/2*k21);
    k22=step*f2(x(i)+1/2*step,y1(i)+1/2*k11,y2(i)+1/2*k21);

    y1(i+1)=y1(i)+k12; %#ok<SAGROW>
    y2(i+1)=y2(i)+k22; %#ok<SAGROW>
end

disp(y1)
disp(y2)