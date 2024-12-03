%% Average
dataset1_mean=mean(brown_eggs);
dataset2_mean=mean(white_eggs);

fprintf('Average for data set 1: %.3f\n',dataset1_mean)
fprintf('Average for data set 2: %.3f\n',dataset2_mean)

%% Standard Deviation
dataset1_std=std(brown_eggs);
dataset2_std=std(white_eggs);

fprintf('Standard Deviation for data set 1: %.3f\n',dataset1_std)
fprintf('standard Deviation for data set 2: %.3f\n',dataset2_std)

%% Double T tests
% Hypothesis values
% 0: No significance between the datasets
% 1: Significance between datasets
[hypothesis,p_value]=ttest2(brown_eggs,white_eggs,'Alpha',0.05);
disp(1-p_value)
disp(hypothesis)