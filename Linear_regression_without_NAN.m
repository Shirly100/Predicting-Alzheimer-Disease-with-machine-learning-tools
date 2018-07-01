function [results,tag_test_without_NAN]=Linear_regression_without_NAN(set_without_NAN,set_tags_without_NAN)

t=zeros(354,1);
for i=1:354%making the tags matrix
    if(strcmp(set_tags_without_NAN(i,1) ,'Demented'))
       
        t(i,1)=1;
    elseif(strcmp(set_tags_without_NAN(i,1) ,'Nondemented'))
        t(i,1)=2;
         
        
    end
end




 

%for without_NAN 70,30:
train_without_NAN=[];
tag_train_without_NAN=[];
test_without_NAN=[];
tag_test_without_NAN=[];

idx = randperm(354);%generate random vector of size 354
for j=1:1:247%training
    train_without_NAN=[train_without_NAN; set_without_NAN(idx(j),:)];
    tag_train_without_NAN=[tag_train_without_NAN;t(idx(j),:)];
           
end




for j=248:1:354% test
    test_without_NAN=[test_without_NAN; set_without_NAN(idx(j),:)];
    tag_test_without_NAN=[tag_test_without_NAN;t(idx(j),:)];
        
        
end

dsa = dataset(train_without_NAN(1:247,1), train_without_NAN(1:247,2) ,train_without_NAN(1:247,3),train_without_NAN(1:247,4),train_without_NAN(1:247,5),train_without_NAN(1:247,6) ,train_without_NAN(1:247,7) ,train_without_NAN(1:247,8) ,train_without_NAN(1:247,9),train_without_NAN(1:247,10),tag_train_without_NAN,'VarNames',{'MR Delay','Age','EDUC','SES','MMSE','CDR','eTIV','nWBV','ASF','M/F','group'});%create a database
lm = fitlm(dsa);
results=predict(lm,test_without_NAN(:,1:10));
sum=0;
for j=1:107
    if(round(results(j,1))==tag_test_without_NAN(j,1))
        sum=sum+1;
    end
end

answer=['Data without NANS: The Linear_regression predicts right ',num2str(sum),' from test set of 107 samples' ];
disp(answer);


tot_sum_without_NAN=sum;
end