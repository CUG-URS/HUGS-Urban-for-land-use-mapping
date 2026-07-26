function [ output_args ] = VisualizeandAccess(  )
    %%对具有重叠度的大影像进行可视化显示，评价是利用ENVI中的ROI进行基于像素的评价


    load sceneFinalresult.mat;
    %显示图像
    sceneFinalresult=sceneFinalresult*50;    %对最终分类结果进行线性拉伸，方便彩色显示
    filename='mosaic-1tif.tif';%合并文件路径名
    c23=imread(filename);
    result_image=zeros(size(c23));
    result_image(:,:,1:2)=c23(:,:,1:2);
    height=size(result_image,1);
    width=size(result_image,2);
    result_image(:,:,3)=sceneFinalresult(1:height,1:width);
    result_image=uint8(result_image);
    imwrite(result_image,'sceneview_overlap.tif','tif');

    clear;
    clc;
    load chirp;
    sound(y,Fs);
end

