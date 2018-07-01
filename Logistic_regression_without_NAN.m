function [results,tag_test_without_NAN]=Logistic_regression_without_NAN(set_without_NAN,set_tags_without_NAN)

t_ = categorical(set_tags_without_NAN);


%for without_NAN 70,30:
train_without_NAN=[];
tag_train_without_NAN=[];
test_without_NAN=[];
tag_test_without_NAN=[];

idx = randperm(354);%generate random vector of size 354
for j=1:1:247%training
    train_without_NAN=[train_without_NAN; set_without_NAN(idx(j),:)];
    tag_train_without_NAN=[tag_train_without_NAN;t_(idx(j),:)];
           
end




for j=248:1:354% test
    test_without_NAN=[test_without_NAN; set_without_NAN(idx(j),:)];
    tag_test_without_NAN=[tag_test_without_NAN;t_(idx(j),:)];
        
        
end

 [B,dev] = mnrfit(train_without_NAN,tag_train_without_NAN);
 results = mnrval(B,test_without_NAN);
 sum=0;
for j=1:107
    if((results(j,1)>results(j,2))&&(tag_test_without_NAN(j,1)=='Demented'  ))
        sum=sum+1;
    elseif((results(j,2)>results(j,1))&&(tag_test_without_NAN(j,1)=='Nondemented'  ))
        sum=sum+1;
    end
end
tot_sum_data= sum;
answer=['Data without NANS: The Logistic_regression predicts right ',num2str(sum),' from test set of 107 samples' ];
disp(answer);
end