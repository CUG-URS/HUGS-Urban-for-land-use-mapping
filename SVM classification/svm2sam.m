cd('C:\Users\a\Desktop\21class结果\PLSA\model-stack\s-t-S-1000+1000+1000\56.67%k70');
[file,path]=uigetfile('train-pz_d','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
Pz_d2=train';
topic_num=size(Pz_d2,1);
file_n=21;
image_num=80*ones(1,file_n);
temp=[];
for i=1:file_n
    a=image_num(1,i);
    for ii=1:a
        temp=[temp i];
    end
end
Pz_d2=[Pz_d2;temp];
save('pro_train.mat','Pz_d2','file_n','image_num','topic_num');

cd('C:\Users\a\Desktop\21class结果\PLSA\model-stack\s-t-S-1000+1000+1000\56.67%k70');
[file,path]=uigetfile('test-pz_d','请选择训练图像的数据文件');
filename=strcat(path, '\', file);%合并文件路径名
load(filename);
Pz_d3=test';
topic_num=size(Pz_d3,1);
file_n=21;
image_num=20*ones(1,file_n);
temp=[];
for i=1:file_n
    a=image_num(1,i);
    for ii=1:a
        temp=[temp i];
    end
end
Pz_d3=[Pz_d3;temp];
save('pro_test.mat','Pz_d3','file_n','image_num','topic_num');