% cd('C:\Users\a\Desktop\21class结果\model-stack\88.33%s-t-S1000+1000+1000\88.33%s-t-SK70');
% [file,path]=uigetfile('train-gamma.mat','请选择训练图像的数据文件');
% filename=strcat(path, '\', file);%合并文件路径名
load train-gamma.mat;
train=train';

% filename=strcat(path, '\','test-gamma.mat');%合并文件路径名
load test-gamma.mat;
test=test';

% cd('C:\Users\a\Desktop\21class结果\model-stack\88.33%s-t-S1000+1000+1000\88.33%s-t-SK70\svm2sam')
% [file,path] = uiputfile('final.gamma','保存word—image共生矩阵：');
% filepath=strcat(path, '\', file);%合并文件路径名
save('final.gamma','train');
% [file,path] = uiputfile('test-gamma.dat','保存word—image共生矩阵：');
% filepath=strcat(path, '\', file);%合并文件路径名
save('test-gamma.dat','test');