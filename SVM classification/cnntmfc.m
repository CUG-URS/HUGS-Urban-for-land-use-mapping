clear;
clc;
load cnn_train.mat;
load cnn_test.mat;
% cnnpath='I:\Dancy\experimenal_results\45class结果\caffe-cnn结果\20%\全连接层fc6-7\31275\';
% % cnnpath='I:\Dancy\experimenal_results\45class结果\caffe-cnn结果\10%\全连接层fc6\78.70%32320\';
% cnntrain=strcat(cnnpath,'31275train');
% load (cnntrain);
% fctrain=fc6;
max1=max(max(fctrain));
min1=min(min(fctrain));
%拉伸到0-255
fctrain=351/(max1-min1)*(fctrain-min1);
fctrain=int32(fctrain);
%归一化
% fctrain=(fctrain-min_tr)/(max_tr-min_tr);

% cnntest=strcat(cnnpath,'31275test');
% load (cnntest);
% fctest=fc6;
max2=max(max(fctest));
min2=min(min(fctest));
%拉伸到0-255
fctest=351/(max2-min2)*(fctest-min2);
fctest=int32(fctest);
%归一化
% fctest=(fctest-min_te)/(max_te-min_te);
% save cnn_train.mat fctrain;
% save cnn_test.mat fctest;

%  cnn_train=strcat(cnnpath,'17092cnn_train.mat');
%  load (cnn_train);
%  cnn_test=strcat(cnnpath,'17092cnn_test.mat');
%  load (cnn_test);
% load mul-final-fstm-topics-docs-contribute.mat;
% load mul-final-fstm-inf-topics-docs-contribute.mat;
% train_word_image_matrix=load('final-fstm-topics-docs-contribute.dat');
% test_word_image_matrix=load('final-fstm-inf-topics-docs-contribute.dat');

%     training_data=load('final-fstm-topics-docs-contribute.dat');
%     testing_data=load('final-fstm-inf-topics-docs-contribute.dat');
% load mul-final-fstm-inf-topics-docs-contribute.mat;
% load mul-final-fstm-topics-docs-contribute.mat;
%  load mul_train_word_image_matrix.mat;
%  load mul_test_word_image_matrix.mat;
load mul_train_word_image_matrix.mat;
load mul_test_word_image_matrix.mat;
% train_word_image_matrix=single(full(training_data'));
% test_word_image_matrix=single(full(testing_data'));
% %拉伸到0-255
% max1=max(max(train_word_image_matrix));
% min1=min(min(train_word_image_matrix));
% train_word_image_matrix=255/(max1-min1)*(train_word_image_matrix-min1);
% % %拉伸到0-255
% max2=max(max(test_word_image_matrix));
% min2=min(min(test_word_image_matrix));
% test_word_image_matrix=255/(max2-min2)*(test_word_image_matrix-min2);
%%融合
training_data=[fctrain train_word_image_matrix'];
testing_data=[fctest test_word_image_matrix'];
path='G:\科研\Dancy\experimenal_results\45class结果\caffe-cnn结果\20%\全连接层fc6-7\80.36%16300\new';
filepath=strcat(path, '\', 'cnntm_train.mat');%合并文件路径名
save(filepath,'training_data');
filepath=strcat(path, '\', 'cnntm_test.mat');%合并文件路径名
save(filepath,'testing_data');


