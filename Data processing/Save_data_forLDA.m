function [ output_args ] = Save_data_forLDA( training)
%这个函数是根据LDA源程序对于word_image矩阵的存储要求，将原来的word_image矩阵存储为LDA能接受的形式。
% 格式（.dat文件）：[M] [term_1]:[count] [term_2]:[count] ...  [term_N]:[count]
%   Detailed explanation goes here
%   image_num这个数组记录了每个输入图像集合含有的图像个数
%   image_scene_index记录训练影像每张真实场景类别编号
%   training=1——训练阶段；training=0——测试阶段
%   method=1——使用第一种方法利用LDA，即所有影像公用一个LDA模型。method=2——使用第二种方法利用LDA;对于测试数据，其值为0
% 

cd 'E:\experiment\shenzhen\slic\NEW\fstm';
training=1;


% cd 'E:\experiment\shenzhen\fstm\spe_sift_ocr-0.3\spe\data_test';
% training=0;
% % 
% cd 'E:\experiment\shenzhen\fstm\spe_sift_ocr-0.3\sift\data_train';
% training=1;

for i=1:1
    i
    if training==1
        matname=sprintf('train_word_image_matrix-%d.mat',i);
        load(matname);
    %        word_image_matrix=full(word_image_matrix);
    %         train_word_image_matrix = train_word_image_matrix';

    %         word_image_matrix=train_data';
    %         x=train_data;

            word_image_matrix=train_word_image_matrix';
            x=train_word_image_matrix;

                doc_range_start=1;
                [word_num doc_range_end]=size(word_image_matrix);
                file_name=sprintf('train_word_image_matrix-%d.dat',i);
                file=fopen(file_name,'w+');
                for i=doc_range_start:doc_range_end%循环1-13107
                    sum_word=sum(word_image_matrix(:,i)~=0); %统计的word_index中有几个非零
                    fprintf(file,'%d',sum_word);
                    for ii=1:word_num
                       % temp=word_image_matrix(ii,i);

    %                     temp=train_word_image_matrix(i,ii);

                        temp=x(i,ii);

                        % temp=round(tem*1000)/1000;
                        %word_index=ii-1; %保留c语言的特色，编号从零开始
                        word_index=ii;
                        if temp ~= 0
                            fprintf(file,'\40%d:%d',word_index,temp);
                        end
                    end        
                    fprintf(file,'\n');
                end
                fclose(file);  
%                 clear;
    else
        matname=sprintf('test_word_image_matrix-%d.mat',i);
        load(matname);
    %     word_image_matrix=full(word_image_matrix);
    %  test_word_image_matrix=test_word_image_matrix';

    %  word_image_matrix=test';
    %  x=test;

     word_image_matrix=test_word_image_matrix';
     x=test_word_image_matrix;

        doc_range_start=1;
        [word_num doc_range_end]=size(word_image_matrix);%取行列
        file_name=sprintf('test_word_image_matrix-%d.dat',i);
        file=fopen(file_name,'w+');
        for i=doc_range_start:doc_range_end
            sum_word=sum(word_image_matrix(:,i)~=0); %统计的word_index中有几个非零
            fprintf(file,'%d',sum_word);
            for ii=1:word_num

    %             temp=gyh(i,ii);
                temp=x(i,ii);

                % temp=round(tem*1000)/1000;
                word_index=ii; %保留c语言的特色，编号从零开始
                if temp ~= 0
                    fprintf(file,'\40%d:%d',word_index,temp);
                end
            end        
            fprintf(file,'\n');
        end
        fclose(file);
%         clear;

    end

end


