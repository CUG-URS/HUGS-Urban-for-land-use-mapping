%合并训练数据
cd('G:\Dancy\experimenal_results\12class结果\fstm模型\83.33%V1000K250spe');
[file,path]=uigetfile('final-fstm-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea1=load(filename)';
a1=size(fea1,1);

cd('D:\Dancy\Demos\fstm\data\12class\80.92%V1000K300wavelet');
[file,path]=uigetfile('final-fstm-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea2=load(filename)';
b1=size(fea2,1);

cd('G:\Dancy\experimenal_results\12class结果\fstm模型\78.5%V1000K320sift');
[file,path]=uigetfile('final-fstm-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea3=load(filename)';
c1=size(fea3,1);

cluster_num=a1+b1+c1;
d1(1: a1,:)=fea1;
d1(a1+1: a1+b1,:)=fea2;
d1(a1+b1+1:a1+b1+c1,:)=fea3;
train_word_image_matrix=d1;
cd('D:\Dancy\Demos\fstm\data\12class\mulstack');
[file,path] = uiputfile('mul-final-fstm-topics-docs-contribute.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'train_word_image_matrix');


%合并测试数据
cd('G:\Dancy\experimenal_results\12class结果\fstm模型\83.33%V1000K250spe');
[file,path]=uigetfile('final-fstm-inf-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea4=load(filename)';
a2=size(fea4,1);

cd('D:\Dancy\Demos\fstm\data\12class\80.92%V1000K300wavelet');
[file,path]=uigetfile('final-fstm-inf-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea5=load(filename)';
b2=size(fea5,1);

cd('D:\Dancy\Demos\fstm\data\12class\78.5%V1000K320sift');
[file,path]=uigetfile('final-fstm-inf-topics-docs-contribute.dat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
fea6=load(filename)';
c2=size(fea6,1);

cluster_num=a2+b2+c2;
d2(1:a2,:)=fea4;
d2(a2+1: a2+b2,:)=fea5;
d2(a2+b2+1:a2+b2+c2,:)=fea6;
test_word_image_matrix=d2;
cd('D:\Dancy\Demos\fstm\data\12class\mulstack');
[file,path] = uiputfile('mul-final-fstm-inf-topics-docs-contribute.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'test_word_image_matrix');
