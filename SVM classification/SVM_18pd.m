  
clear;
clc;

%hist_spec2='E:\bishe\08shanghai\new\pd_spesiftseg_test_word_image_matrix.mat';
% hist_spec2='E:\experiment\18pd\spe\speori\ucm_msd_H_1000.mat';
hist_spec2='E:\experiment\18pd\sift\siftstr_488\ucm_msd_H_1000.mat';
% hist_spec2='E:\experiment\18pd\result\spe488_sift488_num.mat';
%hist_spec2='E:\experiment\18pd\ocrnew\seg\num-dis\ucm_msd_H_1000.mat';
load('E:\experiment\18pd\18pd_patch.mat');

hist_spec2 = load(hist_spec2);
hist_spec2=cell2mat(struct2cell(hist_spec2));

y=xlsread('E:\experiment\18pd\18pd_label.xlsx','Sheet1','d2:d1323');
x=xlsread('E:\experiment\18pd\18pd_label.xlsx','Sheet1','a2:a1323');
area=xlsread('E:\experiment\18pd\18pd_label.xlsx','Sheet1','b2:b1323');
svm=[y,hist_spec2,area,x];

[c b]=size(svm);

%按照第一列排序
[y,i]=sortrows(svm,1);

result=[];
sumerror=0;
sumnum=0;
times=100;
class=12;
errorall=zeros(1332,12);
kappaall=[];
weakright=[];
for time=1:times
    time
    for k=1:1
        for j=1:1
            for i=1:12
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
%                 path='E:\experiment\18pd\fstm\spe488_sift488_ocr-0.8';
%                 training_name=sprintf('%s\\data_train\\train_word_image_matrix-%d.mat',path,time);
%                 testing_name=sprintf('%s\\data_test\\test_word_image_matrix-%d.mat',path,time);
%                 save(training_name,'train_word_image_matrix');
%                 save(testing_name,'test_word_image_matrix');


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

           sum2=0;
           sumarea_wrong=0;
           sumarea_all=0;
           A=[D3,test_result',D(:,b-1)];
           E=[C3,C3(1:m1,1),C(:,b-1)];
           M=[A;E];
           R=sortrows(M,2); 
           
            row=size(A,1);
            weak=0;
           weakall=0;
           for x=1:row
               index=A(x,2);
                if(patchnums(index)<=patchnums(488))
                    weakall=weakall+1;
                   if(A(x,1)==A(x,3))
                      weak=weak+1;
                   end
                end
           end
           weakright=[weakright;weak,weakall];

           row=size(A,1);
           for x=1:row
               errorall(A(x,2),A(x,3))=errorall(A(x,2),A(x,3))+1;
               sumarea_all=sumarea_all+A(x,4);
               if((A(x,1)-A(x,3))~=0)
                   sum2=sum2+1;
                   sumarea_wrong=sumarea_wrong+A(x,4);
               end
           end
           for j=1:m2
               R(j,6)=A(j,2);
           end
           R(1,5)=sum2;
           R(2,5)=sum2/m2;
           R(3,5)=sumarea_wrong;
           R(4,5)=sumarea_all;
           R(5,5)=sumarea_wrong/sumarea_all;
           R(5,5)
           avearea=sumarea_wrong/sumarea_all;
            sumnum=sumnum+sum2/m2;
            sumerror=avearea+sumerror;
            confusion0=zeros(class,class);
            confusion1=zeros(class,class);
            sumarea=zeros(1,class);
            row=size(A,1);
            for k=1:row
                label=A(k,1);
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
        end
    end
    result=[result,R];    
%         end
%     end
end
    avenum=sumnum/times;
    aveerror=sumerror/times;
    result(1,(7*times+2))=aveerror;
    result(1,(7*times+1))=avenum;
    kappaall=sortrows(kappaall,1,'descend');
    knum1=kappaall(1:50,1);
    karea1=kappaall(1:50,2);
    kave_num1=(sum(knum1))/50;
    kave_area1=sum(karea1)/50;
    kappaall=sortrows(kappaall,2,'descend');
    knum2=kappaall(1:50,1);
    karea2=kappaall(1:50,2);
    kave_num2=sum(knum2)/50;
    kave_area2=sum(karea2)/50;
    knumall=kappaall(1:100,1);
    kareaall=kappaall(1:100,2);
    kave_numall=sum(knumall)/100;
    kave_areaall=sum(kareaall)/100;
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
    