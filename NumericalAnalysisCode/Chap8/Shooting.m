
guesses=linspace(-10,10,200);
for i=1:length(guesses)
    [x,y]=ode45(@hahaha,[0,1],[0,guesses(i)]);
    other_BC(i)=y(end,1); %#ok<SAGROW>
end
plot(guesses,other_BC)

function ode_to_solve=hahaha(~,y)
    %y(1) is y, y(2) is y'
    ode_to_solve(1,1)=y(2);
    ode_to_solve(2,1)=5*y(1);
  
end