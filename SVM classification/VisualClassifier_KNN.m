%%为了对大幅影像进行评定采用的分类器
function []=VisualClassifier_KNN(method,K)
    % K表示KNN个数
    % method=1——采用光谱角；method=2——采用欧式距离

    %加载训练图像的元数据'file_n','image_num','all_image_num','cluster_num'
    [file,training_path]=uigetfile('train_wordimagematrix_metadata.mat','请选择测试图像的元数据文件'); 
    filename=strcat(training_path, '\', file);%合并文件路径名
    load(filename);
    scene_num=file_n;
    training_image_num=image_num;
    training_all_image_num=all_image_num;

    %加载测试图像的元数据'file_n','image_num','all_image_num','cluster_num'
    [file,testing_path]=uigetfile('testwordimagematrix_metadata.mat','请选择测试图像的元数据文件'); 
    filename=strcat(testing_path, '\', file);%合并文件路径名
    load(filename);
    testing_image_num=image_num;
    testing_all_image_num=all_image_num;

    %加载γ数据
    training_gamma=load('final.gamma');
    testing_gamma=load('test-gamma.dat');

    %为训练数据附上真实类别编号
    training_real_label=zeros(size(training_gamma,1),1);
    current_label=1;
    change_point=training_image_num(1,current_label);
    for i=1:training_all_image_num
        if i<=change_point
            training_real_label(i,1)=current_label;
        else
            current_label=current_label+1;
            change_point=change_point+training_image_num(1,current_label);
            training_real_label(i,1)=current_label;
        end    
    end
    training_gamma_label=[training_gamma training_real_label]';%转置

    %为测试数据附上真实类别编号
    testing_real_label=zeros(size(testing_gamma,1),1);
    current_label=1;
    change_point=testing_image_num(1,current_label);
    for i=1:testing_all_image_num
        if i<=change_point
            testing_real_label(i,1)=current_label;
        else
            current_label=current_label+1;
            change_point=change_point+testing_image_num(1,current_label);
            testing_real_label(i,1)=current_label;
        end    
    end
    testing_gamma_label=[testing_gamma testing_real_label]';%转置
    
    %KNN_angle分类器
    [n1,m1]=size(training_gamma_label);%训练样本
    [n2,m2]=size(testing_gamma_label);%测试样本
    test_class=[];%记录有KNN分类器分得的类别数
    switch method
        case 1
            for i=1:m2
                t=[];%记录待分点与所有训练样本的距离
                temp=[];%第一行训练样本的正确类别号，第二行记录待分点与所有训练样本的距离。
                t2=testing_gamma_label( 1:(n2-1),i );
                for ii=1:m1
                    t1=training_gamma_label( 1:(n1-1),ii);
                    d=spectral_angle(t1,t2);
                    t=[t d];
                end
                temp=[training_gamma_label(n1,:);t];
                test_class=[test_class Decide_class(K,temp)];
            end            
        case 2
            for i=1:m2
                t=[];%记录待分点与所有训练样本的距离
                temp=[];%第一行训练样本的正确类别号，第二行记录待分点与所有训练样本的距离。
                t2=testing_gamma_label( 1:(n2-1),i );
                for ii=1:m1
                    t1=training_gamma_label( 1:(n1-1),ii);
                    d=Distance(t1,t2);
                    t=[t d];
                end
                temp=[training_gamma_label(n1,:);t];
                test_class=[test_class Decide_class(K,temp)];
            end                     
    end


    %生成类别和真实类别合体
    D_part=[testing_real_label';test_class];
    save('testclass_result.mat','D_part');

end

function [angle]=spectral_angle(t1,t2)
    scalar_product=t1'*t2;
    norm_t1=norm(t1);
    norm_t2=norm(t2);
    angle=acos( scalar_product/(norm_t1*norm_t2));
end

function [dis]=Distance(t1,t2)
    length=size(t1,1);
    dis=0;
        for a=1:length
            t0=( t1(a,1)-t2(a,1) )^2;
            dis=dis+t0;
        end
    dis=sqrt(dis);
end

function [Class]=Decide_class(K,temp)
%只选出其中最小的K个值，不用对所有距离数据进行全排列，减少运算量
n=size(temp,2);
for i=1:K
    for ii=1:(n-i)
        if temp(2,ii)<=temp(2,ii+1)
            t=temp(:,ii+1);
            temp(:,ii+1)=temp(:,ii);
            temp(:,ii)=t;
        end
    end
end
K_temp=(temp(1,(n-K+1):n))';
Class=mode(K_temp);
end