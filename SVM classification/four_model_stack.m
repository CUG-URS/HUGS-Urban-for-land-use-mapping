%输入第一个数据
cd('C:\Users\a\Desktop\21class结果\75.24%光谱V1000\K70LDA75.24%');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train1=load(filename);
col_tra1=size(train1,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test1=load(filename);
col_tes1=size(test1,2);
%输入第二个数据
cd('C:\Users\a\Desktop\21class结果\73.33%小波V900');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train2=load(filename);
col_tra2=size(train2,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test2=load(filename);
col_tes2=size(test2,2);
%输入第三个数据
cd('C:\Users\a\Desktop\21class结果\70%SIFTV1000\70%K55');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train3=load(filename);
col_tra3=size(train3,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test3=load(filename);
col_tes3=size(test3,2);
%输入第四个数据
cd('C:\Users\a\Desktop\21class结果\73.81%纹理V1000\73.81%k50');
[file,path]=uigetfile('final.gamma','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train4=load(filename);
col_tra4=size(train4,2);

filename=strcat(path, '\','test-gamma.dat');%合并文件路径名
test4=load(filename);
col_tes4=size(test4,2);

train(:,1:col_tra1)=train1;
train(:,col_tra1+1:col_tra1+col_tra2)=train2;
train(:,col_tra1+col_tra2+1:col_tra1+col_tra2+col_tra3)=train3;
train(:,col_tra1+col_tra2+col_tra3+1:col_tra1+col_tra2+col_tra3+col_tra4)=train4;
train=train';
test(:,1:col_tes1)=test1;
test(:,col_tes1+1:col_tes1+col_tes2)=test2;
test(:,col_tes1+col_tes2+1:col_tes1+col_tes2+col_tes3)=test3;
test(:,col_tes1+col_tes2+col_tes3+1:col_tes1+col_tes2+col_tes3+col_tes4)=test4;
test=test';

cd('C:\Users\a\Desktop\21class结果\model-stack\s-w-S-t1000+900+1000+1000')
[file,path] = uiputfile('train-gamma.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'train');
[file,path] = uiputfile('test-gamma.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'test');