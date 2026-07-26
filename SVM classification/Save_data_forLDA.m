function [ output_args ] = Save_data_forLDA( training,method)
%这个函数是根据LDA源程序对于word_image矩阵的存储要求，将原来的word_image矩阵存储为LDA能接受的形式。
% 格式（.dat文件）：[M] [term_1]:[count] [term_2]:[count] ...  [term_N]:[count]
%   Detailed explanation goes here
%   image_num这个数组记录了每个输入图像集合含有的图像个数
%   image_scene_index记录训练影像每张真实场景类别编号
%   training=1——训练阶段；training=0——测试阶段
%   method=1——使用第一种方法利用LDA，即所有影像公用一个LDA模型。method=2——使用第二种方法利用LDA;对于测试数据，其值为0


if training==1
%     [file,path]=uigetfile('train_word_image_matrix.mat','请选择训练图像的数据文件'); 
%     filename=strcat(path, '\', file);%合并文件路径名
    load train_word_image_matrix.mat;
    %load train_wordimagematrix_metadata.mat;
%     word_image_matrix=full(word_image_matrix);
    word_image_matrix=train_word_image_matrix;
    switch  method
        case 1
            doc_range_start=1;
            [word_num doc_range_end]=size(word_image_matrix);
            file_name=strcat('train-data','.dat');
            file=fopen(file_name,'w+');
            for i=doc_range_start:doc_range_end
                sum_word=sum(word_image_matrix(:,i)~=0); %统计的word_index中有几个非零
                fprintf(file,'%d',sum_word);
                for ii=1:word_num
                    temp=word_image_matrix(ii,i);
                    word_index=ii-1; %保留c语言的特色，编号从零开始
                    if temp ~= 0
                        fprintf(file,'\40%d:%d',word_index,temp);
                    end
                end        
                fprintf(file,'\n');
            end
            fclose(file);
        case 2
            class_num=size(image_num2,2);
            word_num=size(word_image_matrix,1);
            doc_range_end=0;    
            doc_range_start=doc_range_end+1;
            for a=1:class_num
                file_name=strcat('training_data',num2str(a),'.dat');
                file=fopen(file_name,'w+');
                doc_range_end=doc_range_end+image_num(1,a);
                for i=doc_range_start:doc_range_end
                    sum_word=sum(word_image_matrix(:,i)~=0); %统计的word_index中有几个非零
                    fprintf(file,'%d',sum_word);
                    for ii=1:word_num
                        temp=word_image_matrix(ii,i);
                        word_index=ii-1; %保留c语言的特色，编号从零开始
                        if temp ~= 0
                            fprintf(file,'\40%d:%d',word_index,temp);
                        end
                    end        
                    fprintf(file,'\n');
                end
                fclose(file);
                doc_range_start=doc_range_end+1;
            end    
    end

else
%     [file,path]=uigetfile('test_word_image_matrix.mat','请选择测试图像的数据文件'); 
%     filename=strcat(path, '\', file);%合并文件路径名
    load test_word_image_matrix.mat;
    %load testwordimagematrix_metadata.mat; 
%     word_image_matrix=full(word_image_matrix);
    word_image_matrix=test_word_image_matrix;
    doc_range_start=1;
    [word_num doc_range_end]=size(word_image_matrix);
    file_name=strcat('test-data','.dat');
    file=fopen(file_name,'w+');
    for i=doc_range_start:doc_range_end
        sum_word=sum(word_image_matrix(:,i)~=0); %统计的word_index中有几个非零
        fprintf(file,'%d',sum_word);
        for ii=1:word_num
            temp=word_image_matrix(ii,i);
            word_index=ii-1; %保留c语言的特色，编号从零开始
            if temp ~= 0
                fprintf(file,'\40%d:%d',word_index,temp);
            end
        end        
        fprintf(file,'\n');
    end
    fclose(file);
    
end

