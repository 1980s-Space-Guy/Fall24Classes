function FinalTakeHome
    function [TCR,cat_soln,diff_soln]=Q12(ro)
        %% Quesiton 1 main code
        % Constants
        ri=0.5; k=1; Dc=0.1; Dd=0.5;
        % Radius span inside the catalyst
        cat_r_span=[0,ri];
        % Radius span in diffusion layer
        diff_r_span=[ri,ro];
    
        function ode=ODE_catalyst(r,C)
            % C(1) is C, C(2) is dC/dr
            ode(1,1)=C(2);
            ode(2,1)=k*C(1)^2/Dc-C(2)/(r+eps)/Dc;
        end
    
        function ode=ODE_diffusion(r,C)
            % C(1) is C, C(2) is dC/dr
            ode(1,1)=C(2);
            ode(2,1)=-C(2)/(r+eps)/Dd;
        end
    
        function error=shoot_the_catalyst(C_guess)
            % Initial guess for C and C'
            cat_C_init=[C_guess,0];
            % Solving first ODE
            soln1=ode45(@ODE_catalyst,cat_r_span,cat_C_init);
    
            % Initial guess for C and C'
            % The concentration and the change in concentration
            % with respect to r is the same at ri
            diff_C_init=[deval(soln1,ri,1),deval(soln1,ri,2)];
            % Solving second ODE
            soln2=ode45(@ODE_diffusion,diff_r_span,diff_C_init);
    
            % finding difference between the actual reactant
            % concentration at r=ro (1) and its estimated value
            % with the given guess
            error=deval(soln2,ro,1)-1;
        end
    
        % Graphing the error with given guesses
        % CC=linspace(0,1,100);
        % for i=1:length(CC)
        %     error(i)=shoot_the_catalyst(CC(i)); %#ok<AGROW>
        % end
        % plot(CC,error)
        % Actual initial starting concentration appears to be
        % between 0.7 and 0.9
    
        % Finding concentration at r=0
        options=optimset('Display','off');
        Cr0=fzero(@shoot_the_catalyst,[0.7,0.9],options);
    
        % Solving ode from r=0 to r=ri
        % Initial condition at r=0
        C0=[Cr0,0];
        cat_soln=ode45(@ODE_catalyst,cat_r_span,C0);
    
        % Solving ode from r=ri to r=ro
        % Initial Condition at r=ri
        % (same as endpoints from prev sol)
        Cri=[deval(cat_soln,ri,1),deval(cat_soln,ri,2)];
        diff_soln=ode45(@ODE_diffusion,diff_r_span,Cri);
    
        %% Question 2 main code
        % to integrate, we will be using the trapz function
        % with a very small step size to get close enough
        % to the actual integral such that there is very
        % little error
    
        l=1;
        % creating a large list from r=0 to r=ri (inside cat)
        % and from r=ri to r=ro (diffusion layer)
        cat_rr=linspace(0,ri,1000);
        diff_rr=linspace(ri,ro,1000);
        % getting the concentrations at those r values
        cat_CC=deval(cat_soln,cat_rr,1);
        diff_CC=deval(diff_soln,diff_rr,1);
        % creating a list of the terms inside the integral
        % r*C^2
        cat_int_term=cat_rr.*cat_CC.^2;
        diff_int_term=diff_rr.*diff_CC.^2;
        % getting total conversion rate by adding the two
        % integrals together
        TCR=2*pi*k*l*(trapz(cat_rr,cat_int_term)+...
            trapz(diff_rr,diff_int_term));
    end

    %% Question 1 and 2 output
    ri=0.5; ro=1;
    [TCR,cat_soln,diff_soln]=Q12(ro);
    % Graphing Solution for Question 1
    r_cat=linspace(0,ri,100);
    C_cat=deval(cat_soln,r_cat,1);
    r_diff=linspace(ri,ro,100);
    C_diff=deval(diff_soln,r_diff,1);
    plot(r_cat,C_cat); hold on;
    plot(r_diff,C_diff);
    title('Concentration vs, Radius')
    xlabel('radius')
    ylabel('Concentration')
    % Outputing Solution for question 2
    fprintf('Total Conversion Rate: %0.5f\n\n',TCR)

    %% Question 3
    % this function finds the difference between the total
    % conversion rate at the given guess of ro and the goal
    % conversion rate (3)
    function error=TCR_residual(ro_guess)
        [TCR_new_ro,~,~]=Q12(ro_guess);
        error=TCR_new_ro-3;
    end

    % Plotting different values of ro to get a guess for fzero
    % ro_guesses=linspace(0.7,2,15);
    % for j=1:length(ro_guesses)
    %     TCR_error(j)=TCR_residual(ro_guesses(j)); %#ok<AGROW>
    % end
    % plot(ro_guesses,TCR_error)
    % Answer appears to be arounf 0.9 to 1.1
    options=optimset('Display','off');
    ro_for_TCR_of3=fzero(@TCR_residual,[0.9,1.1],options);
    fprintf('ro value to get a total conversion rate of 3: %1.5f\n\n',...
            ro_for_TCR_of3)
end