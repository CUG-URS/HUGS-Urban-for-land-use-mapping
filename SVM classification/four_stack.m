%合并训练数据
cd('C:\Users\a\Desktop\21class结果\75.24%光谱V1000');
[file,path]=uigetfile('train_word_Image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
filename=strcat(path, '\','train_wordimagematrix_metadata.mat');%合并文件路径名
load(filename);
fea1=full(word_image_matrix);
a1=size(fea1,1);

cd('C:\Users\a\Desktop\21class结果\73.33%小波V900');
[file,path]=uigetfile('train_word_image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea2=full(word_image_matrix);
b1=size(fea2,1);

cd('C:\Users\a\Desktop\21class结果\70%SIFTV1000');
[file,path]=uigetfile('train_word_Image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea3=full(word_image_matrix);
c1=size(fea3,1);

cd('C:\Users\a\Desktop\21class结果\73.81%纹理V1000');
[file,path]=uigetfile('train_word_Image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea4=full(word_image_matrix);
d1=size(fea4,1);

cluster_num=a1+b1+c1;
e1(1: a1,:)=fea1;
e1(a1+1: a1+b1,:)=fea2;
e1(a1+b1+1:a1+b1+c1,:)=fea3;
e1(a1+b1+c1+1:a1+b1+c1+d1,:)=fea4;
word_image_matrix=sparse(e1);
%存储矩阵
cd('C:\Users\a\Desktop\21class结果\model-stack\s-w-S-t1000+900+1000+1000');
[file,path] = uiputfile('train_word_image_matrix.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'word_image_matrix');
filepath=strcat(path, '\', 'train_wordimagematrix_metadata.mat');%合并文件路径名
save(filepath,'file_n','image_num','all_image_num','cluster_num');

%合并测试数据
cd('C:\Users\a\Desktop\21class结果\75.24%光谱V1000');
[file,path]=uigetfile('test_word_image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
filename=strcat(path, '\','testwordimagematrix_metadata.mat');%合并文件路径名
load(filename);
fea5=full(word_image_matrix);
a2=size(fea5,1);

cd('C:\Users\a\Desktop\21class结果\73.33%小波V900');
[file,path]=uigetfile('test_word_image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea6=full(word_image_matrix);
b2=size(fea6,1);

cd('C:\Users\a\Desktop\21class结果\70%SIFTV1000');
[file,path]=uigetfile('test_word_image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea7=full(word_image_matrix);
c2=size(fea7,1);

cd('C:\Users\a\Desktop\21class结果\73.81%纹理V1000');
[file,path]=uigetfile('test_word_image_matrix.mat','请选择训练图像的patch数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
fea8=full(word_image_matrix);
d2=size(fea8,1);

cluster_num=a2+b2+c2;
e2(1:a2,:)=fea5;
e2(a2+1: a2+b2,:)=fea6;
e2(a2+b2+1:a2+b2+c2,:)=fea7;
e2(a2+b2+c2+1:a2+b2+c2+d2,:)=fea8;
word_image_matrix=sparse(e2);
cd('C:\Users\a\Desktop\21class结果\model-stack\s-w-S-t1000+900+1000+1000');
[file,path] = uiputfile('test_word_image_matrix.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'word_image_matrix');
filepath=strcat(path, '\', 'testwordimagematrix_metadata.mat');%合并文件路径名
save(filepath,'file_n','image_num','all_image_num','cluster_num');