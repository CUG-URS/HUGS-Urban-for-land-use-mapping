clear;
clc;

data='E:\experiment\shenzhen\fstm\spestr_siftstr_ocr-0.3\info';
data_dir='E:\experiment\shenzhen\fstm\spestr_siftstr_ocr-0.3\spesfstm_siftsfstm_ocrfstm';
file_num=100;
result=[];
test0=zeros(100,2);
kappaall=[];
sumnum=0;
sumerror=0;
sumallarea=0;
sumallwrong=0;
result_final=[];
errorall=zeros(6366,12);
class=12;
seg=[1;1;1;1;1;1;1;1;1;1;1;1];
confusion0all=[];
confusion1all=[];
sumarea=zeros(class);
kappaal=[];
for i=1:file_num
    i
    train=sprintf('train_word_image_matrix-%d.mat',i);
    test=sprintf('test_word_image_matrix-%d.mat',i);
    
    train_all_path=sprintf('%s\\train_other-%d.mat',data,i);
    test_all_path=sprintf('%s\\test_other-%d.mat',data,i);
    
    train_all=load(train_all_path);
    test_all=load(test_all_path);
    train_all=cell2mat(struct2cell(train_all));
    test_all=cell2mat(struct2cell(test_all));
    
    train_path=fullfile(data_dir,'\',train);
    test_path=fullfile(data_dir,'\',test);
    
    training_data=load(train_path);
    testing_data=load(test_path);
    training_data=cell2mat(struct2cell(training_data));
    testing_data=cell2mat(struct2cell(testing_data));
%     training_data=training_data;
%     testing_data=testing_data;
    
%     addpath('E:\Matlab2019a\toolbox\libsvm-3.23\matlab');
    train=double(training_data);
    test=double(testing_data);

    row_train=size(train_all,1);
%     train_all(train_all==8)=7;
    row_test=size(test_all,1);
%     test_all(test_all==8)=7;
%     training_real_label=zeros(row_train,1);
%     testing_real_label=zeros(row_test,1);
    
    training_real_label=train_all(:,1);
    training_real_label=double(training_real_label);
    training_data_label=[training_data training_real_label];

    %为测试数据附上真实类别编号
    testing_real_label=test_all(:,1);  
    testing_real_label=double(testing_real_label);
    testing_data_label=[testing_data testing_real_label];%转置


    [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);
    bestc = 4;
    bestg = 0.5;
    cmd = [' -t ',num2str(bestg),' -c ',num2str(bestc)];
    model = svmtrain(training_real_label, train_scale,cmd);
    [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');


    test_result=predicted_label';
    save('testclass_result.mat','test_result');

    A(:,1)=test_all(:,3);
    A(:,2)=test_all(:,1);
    A(:,3)=test_result';
    A(:,4)=test_all(:,2);
    sum=0;
    sumarea_wrong=0;
    sumarea_all=0;
    for k=1:row_test
        sumarea_all=sumarea_all+A(k,4);
        if(A(k,2)~=A(k,3))
            sumarea_wrong=sumarea_wrong+A(k,4);
            sum=sum+1;
        end
    end
    avenum=sum;
    aveerror=sumarea_wrong/sumarea_all;
    
    B=zeros(row_train,4);
    B(:,1)=train_all(:,3);
    B(:,2)=train_all(:,1);
    B(:,3)=train_all(:,1);
    B(:,4)=train_all(:,2);

    R=[A;B];
    R=sortrows(R,1);
    R(1,5)=avenum;
    R(2,5)=sumarea_wrong;
    R(3,5)=sumarea_all;
    R(4,5)=aveerror;
    R(5,5)=i;
    result_final=[result_final;R(:,5)'];
    result=[result,R];
    sumnum=sumnum+sum;
    sumallwrong=sumarea_wrong+sumallwrong;
    sumallarea=sumallarea+sumarea_all;
    
    row=size(A,1);
    confusion0=zeros(class,class);
    confusion1=zeros(class,class);
    for k=1:row
        label=A(k,2);
        for q=1:class
            if(label==q)
                sumarea(1,label)=sumarea(1,label)+A(k,4);
            end
            label0=A(k,3);
            if(label0==q)
                confusion0(label,label0)=confusion0(label,label0)+1;
                confusion1(label,label0)=confusion1(label,label0)+A(k,4);
            end
        end
    end
    kappa_num=KAPPA(confusion0);
    kappa_area=KAPPA(confusion1);
    kappaall=[kappaall; kappa_num,kappa_area];
    seg(1,1)=avenum;
    confusion0all=[confusion0all,seg,confusion0];
    confusion1all=[confusion1all,seg,confusion1];
end
for i=1:class
    confusion1(i,:)=confusion1(i,:)/sumarea(i);
end
% kappaall=sortrows(kappaall,1,'descend');
% knum1=kappaall(1:50,1);
% karea1=kappaall(1:50,2);
% kave_num1=(sum(knum1))/50;
% kave_area1=sum(karea1)/50;
% kappaall=sortrows(kappaall,2,'descend');
% knum2=kappaall(1:50,1);
% karea2=kappaall(1:50,2);
% kave_num2=sum(knum2)/50;
% kave_area2=sum(karea2)/50;
% knumall=kappaall(1:100,1);
% kareaall=kappaall(1:100,2);
% kave_numall=sum(knumall)/100;
% kave_areaall=sum(kareaall)/100;
% test0=sortrows(test0,1);
avenum=sumnum/file_num;
aveerror=sumallwrong/sumallarea;
% result_final=sortrows(result_final,1);
% num1=result_final(1:50,1);
% area1=result_final(1:50,4);
% ave_num1=(sum(num1))/50;
% ave_area1=sum(area1)/50;
% result_final=sortrows(result_final,4);
% num2=result_final(1:50,1);
% area2=result_final(1:50,4);
% ave_num2=sum(num2)/50;
% ave_area2=sum(area2)/50;
% numall=result_final(1:100,1);
% areaall=result_final(1:100,4);
% ave_numall=sum(numall)/100;
% ave_areaall=sum(areaall)/100;

function [result] = KAPPA(confusion)
row=size(confusion,1);
sumreal=0;
sumkappa=0;
sumall=0;
for i=1:row
    sumrowi=sum(confusion(:,i));
    sumcoli=sum(confusion(i,:));
    sumall=sumall+sumrowi;
    sumrowcol=sumrowi*sumcoli;
    sumkappa=sumkappa+sumrowcol;
    sumreal=sumreal+confusion(i,i);
end
Po=sumreal/sumall;
Pe=sumkappa/(sumall*sumall);
result=(Po-Pe)/(1-Pe);
end
    

% 
% data='E:\experiment\shenzhen\fstm\spestr_siftstr_ocr-0.3\\info';
% data_dir='E:\experiment\shenzhen\fstm\spestr_siftstr_ocr-0.3\sift\topic';
% result=[];
% result_final=[];
% sumnum=0;
% sumallarea=0;
% sumallwrong=0;
% for i=250:10:550
%     i
%     train=sprintf('train_word_image_matrix-%d.mat',i);
%     test=sprintf('test_word_image_matrix-%d.mat',i);
%     
%     train_all_path=sprintf('%s\\train_other-1.mat',data);
%     test_all_path=sprintf('%s\\test_other-1.mat',data);
%     
%     train_all=load(train_all_path);
%     test_all=load(test_all_path);
%     train_all=cell2mat(struct2cell(train_all));
%     test_all=cell2mat(struct2cell(test_all));
%     
%     train_path=fullfile(data_dir,'\',train);
%     test_path=fullfile(data_dir,'\',test);
%     
%     training_data=load(train_path);
%     testing_data=load(test_path);
%     training_data=cell2mat(struct2cell(training_data));
%     testing_data=cell2mat(struct2cell(testing_data));
%     training_data=training_data;
%     testing_data=testing_data;
%     
%     row_train=size(train_all,1);
%     row_test=size(test_all,1);
% %     training_real_label=zeros(row_train,1);
% %     testing_real_label=zeros(row_test,1);
%     
%     training_real_label=train_all(:,1);
%     training_real_label=double(training_real_label);
%     training_data_label=[training_data training_real_label];
% 
%     %为测试数据附上真实类别编号
%     testing_real_label=test_all(:,1);  
%     testing_real_label=double(testing_real_label);
%     testing_data_label=[testing_data testing_real_label];%转置
%     
%    % addpath('E:\Matlab2019a\toolbox\libsvm-3.23\matlab');
%     train=double(training_data);
%     test=double(testing_data);
% 
% 
%     [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);
%     %       [bestacc,bestc,bestg] = SVMcgForClass(training_real_label, train_scale,0,2,-1,2,10,0.5,1,0.3);
%     bestc = 4;
%     bestg = 0.5;
%     cmd = [' -t ',num2str(bestg),' -c ',num2str(bestc)];
%     model = svmtrain(training_real_label, train_scale,cmd);
%     [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');
% 
% 
%     test_result=predicted_label';
%     save('testclass_result.mat','test_result');
% 
%     A(:,1)=test_all(:,3);
%     A(:,2)=test_all(:,1);
%     A(:,3)=test_result';
%     A(:,4)=test_all(:,2);
%     sum=0;
%     sumarea_wrong=0;
%     sumarea_all=0;
%     for k=1:row_test
%         sumarea_all=sumarea_all+A(k,4);
%         if(A(k,2)~=A(k,3))
%             sumarea_wrong=sumarea_wrong+A(k,4);
%             sum=sum+1;
%         end
%     end
%     avenum=sum;
%     aveerror=sumarea_wrong/sumarea_all;
%     
%     B=zeros(row_train,4);
%     B(:,1)=train_all(:,3);
%     B(:,2)=train_all(:,1);
% 
%     R=[A;B];
%     R=sortrows(R,1);
%     R(1,5)=avenum;
%     R(2,5)=sumarea_wrong;
%     R(3,5)=sumarea_all;
%     R(4,5)=aveerror;
%     R(5,5)=i;
%     result_final=[result_final;R(:,5)'];
%     result=[result,R];
%     sumnum=sumnum+sum;
%     sumallwrong=sumarea_wrong+sumallwrong;
%     sumallarea=sumallarea+sumarea_all;
% end
% result_final=sortrows(result_final,1);