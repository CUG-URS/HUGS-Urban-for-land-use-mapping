function []=ClassifierLDA_SVM()
clear;
clc;
%%20class
% 50%
%   training_image_num=[75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75];
%        training_all_image_num=1500;
%   testing_image_num=[75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75,75];
%        testing_all_image_num=1500;
 %80%
%    training_image_num=[120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120];
%        training_all_image_num=2400;
%   testing_image_num=[30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30];
%        testing_all_image_num=600;
% %%21class      
%       training_image_num=[60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60];
%       training_image_num=[20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20];
%         training_image_num=[40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40];
%   training_image_num=[80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80];
%        training_all_image_num=1680;
%       testing_image_num=[80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80,80];
%       testing_image_num=[60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60];
%        testing_image_num=[40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40];    
% testing_image_num=[20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20,20];
%         testing_all_image_num=420;
%%12class
%       training_image_num=[40,40,40,40,40,40,40,40,40,40,40,40];
%       training_image_num=[80,80,80,80,80,80,80,80,80,80,80,80];
%       training_image_num=[60,60,60,60,60,60,60,60,60,60,60,60];
%         training_image_num=[20,20,20,20,20,20,20,20,20,20,20,20];
%           training_image_num=[10,10,10,10,10,10,10,10,10,10,10,10];
%         training_image_num=[100,100,100,100,100,100,100,100,100,100,100,100];
%         training_all_image_num=1200;  
%      testing_image_num=[160,160,160,160,160,160,160,160,160,160,160,160];
%       testing_image_num=[120,120,120,120,120,120,120,120,120,120,120,120];
%       testing_image_num=[140,140,140,140,140,140,140,140,140,140,140,140];
%         testing_image_num=[180,180,180,180,180,180,180,180,180,180,180,180];
%         testing_image_num=[190,190,190,190,190,190,190,190,190,190,190,190];
%         testing_image_num=[100,100,100,100,100,100,100,100,100,100,100,100];
%         testing_all_image_num=1200;  
%%8class
%   training_image_num=[24,24,24,24,24,24,24,24];
%   training_all_image_num=192;  
%   testing_image_num=[6,6,6,6,6,6,6,6];
%   testing_all_image_num=48; 
  training_image_num=[72,68];
  training_all_image_num=140;  
  testing_image_num=864;
  testing_all_image_num=864; 
%%45class
% %  
%  training_image_num=140*ones(1,45);
%  training_all_image_num=6300;
%  testing_image_num=560*ones(1,45);
%  testing_all_image_num=25200;

%     %加载γ数据
%     training_data=load('final-fstm-topics-docs-contribute.dat');
%     testing_data=load('final-fstm-inf-topics-docs-contribute.dat');
%      training_data=load('final.gamma');
%     testing_data=load('test-gamma.dat');
%     load mul-final-fstm-topics-docs-contribute.mat;
%     load mul-final-fstm-inf-topics-docs-contribute.mat;
    load train_word_image_matrix.mat;
    load test_word_image_matrix.mat;
%     load ('H:\Dancy\experimenal_results\45class结果\fea-coding结果\20%31275\train_word_image_matrix.mat');
%     load ('H:\Dancy\experimenal_results\45class结果\fea-coding结果\20%31275\test_word_image_matrix.mat');
%     load mul_train_word_image_matrix.mat;    
%     load mul_test_word_image_matrix.mat;
    training_data= train_word_image_matrix;
    testing_data=test_word_image_matrix;
% load  cnntm_train.mat;
% load cnntm_test.mat;
% load  cnn_train.mat;
% load cnn_test.mat;
% load cnn_train255_32.mat;
% load cnn_test255_32.mat;
% training_data=fctrain;
% testing_data= fctest;
%  training_data=convtrain;
% testing_data= convtest;
% load cnn255_32tm_train.mat;
% load cnn255_32tm_test.mat;

     %为训练数据附上真实类别编号
%      load testing_patch_me=tadata.mat;
    training_real_label=zeros(size(training_data,1),1);
    current_label=1;
    change_point=training_image_num(1,current_label);
    for i=1:training_all_image_num
        if i<=change_point
            training_real_label(i,1)=current_label;
        else
            current_label=current_label+1;
            change_point=change_point+training_image_num(1,current_label);
            training_real_label(i,1)=current_label;
        end    
    end
    training_data_label=[training_data training_real_label]';%转置
    
    %为测试数据附上真实类别编号
    testing_real_label=zeros(size(testing_data,1),1);
    current_label=1;
    change_point=testing_image_num(1,current_label);
    for i=1:testing_all_image_num
        if i<=change_point
            testing_real_label(i,1)=current_label;
        else
            current_label=current_label+1;
            change_point=change_point+testing_image_num(1,current_label);
            testing_real_label(i,1)=current_label;
        end    
    end
    testing_data_label=[testing_data testing_real_label]';%转置
    
    %SVM分类器
    addpath('E:\Matlab2019a\toolbox\libsvm-3.23\matlab');
%     set_num_threads(4);
    train=double(training_data);
    test=double(testing_data);
%     
%     a1=set_mat(train);
%     a2=set_mat(test);
    %%hist
%     K = hist_isect(train, train);
%     K1 = [(1:size(train,1))', K];
%     bestc=10;
%     options=sprintf('-s 0 -t 4 -c %f -b 0 ',bestc); 
%     model_p = svmtrain(training_real_label,K1,options);
%     %model_p = svmtrain( training_real_label,a1,options);
%     k=hist_isect(test,train);
%     K2=[(1:size(test,1))',k];
%     [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, K2, model_p,'-b 0');

train=double(training_data);
            test=double(testing_data);
            [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);
            bestc = 4;
            bestg = 0.5;
            cmd = [' -t ',num2str(bestg),' -c ',num2str(bestc)];
            model = svmtrain(training_real_label, train_scale,cmd);
            [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');
  
      %%rbf 88.81%
%       [train_scale,test_scale,ps] = scaleForSVM(train,test,0,1);      
%       [bestacc,bestc,bestg] = SVMcgForClass(training_real_label, train_scale,0,2,-1,2,10,0.5,1,0.3);
%        cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%       model = svmtrain(training_real_label, train_scale,cmd);
%       [predicted_label, accuracy, decision_values] = svmpredict(testing_real_label, test_scale, model,'libsvm_options');
      %%linear(-t0) 91.43%  rbf (-t 2) 默认参数效果不好68.10%% 归一化后71.67
%       [train,test,ps] = scaleForSVM(train,test,0,1);     
%       bestc=10;
%       options=sprintf('-s 0 -t 2 -c %f -b 1',bestc); 
%       model_p = svmtrain(training_real_label,train,options);
%       [predicted_label, accurhrracy, decision_values] = svmpredict(testing_real_label, test, model_p,'-b 1');

   test_result=predicted_label';
%    test_result=[ test_result; testnames];
   save('testclass_result.mat','test_result');
end
       
       
       