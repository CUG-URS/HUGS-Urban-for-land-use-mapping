clear;
clc;
load cnn_train.mat;
load cnn_test.mat;
% cnnpath='G:\Dancy\experimenal_results\12class结果\caffe-cnn特征\卷积层\21848\';
% cnntrain=strcat(cnnpath,'21848ctrain');
% load (cnntrain);
% [image_num,fea,c,d]=size(conv5);
% convtrain=[];
% for i=1:image_num
%     for f=1:fea
%       convtrain(i,f)=mean(mean(conv5(i,f,:,:)));
%     end  
% end
%拉伸到0-255，与词袋特征结合
max1=max(max(convtrain));
min1=min(min(convtrain));
convtrain=255/(max1-min1)*(convtrain-min1);
convtrain=int32(convtrain);
%归一化0-1，与主题特征结合
% max1=max(max(convtrain));
% min1=min(min(convtrain));
% convtrain=(convtrain-min1)/(max1-min1);

% cnntest=strcat(cnnpath,'21848ctest');
% load (cnntest);                                                                        
% [image_num,fea,c,d]=size(conv5);
% convtest=[];
% for i=1:image_num
%     for f=1:fea
%       convtest(i,f)=mean(mean(conv5(i,f,:,:)));
%     end  
% end
%拉伸到0-255，与词袋特征结合
max2=max(max(convtest));
min2=min(min(convtest));
convtest=255/(max2-min2)*(convtest-min2);
convtest=int32(convtest);
%归一化0-1，与主题特征结合
% max2=max(max(convtest));
% min2=min(min(convtest));
% convtest=(convtest-min2)/(max2-min2);
% save cnn_train.mat convtrain;
% save cnn_test.mat convtest;

%  cnn_train=strcat(cnnpath,'cnn_train255_32.mat');
%  load (cnn_train);
%  cnn_test=strcat(cnnpath,'cnn_test255_32.mat');
%  load (cnn_test);
% load cnn_train255_32.mat;
% load cnn_test255_32.mat;
load mul_train_word_image_matrix.mat;
load mul_test_word_image_matrix.mat;
train_word_image_matrix=double(train_word_image_matrix);
test_word_image_matrix=double(test_word_image_matrix);
training_data=[convtrain train_word_image_matrix'];
testing_data=[convtest test_word_image_matrix'];
%归一化到0-1
% max1=max(max(training_data));
% min1=min(min(training_data));
% training_data=(training_data-min1)/(max1-min1);
% max2=max(max(testing_data));
% min2=min(min(testing_data));
% testing_data=(testing_data-min2)/(max2-min2);
outdir='G:\科研\Dancy\experimenal_results\45class结果\caffe-cnn结果\20%\卷积层\31275';
filepath=strcat(outdir,'\','cnn255_32tm_train.mat');
save (filepath, 'training_data');
filepath=strcat(outdir,'\','cnn255_32tm_test.mat');
save (filepath, 'testing_data'); 
