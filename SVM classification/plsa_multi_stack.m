%输入第一个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\光谱V300\scale150\PLSA');
[file,path]=uigetfile('pro_train.mat','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
row_tra1=size(Pz_d2,1);
 train1=Pz_d2(1:row_tra1-1,:);
%  对原始图像进行最简单的归一化
% maxgrey=max(Pz_d2);
% maxgrey=max(maxgrey);%整幅图中最大的灰度值
% mingrey=min(Pz_d2);
% mingrey=min(mingrey);%整幅图中最小的灰度值
% min_matrix=mingrey.*ones( size(Pz_d2) );
% max_matrix=maxgrey.*ones( size(Pz_d2) );
% t=(Pz_d2-min_matrix)./(max_matrix-min_matrix);
% train1=t;

filename=strcat(path, '\','pro_test.mat');%合并文件路径名
load(filename);
row_tes1=size(Pz_d3,1);
test1=Pz_d3(1:row_tes1-1,:);
%输入第二个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\小波V200');
[file,path]=uigetfile('pro_train.mat','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
row_tra2=size(Pz_d2,1);
train2=Pz_d2(1:row_tra2-1,:);

filename=strcat(path, '\','pro_test');%合并文件路径名
load(filename);
row_tes2=size(Pz_d3,1);
test2=Pz_d3(1:row_tes2-1,:);
%输入第三个数据
cd('D:\Dancy\Desktop\4class结果\大幅影像标注\SIFT350');
[file,path]=uigetfile('pro_train.mat','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
row_tra3=size(Pz_d2,1);
train3=Pz_d2(1:row_tra3-1,:);

filename=strcat(path, '\','pro_test');%合并文件路径名
load(filename);
row_tes3=size(Pz_d3,1);
test3=Pz_d3(1:row_tes3-1,:);

train(1:row_tra1-1,:)=train1;
train(row_tra1:row_tra1+row_tra2-2,:)=train2;
train(row_tra1+row_tra2-1:row_tra1+row_tra2+row_tra3-3,:)=train3;
train=train';
test(1:row_tes1-1,:)=test1;
test(row_tes1:row_tes1+row_tes2-2,:)=test2;
test(row_tes1+row_tes2-1:row_tes1+row_tes2+row_tes3-3,:)=test3;
test=test';

cd('D:\Dancy\Desktop\4class结果\大幅影像标注\model-stack\s-t-S-300-200-350-19')
[file,path] = uiputfile('train-pz_d.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'train');
[file,path] = uiputfile('test-pz_d.mat','保存word—image共生矩阵：');
filepath=strcat(path, '\', file);%合并文件路径名
save(filepath,'test');