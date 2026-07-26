%%根据每张影像在各个LDA模型中得到的似然值，根据最大似然函数法分类——与第二种方案对应

%加载元数据'file_n','image_num','all_image_num','cluster_num'
[file,path]=uigetfile('testwordimagematrix_metadata.mat','请选择测试图像的元数据文件'); 
filename=strcat(path, '\', file);%合并文件路径名
load(filename);

%加载由LDA得到的各个图像的似然值
scene_num=file_n;
likelihood_matrix=zeros(all_image_num,scene_num);
for i=1:file_n
    filename=strcat(path,'class',num2str(i),'-lda-lhood.dat');
    likelihood_matrix(:,i)=load(filename);
end

%选出最大似然值所说的场景类别
[dummy scene_label]=max(likelihood_matrix,[],2);

%真实类别编号
real_label=zeros(size(scene_label));
current_label=1;
change_point=image_num(1,current_label);
for i=1:all_image_num
    if i<=change_point
        real_label(i,1)=current_label;
    else
        current_label=current_label+1;
        change_point=change_point+image_num(1,current_label);
        real_label(i,1)=current_label;
    end    
end

%生成类别和真实类别合体
test_result=[scene_label real_label]';
save('test_result.mat','test_result');

%计算混淆矩阵
n1=1;
n2=0;
t=scene_num; %场景类别数
confusion_matrix=zeros(t,t);
for i=1:t %列表示正确类别数
    n2=n2+image_num(1,i);
    for ii=n1:n2
        a=test_result(1,ii);
        confusion_matrix(a,i)=confusion_matrix(a,i)+1;
    end
    n1=n2+1;
end
accuracy=zeros(1,scene_num);
sum_right=0;
for i=1:scene_num
    accuracy(1,i)=confusion_matrix(i,i)/image_num(1,i);
    sum_right=sum_right+confusion_matrix(i,i);
end
OA=zeros(1,scene_num);
OA(1,1)=sum_right/all_image_num;
confusion_matrix=[confusion_matrix;accuracy;OA];
save('confusion_matrix.mat','confusion_matrix');
clear;




