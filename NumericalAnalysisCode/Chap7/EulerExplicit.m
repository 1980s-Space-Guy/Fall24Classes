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
    y1(i+1)=y1(i)+step*f1(x(i),y1(i),y2(i)); %#ok<SAGROW>
    y2(i+1)=y2(i)+step*f2(x(i),y1(i),y2(i)); %#ok<SAGROW>
end

disp(y1)
disp(y2)