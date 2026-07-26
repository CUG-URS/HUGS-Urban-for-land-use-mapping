cd('D:\Dancy\Demos\fstm\data\21class\76.43%V1000K250spe');
[file,path]=uigetfile('final-fstm-topics-docs-contribute.dat','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train1=load(filename);
col_tra1=size(train1,2);

filename=strcat(path, '\','final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
test1=load(filename);
col_tes1=size(test1,2);


cd('D:\Dancy\Demos\fstm\data\21class\80.47%V1000K250sift');
[file,path]=uigetfile('final-fstm-topics-docs-contribute.dat','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
train2=load(filename);
col_tra2=size(train2,2);

filename=strcat(path, '\','final-fstm-inf-topics-docs-contribute.dat');%合并文件路径名
test2=load(filename);
col_tes2=size(test2,2);

train(:,1:col_tra1)=train1;
train(:,col_tra1+1:col_tra1+col_tra2)=train2;
train=train';
test(:,1:col_tes1)=test1;
test(:,col_tes1+1:col_tes1+col_tes2)=test2;
test=test';

cd('D:\Dancy\Demos\fstm\data\21class\mulstack')
[file,path] = uiputfile('mul-final-fstm-topics-docs-contribute.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'train');
[file,path] = uiputfile('mul-final-fstm-inf-topics-docs-contribute.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'test');