[A,B] = textread('F:\2\land_classify_train/train.txt','%s %s');
A=[A,B];
A=sortrows(A,1);
B=A(:,2);
a=str2num(char(B));
load('F:\2\hist\ucm_msd_H_1000.mat')

B=1:50020;
B=B.';
svm=[a  H_all B];
[c b]=size(svm);
[y,i]=sortrows(svm,1);
% y(randperm(273, 10),:);%在y矩阵273行中随机选取10行
accuracy2=[];
for k=1:1
accuracy1=[];
for j=1:1
for i=0:50
F = find(y(:,1)==i);
R = y(F,:);
[m,n]=size(F);
a=ceil(m*(0.8*k));
idx=randperm(m);
idx=idx(1:a);
A=R(idx,:);
B=R;
B(idx,:)=[];

if i==0
C=[A];
D=[B];
else
    C=[C;A];%训练数据拼接  
    D=[D;B];%测试数据拼接
end
end
 [m1 n1]=size(C)
    C1=C(1:m1,1);
    C2=C(1:m1,b);
    C3=[C1,C2];%训练数据标签和ID
 [m2 n2]=size(D)
    D1=D(1:m2,1);
    D2=D(1:m2,b);
    D3=[D1,D2];%测试数据标签和ID

    training_data=C(1:m1,2:b-1);
    testing_data=D(1:m2,2:b-1);


sum_acc=0;
training_real_label=C(1:m1,1);
testing_real_label=D(1:m2,1);
train=double(training_data);
 test=double(testing_data);
    [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);
%       [bestacc,bestc,bestg] = SVMcgForClass(training_real_label, train_scale,0,2,-1,2,10,0.5,1,0.3);
     bestc = 4;
      bestg = 0.5;
    cmd = [' -t ',num2str(bestg),' -c ',num2str(bestc)];
    model = svmtrain(training_real_label, train_scale,cmd);
    [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');
    test_result=predicted_label';
      confusion_matrix(testing_real_label,predicted_label);
    
%     sum_acc = sum_acc + accuracy(1);
    fprintf('%f\n',accuracy(1));
    accuracy1=[accuracy1,accuracy];
end
accuracy2=[accuracy2;accuracy1];
end
