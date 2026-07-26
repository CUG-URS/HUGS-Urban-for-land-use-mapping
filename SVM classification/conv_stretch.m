clear;clc;
load('G:\Dancy\experimenal_results\45class结果\caffe-cnn结果\10%\卷积层\32320\cnn_train');
load('G:\Dancy\experimenal_results\45class结果\caffe-cnn结果\10%\卷积层\32320\cnn_test');
outdir='G:\Dancy\experimenal_results\45class结果\caffe-cnn结果\10%\卷积层\32320';
max1=max(max(convtrain));
min1=min(min(convtrain));
convtrain=255/(max1-min1)*(convtrain-min1);
max2=max(max(convtest));
min2=min(min(convtest));
convtest=255/(max2-min2)*(convtest-min2);
convtrain=int32(convtrain);
convtest=int32(convtest);
filepath=strcat(outdir, '\', 'cnn_train255_32.mat');%合并文件路径w名
save(filepath,'convtrain');
filepath=strcat(outdir, '\', 'cnn_test255_32.mat');%合并文件路径w名
save(filepath,'convtest');

