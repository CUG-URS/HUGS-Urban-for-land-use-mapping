
function [ output_args ] = SceneResult(  )
    %%对具有重叠度的大影像进行可视化显示，评价是利用ENVI中的ROI进行基于像素的评价

    %准备数据
    load syw_pd.mat;
%     load testclass_result.mat;
%     load testing_patch_metadata.mat;
    sceneresult=test_result(:,1)'+1;
    
%     image_scale=150;
%     image_overlap=50;
%     row_smallimagenum=82;
%     column_smallimagenum=61;  
    image_scale=200;
    image_overlap=100;
    row_smallimagenum=91;
    column_smallimagenum=131;  

    %%生成场景类分类结果矩阵：
    %分为奇偶4层存放拓展为的image_scale*image_scale的小影像的分类结果，便于后期处理重叠区域的场景类别
    %第一层奇行奇列的小影像，第二层奇行偶列的小影像，第三层偶行奇列的小影像，第四层偶行偶列的小影像，
    set_image_height=(image_scale-image_overlap)*(row_smallimagenum-1)+image_scale;
    set_image_width=(image_scale-image_overlap)*(column_smallimagenum-1)+image_scale;
    sceneresult_matrix=zeros(set_image_height,set_image_width,4); 
    sceneresult_overlap_matrix=zeros(set_image_height,set_image_width,5);%为确定重叠区域位置而设，最后一层统计重叠次数

    temp_small_image=ones(image_scale,image_scale);
    image_index=1;
    final_result_map=zeros(row_smallimagenum,column_smallimagenum); %没有还原为image_scale*image_scale图块大小时，最终结果的分布图
    for i=1:column_smallimagenum
        temp_start_col = (image_scale-image_overlap)*(i-1)+1;%计算当前小影像左上角像素在大影像中的行号
        parity_current_col=3-mod(i,2)*2;%偶数为3，奇数为1
        for ii=1:row_smallimagenum
            image_index
            temp_SI_scene=sceneresult(1,image_index);
            final_result_map(i,ii)=temp_SI_scene;        
            temp_small_image=temp_SI_scene*temp_small_image; %预先不进行颜色拉升，等重叠区域处理完了再讨论

            %计算当前小图块左上角像素在大影像中的列号
            temp_start_row = (image_scale-image_overlap)*(ii-1)+1;
            %判定奇偶性，分层存储:
            %第一层奇行+奇列=1；  第二层奇行+偶列=2；第三层偶行+奇列=3；第四层偶行+偶列=4；
            parity_current_row=1-mod(ii,2);%偶数为1，奇数为0
            level_index = parity_current_row + parity_current_col;
            sceneresult_matrix( (temp_start_row:(temp_start_row+image_scale-1)), (temp_start_col:(temp_start_col+image_scale-1)), level_index )=temp_small_image;

            temp_small_image=ones(image_scale,image_scale);
            sceneresult_overlap_matrix( (temp_start_row:(temp_start_row+image_scale-1)), (temp_start_col:(temp_start_col+image_scale-1)), level_index )=temp_small_image;

            image_index=image_index+1;
        end
    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         


    %%处理重叠区域的场景类别归属问题:

    %可能存在的重叠矩形的边界大小:从小到大排列
    value=sort( [image_scale-2*image_overlap  image_overlap  image_scale-image_overlap] );
    value1=value(1,1);
    value2=value(1,2);
    value3=value(1,3);
    %统计重叠次数
    sceneresult_overlap_matrix(:,:,5)=sum( sceneresult_overlap_matrix(:,:,1:4), 3 );
    temp_overlap=sceneresult_overlap_matrix(:,:,5);
    sceneFinalresult=zeros(size(temp_overlap)); %记录考虑重叠度后的分类结果
    overlap_matrix=temp_overlap;
    save('small_Image_overlap_matrix.mat','overlap_matrix');
    clear sceneresult_overlap_matrix; %清除不用的大数据，清理内存
    clear overlap_matrix;
    
    %第一幅小影像的处理
    %计算重叠区域块的大小，其内所有数值相同
    overlap_patch_start_row=1;%左上角在原始大影像中的编号
    overlap_patch_start_col=1;
    overlap_patch_end_row=value3;%右下角编号在原始大影像中的编号
    overlap_patch_end_col=value3;
    %选取初始重叠区域
    current_overlap_patch=temp_overlap( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col );
    overlap_patch_row_scale=0;%重叠区域纵向宽度的起始值
    overlap_patch_col_scale=0;%重叠区域横向宽度的起始值
    %判断匀质区域大小
    [overlap_patch_row_scale,overlap_patch_col_scale] = Judge_overlapPatch(current_overlap_patch, value1,value2,value3);
    %生成最终匀质考虑区域
    overlap_patch_end_row=overlap_patch_start_row+overlap_patch_row_scale-1;%右下角编号在原始大影像中的编号
    overlap_patch_end_col=overlap_patch_start_col+overlap_patch_col_scale-1;
    current_patch = sceneresult_matrix( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col, : );
    current_overlap_patch=temp_overlap( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col );
    %为了进行类别决策，分别记录左边和上面的邻近区域的场景类别
    up_class=0;
    left_class=0;
    %确定当前匀质区域的类别
    [class_patch] = Process_overlapPatch(current_patch, current_overlap_patch,overlap_patch_row_scale,overlap_patch_col_scale,up_class,left_class);
    sceneFinalresult(overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col)=class_patch;
    %计算下一个重叠区域块的起始大小，从上到下，从左往右分析：先只变列号，等一行完成了再变行号
    %overlap_patch_start_row=overlap_patch_end_row+1;
    overlap_patch_start_col=overlap_patch_end_col+1;%左上角在原始大影像中的编号
    overlap_patch_end_row=overlap_patch_start_row+value3-1;  %右下角编号在原始大影像中的编号, 
    overlap_patch_end_col=overlap_patch_start_col+value3-1;
    
    while (overlap_patch_end_row<=set_image_height) && (overlap_patch_end_col<=set_image_width)

        %选取初始重叠区域
        current_overlap_patch=temp_overlap( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col );
        overlap_patch_row_scale=0;%重叠区域纵向宽度的起始值
        overlap_patch_col_scale=0;%重叠区域横向宽度的起始值
        %判断匀质区域大小
        [overlap_patch_row_scale,overlap_patch_col_scale] = Judge_overlapPatch(current_overlap_patch, value1,value2,value3);
        %生成最终匀质考虑区域
        overlap_patch_end_row=overlap_patch_start_row+overlap_patch_row_scale-1;%右下角编号在原始大影像中的编号
        overlap_patch_end_col=overlap_patch_start_col+overlap_patch_col_scale-1;
        
        current_patch = sceneresult_matrix( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col, : );
        current_overlap_patch=temp_overlap( overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col );
        %为了进行类别决策，分别记录左边和上面的邻近区域的场景类别
        if overlap_patch_start_row==1
            up_class=0;
        else
            up_class=sceneFinalresult(overlap_patch_start_row-1,overlap_patch_start_col);            
        end
        if overlap_patch_start_col==1
            left_class=0;
        else
            left_class=sceneFinalresult(overlap_patch_start_row,overlap_patch_start_col-1);
       end        
        %确定当前匀质区域的类别
        [class_patch] = Process_overlapPatch(current_patch, current_overlap_patch,overlap_patch_row_scale,overlap_patch_col_scale,up_class,left_class);
        sceneFinalresult(overlap_patch_start_row:overlap_patch_end_row, overlap_patch_start_col:overlap_patch_end_col)=class_patch;
        %计算下一个重叠区域块的起始大小，从上到下，从左往右分析：先只变列号，等一行完成了再变行号
        if overlap_patch_end_col==set_image_width %另起一行开始搜索
            overlap_patch_start_row=overlap_patch_end_row+1;
            overlap_patch_start_col=1;
            overlap_patch_end_row=overlap_patch_start_row+value3-1;%右下角编号在原始大影像中的编号
            overlap_patch_end_col=overlap_patch_start_col+value3-1;
        else
            %overlap_patch_start_row=overlap_patch_end_row+1;
            overlap_patch_start_col=overlap_patch_end_col+1;%左上角在原始大影像中的编号
            overlap_patch_end_row=overlap_patch_start_row+value3-1;  %右下角编号在原始大影像中的编号, 
            overlap_patch_end_col=overlap_patch_start_col+value3-1;
        end            
        
    end
    
    save('sceneFinalresult.mat','sceneFinalresult');
%     imwrite(sceneFinalresult,'sceneFinalresult_overlap.tif','tif');
   enviwrite(uint8(sceneFinalresult(1:9100,1:13100))',13100,9100,1,'syw_pd');
end
   
   %判断当前patch是否是匀质区域
function [overlap_patch_row_scale,overlap_patch_col_scale]=Judge_overlapPatch(current_overlap_patch, value1,value2,value3)
    overlap_patch_row_scale=value3; %起始尺寸
    overlap_patch_col_scale=value3;
    if current_overlap_patch( 1, 1) ~= current_overlap_patch( overlap_patch_row_scale, 1 ) || current_overlap_patch( 1, 1) ~= current_overlap_patch( 1, overlap_patch_col_scale )
        if current_overlap_patch( 1, 1) ~= current_overlap_patch( overlap_patch_row_scale, 1 )
            overlap_patch_row_scale=value2;%左下角编号
        end
        if current_overlap_patch( 1, 1) ~= current_overlap_patch( 1, overlap_patch_col_scale )
            overlap_patch_col_scale=value2;%右上角编号
        end
        %再?闻卸鲜遣皇窃戎是?
        if current_overlap_patch( 1, 1) ~= current_overlap_patch( overlap_patch_row_scale, 1 ) || current_overlap_patch( 1, 1) ~= current_overlap_patch( 1, overlap_patch_col_scale )
            if current_overlap_patch( 1, 1) ~= current_overlap_patch( overlap_patch_row_scale, 1 )
                overlap_patch_row_scale=value1;%左下角编号
            end
            if current_overlap_patch( 1, 1) ~= current_overlap_patch( 1, overlap_patch_col_scale )
                overlap_patch_col_scale=value1;%右上角编号
            end
            %获得匀质区域了（可能值5,6,7,8,9）
        else
            %获得匀质区域了 （可能值2,3,4）
        end      
    else
        %获得匀质区域了 （可能值1）
    end
end
    

function [class_patch error1]=Process_overlapPatch(current_patch, current_overlap_patch,overlap_patch_row_scale,overlap_patch_col_scale,up_class,left_class)
    %%处理匀质区域，确定它的场景类别
    switch current_overlap_patch(1,1) %重叠的区域个数
        case 1
            class_patch=sum(current_patch,3);
        case 2
            [row col]=find(current_patch(1,1,:));
            class1=current_patch(1,1,col(1,1));
            class2=current_patch(1,1,col(2,1));
            if  class1 == class2 
                class_patch=sum(current_patch,3)/2;
            else
                %如果两者不统一，咨询上面或左边的相邻区域，因为他们已经确定了类别
                if overlap_patch_row_scale >= overlap_patch_col_scale
                    %竖着的矩形，应该咨询左边那位兄弟
                    class3=left_class;
                    [c t]=mode([class1 class2 class3 ]);
                    if t==1
                        %引入参考信息都确定不了，就随便啦！
                        class=class1;
                    else
                        class=c;
                    end
                else %横着的矩形，应该咨询睡在上铺的兄弟
                    class3=up_class;
                    [c t]=mode([class1 class2 class3 ]);
                    if t==1
                        %引入参考信息都确定不了，就随便啦！
                        class=class1;
                    else
                        class=c;
                    end
                end
                class_patch=class*ones(size(current_overlap_patch));
            end
        case 4 
            [class times]=mode(current_patch(1,1,:));
            if times==1 %当重叠块分属于四个不同类别时，随机决定它的归属
                r=randperm(4);
                class=r(1,1);
            end
            class_patch=class*ones(size(current_overlap_patch));
    end
end
