max_M=max(max(M));

min_M=min(min(M));

below_50=0;
new_M=zeros(size(M));
for i=1:size(M,1)
    for j=1:size(M,2)
        if M(i,j) < 50
            below_50 = below_50 + 1;
        end
        new_M(i,j)=(M(i,j)-min_M)/(max_M-min_M);
    end
end
disp(below_50)

