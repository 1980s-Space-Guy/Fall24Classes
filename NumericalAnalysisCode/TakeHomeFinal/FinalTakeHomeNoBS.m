function [TCR,cat_soln,diff_soln]=Q12(ro)
    ri=0.5; 
    k=1; 
    Dc=0.1; 
    Dd=0.5; 
    cat_r_span=[0,ri]; 
    diff_r_span=[ri,ro];
    function ode=ODE_catalyst(r,C)
        ode(1,1)=C(2);
        ode(2,1)=k*C(1)^2/Dc-C(2)/(r+eps)/Dc;
    end
    function ode=ODE_diffusion(r,C)
        ode(1,1)=C(2);
        ode(2,1)=-C(2)/(r+eps)/Dd;
    end
    function error=shoot_the_catalyst(C_guess)
        cat_C_init=[C_guess,0];
        soln1=ode45(@ODE_catalyst,cat_r_span,cat_C_init);
        diff_C_init=[deval(soln1,ri,1),deval(soln1,ri,2)];
        soln2=ode45(@ODE_diffusion,diff_r_span,diff_C_init);
        error=deval(soln2,ro,1)-1;
    end
    options=optimset('Display','off');
    Cr0=fzero(@shoot_the_catalyst,[0.7,0.9],options);
    C0=[Cr0,0];
    cat_soln=ode45(@ODE_catalyst,cat_r_span,C0);
    Cri=[deval(cat_soln,ri,1),deval(cat_soln,ri,2)];
    diff_soln=ode45(@ODE_diffusion,diff_r_span,Cri);
    l=1;
    cat_rr=linspace(0,ri,1000);
    diff_rr=linspace(ri,ro,1000);
    cat_CC=deval(cat_soln,cat_rr,1);
    diff_CC=deval(diff_soln,diff_rr,1);
    cat_int_term=cat_rr.*cat_CC.^2;
    diff_int_term=diff_rr.*diff_CC.^2;
    TCR=2*pi*k*l*(trapz(cat_rr,cat_int_term)+trapz(diff_rr,diff_int_term));
end
ri=0.5;
ro=1;
[TCR,cat_soln,diff_soln]=Q12(ro);
r_cat=linspace(0,ri,100);
C_cat=deval(cat_soln,r_cat,1);
r_diff=linspace(ri,ro,100);
C_diff=deval(diff_soln,r_diff,1);
plot(r_cat,C_cat);
hold on;
plot(r_diff,C_diff);
title('Concentration vs, Radius')
xlabel('radius')
ylabel('Concentration')
fprintf('Total Conversion Rate: %0.5f\n\n',TCR)
function error=TCR_residual(ro_guess)
    [TCR_new_ro,~,~]=Q12(ro_guess);
    error=TCR_new_ro-3;
end
options=optimset('Display','off');
ro_for_TCR_of3=fzero(@TCR_residual,[0.9,1.1],options);
fprintf('ro value to get a total conversion rate of 3: %1.5f\n\n',ro_for_TCR_of3)