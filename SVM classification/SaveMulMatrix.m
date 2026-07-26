%??????????
clear; clc;
path1 = 'D:\码头数据\码头out\sitis';
trfile1 = strcat(path1, '\', 'train_word_image_matrix.mat');
load(trfile1);
fea1 = double(train_word_image_matrix);
a1 = size(fea1, 1);

% max1=max(max(fea1));
% min1=min(min(fea1));
% maxtr=2*max1;
% fea1=maxtr/(max1-min1)*(fea1-min1);

path2 = 'D:\码头数据\码头out\sift';
trfile2 = strcat(path2, '\', 'train_word_image_matrix.mat');
load(trfile2);
fea2 = train_word_image_matrix;
b1 = size(fea2, 1);

path3 = 'D:\码头数据\码头out\spe';
trfile3 = strcat(path3, '\', 'train_word_image_matrix.mat');
load(trfile3);
fea3 = train_word_image_matrix;
c1 = size(fea3, 1);

f1(1:a1, :) = fea1;
f1(a1 + 1:a1 + b1, :) = fea2;
%f1(a1 + b1 + 1:a1 + b1 + c1, :) = fea3;
train_word_image_matrix = f1;
outdir = 'D:\码头数据\码头out';
filepath = strcat(outdir, '\', 'mul_train_word_image_matrix.mat'); %??????·??w??
save(filepath, 'train_word_image_matrix');

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
f2(a2 + b2 + 1:a2 + b2 + c2, :) = fea6;
test_word_image_matrix = f2;
filepath = strcat(outdir, '\', 'mul_test_word_image_matrix.mat'); %??????·????
save(filepath, 'test_word_image_matrix');
