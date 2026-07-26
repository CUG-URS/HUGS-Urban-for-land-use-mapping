%??????????
clear; clc;

outdir = 'D:\码头遥感影像\out';

path1 = 'D:\码头遥感影像\out\纹理';


% max1=max(max(fea1));
% min1=min(min(fea1));
% maxtr=2*max1;
% fea1=maxtr/(max1-min1)*(fea1-min1);

path2 = 'D:\码头遥感影像\out\sift';


path3 = 'D:\码头遥感影像\out\光谱';



%???????????
tefile1 = strcat(path1, '\', 'test_word_image_matrix.mat');
load(tefile1);
fea4 = double(test_word_image_matrix);
a2 = size(fea4, 1);

% max4=max(max(fea4));
% min4=min(min(fea4));
% maxte=2*max4;
% fea4=maxte/(max4-min4)*(fea4-min4);

tefile2 = strcat(path2, '\', 'test_word_image_matrix.mat');
load(tefile2);
fea5 = test_word_image_matrix;
b2 = size(fea5, 1);
%
tefile3 = strcat(path3, '\', 'test_word_image_matrix.mat');
load(tefile3);
fea6 = test_word_image_matrix;
c2 = size(fea6, 1);

f2(1:a2, :) = fea4;
f2(a2 + 1:a2 + b2, :) = fea5;
%f2(a2 + b2 + 1:a2 + b2 + c2, :) = fea6;
test_word_image_matrix = f2;
filepath = strcat(outdir, '\', 'mul_test_word_image_matrix.mat'); %??????·????
save(filepath, 'test_word_image_matrix');
