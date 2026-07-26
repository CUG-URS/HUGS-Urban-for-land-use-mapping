clc
clear
% 移动到某个目录下，
srcDic = uigetdir('E:\BaiduNetdiskDownload\test');
cd(srcDic);
%读取所有的jpg图片
allnames = struct2cell(dir('*.jpg'));
[k,len]=size(allnames);
aviobj = VideoWriter('driver.avi');
%设置帧率
open(aviobj)
%我制作了由180张图片构成的视频
for i = 1:20
    name = allnames{1,i};
    frame = imread(name);
    writeVideo(aviobj,frame);
end
close(aviobj)
