%输入第一个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\光谱V300\scale150');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train1=load(filename);
col_tra1=size(train1,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test1=load(filename);
col_tes1=size(test1,2);
%输入第二个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\小波V150');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train2=load(filename);
col_tra2=size(train2,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test2=load(filename);
col_tes2=size(test2,2);
%输入第三个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\SIFTV300\scale150');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train3=load(filename);
col_tra3=size(train3,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test3=load(filename);
col_tes3=size(test3,2);

train(:,1:col_tra1)=train1;
train(:,col_tra1+1:col_tra1+col_tra2)=train2;
train(:,col_tra1+col_tra2+1:col_tra1+col_tra2+col_tra3)=train3;
train=train';
test(:,1:col_tes1)=test1;
test(:,col_tes1+1:col_tes1+col_tes2)=test2;
test(:,col_tes1+col_tes2+1:col_tes1+col_tes2+col_tes3)=test3;
test=test';

cd('D:\Dancy\Desktop\4class结果\大幅影像标注\model-stack\s-t-S-300-150-300-21-17-17')
[file,path] = uiputfile('train-gamma.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'train');
[file,path] = uiputfile('test-gamma.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'test');