% clc;
% clear all;

%hist_spec2='E:\experiment\cd\seg\ucm_msd_H_1000.mat';
% hist_spec2='E:\experiment\cd\spe\speori\ucm_msd_H_1000.mat';
hist_spec2='E:\experiment\cd\\sift\siftstr_183\ucm_msd_H_1000.mat';
%hist_spec2='E:\experiment\cd\result\spe183_sift183_ocr.mat';
load('E:\experiment\cd\cd_patch.mat');

hist_spec2 = load(hist_spec2);
hist_spec2=cell2mat(struct2cell(hist_spec2));

y=xlsread('E:\experiment\cd\cd_label.xlsx','Sheet1','c2:c845');
x=xlsread('E:\experiment\cd\cd_label.xlsx','Sheet1','a2:a845');
area=xlsread('E:\experiment\cd\cd_label.xlsx','Sheet1','b2:b845');

svm=[y,hist_spec2,area,x];

[c b]=size(svm);

%按照第一列排序
[y,i]=sortrows(svm,1);

result=[];
AA=[];
sumerror=0;
sumnum=0;
times=100;
errorall=zeros(844,9);
weakright=[];
for time=1:times
    time
    for k=1:1
        for j=1:1
            for i=1:9
                F = find(y(:,1)==i);
                R = y(F,:);
                [m,n]=size(F);
                a=ceil(m*(0.5*k));
                idx=randperm(m);
                idx=idx(1:a);
                A=R(idx,:);
                B=R;
                B(idx,:)=[];

                if i==1
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

             training_data=C(1:m1,2:b-2);
             testing_data=D(1:m2,2:b-2);
% %                 
%                 train_word_image_matrix=C(1:m1,:);
%                 test_word_image_matrix=D(1:m2,:);
%                 path='E:\experiment\cd\fstm\speori_siftori_ocr-0.5';
%                 training_name=sprintf('%s\\data_train\\train_word_image_matrix-%d.mat',path,time);
%                 testing_name=sprintf('%s\\data_test\\test_word_image_matrix-%d.mat',path,time);
%                 save(training_name,'train_word_image_matrix');
%                 save(testing_name,'test_word_image_matrix');
% 

                train=double(training_data);
                test=double(testing_data);
                
                training_real_label=C(:,1);
                training_real_label=double(training_real_label);
                training_data_label=[training_data training_real_label];
% 
%                 为测试数据附上真实类别编号
                testing_real_label=D(:,1);
                testing_real_label=double(testing_real_label);
                testing_data_label=[testing_data testing_real_label];


                
            training_real_label=C(1:m1,1);
            testing_real_label=D(1:m2,1);
            train=double(training_data);
            test=double(testing_data);
            [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);
            bestc = 4;
            bestg = 0.5;
            cmd = [' -t ',num2str(bestg),' -c ',num2str(bestc)];
            model = svmtrain(training_real_label, train_scale,cmd);
            [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');
           test_result=predicted_label';
           save('testclass_result.mat','test_result');



           sum=0;
           sumarea_wrong=0;
           sumarea_all=0;
           A=[D3,test_result',D(:,b-1)];
           
            row=size(A,1);
            weak=0;
           weakall=0;
           for x=1:row
               index=A(x,2);
                if(patchnums(index)<=patchnums(183))
                    weakall=weakall+1;
                   if(A(x,1)==A(x,3))
                      weak=weak+1;
                   end
                end
           end
           weakright=[weakright;weak,weakall];
           
           for x=1:row
               sumarea_all=sumarea_all+A(x,4);
           end
           for p=1:row
               errorall(A(p,2),A(p,3))=errorall(A(p,2),A(p,3))+1;
               if((A(p,1)-A(p,3))~=0)
                   sum=sum+1;
                   sumarea_wrong=sumarea_wrong+A(p,4);
               end
           end
           avearea=sumarea_wrong/sumarea_all;
%            R=sortrows(M,2); 
% 
%            row=size(A,1);
%            for i=1:row
%                if((R(i,1)-R(i,3))~=0)
%                    R(i,5)=1;
%                    sum=sum+1;
%                    sumarea_wrong=sumarea_wrong+R(i,4);
%                end
%            end
%            for j=1:m2
%                R(j,7)=A(j,2);
%            end
%            R(1,6)=sum;
%            R(2,6)=sum/m2;
%            R(3,6)=sumarea_wrong;
%            R(4,6)=sumarea_all;
%            R(5,6)=sumarea_wrong/sumarea_all;
%         end
%     end
    result=[result,A];
    sumnum=sumnum+sum/m2;
    sumerror=avearea+sumerror;
    
    AA=[AA,A];
        end
    end
end
avenum=sumnum/times;
result(1,(7*times+1))=avenum;
aveerror=sumerror/times;
result(2,(7*times+1))=aveerror;
%     
% row=size(A,1);
% confusion0=zeros(9,9);
% confusion1=zeros(9,9);
% sumarea=zeros(1,9);
% for p=1:times
%     for k=1:row
%         label=AA(k,1+4*(p-1));
%         for q=1:9
%             if(label==q)
%                 sumarea(1,label)=sumarea(1,label)+AA(k,4*p);
%             end
%             label0=AA(k,3+4*(p-1));
%             if(label0==q)
%                 confusion0(label,label0)=confusion0(label,label0)+1;
%                 confusion1(label,label0)=confusion1(label,label0)+AA(k,4*p);
%             end
%         end
%     end
% end
% confusion0=confusion0/times;
% for x=1:9
%     confusion1(x,:)=confusion1(x,:)/sumarea(1,x);
% end
% kappa_num=KAPPA(confusion0);
% kappa_area=KAPPA(confusion1);
% 
% function [result] = KAPPA(confusion)
% row=size(confusion,1);
% sumreal=0;
% sumkappa=0;
% sumall=0;
% for i=1:row
%     sumrowi=sum(confusion(:,i));
%     sumcoli=sum(confusion(i,:));
%     sumall=sumall+sumrowi;
%     sumrowcol=sumrowi*sumcoli;
%     sumkappa=sumkappa+sumrowcol;
%     sumreal=sumreal+confusion(i,i);
% end
% Po=sumreal/sumall;
% Pe=sumkappa/(sumall*sumall);
% result=(Po-Pe)/(1-Pe);
% end