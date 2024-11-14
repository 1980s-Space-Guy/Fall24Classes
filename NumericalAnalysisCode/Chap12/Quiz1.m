% Requires weights.mat to be loaded
%% Part 1
white_avg=mean(white_eggs);
brown_avg=mean(brown_eggs);
disp(white_avg)
disp(brown_avg)

%% Part 2
white_std=std(white_eggs);
brown_std=std(brown_eggs);
disp(white_std)
disp(brown_std)

%% Part 3
[hypothesis,p_value]=ttest2(brown_eggs,white_eggs,'Alpha',0.005);
disp(hypothesis)
disp(p_value)