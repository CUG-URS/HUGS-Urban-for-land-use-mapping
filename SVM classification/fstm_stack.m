 clear;
 clc;
%训练数据
path1='I:\Dancy\experimenal_results\20class结果\fstm特征\光谱\50%\64.2%K900';
% path1='I:\Dancy\experimenal_results\45class结果\fstm特征\光谱\10%32320\50.13%k1500';
filename1=strcat(path1, '\', 'final-fstm-topics-docs-contribute.dat');%合并文件路径名
fea1=load(filename1)';
a1=size(fea1,1);

path2='I:\Dancy\experimenal_results\20class结果\fstm特征\sift\50%\54.53%K80';
filename2=strcat(path2, '\','final-fstm-topics-docs-contribute.dat');%合并文件路径名
fea2=load(filename2)';
b1=size(fea2,1);

path3='I:\Dancy\experimenal_results\20class结果\fstm特征\wav\50%\84.93%K900';
% path3='I:\Dancy\experimenal_results\45class结果\fstm特征\SIFT\10%32320\38.49%K1500';
filename3=strcat(path3, '\','final-fstm-topics-docs-contribute.dat');%合并文件路径名
fea3=load(filename3)';
c1=size(fea3,1);

%合并3个训练数据
% cluster_num=a1+b1+c1+d1;
f1(1: a1,:)=fea1;
f1(a1+1: a1+b1,:)=fea2;
f1(a1+b1+1:a1+b1+c1,:)=fea3;

% path4='C:\Users\ZQQ\Desktop\分割+分块try\武汉\slic_10_0.01\59.2K100';
% filename4=strcat(path4, '\','final-fstm-topics-docs-contribute.dat');%合并文件路径名
% fea4=load(filename4)';
% d1=size(fea4,1);
% f1(a1+b1+c1+1:a1+b1+c1+d1,:)=fea4;

train_word_image_matrix=sparse(f1);
path='I:\Dancy\experimenal_results\20class结果\stack\fstm50%';
filepath=strcat(path, '\','mul_train_word_image_matrix.mat');%合并文件路径名
save(filepath,'train_word_image_matrix');

%测试数据
filename4=strcat(path1, '\','final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
fea4=load(filename4)';
a2=size(fea4,1);

filename5=strcat(path2, '\', 'final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
fea5=load(filename5)';
b2=size(fea5,1);

filename6=strcat(path3, '\','final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
fea6=load(filename6)';
c2=size(fea6,1);


%合并测试数据
% cluster_num=a2+b2+c2;
f2(1:a2,:)=fea4;
f2(a2+1: a2+b2,:)=fea5;
f2(a2+b2+1:a2+b2+c2,:)=fea6;

% filename7=strcat(path4, '\','final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
% fea7=load(filename7)';
% d2=size(fea7,1);
% f2(a2+b2+c2+1:a2+b2+c2+d2,:)=fea7;

test_word_image_matrix=sparse(f2);
filepath=strcat(path, '\', 'mul_test_word_image_matrix.mat');%合并文件路径名
save(filepath,'test_word_image_matrix');
