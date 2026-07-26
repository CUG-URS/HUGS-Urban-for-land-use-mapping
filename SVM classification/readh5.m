clear;clc;
path='G:\Dancy\experimenal_results\45class结果\caffe-cnn结果\10%\卷积层\';
filename=strcat(path, '21895train.h5');
hinfo = hdf5info(filename);
conv5 = hdf5read(hinfo.GroupHierarchy.Datasets(1));
[c,d,fea,image_num]=size(conv5);
convtrain=[];
for i=1:image_num
    for f=1:fea
      convtrain(i,f)=mean(mean(conv5(:,:,f,i)));
    end 
end
save cnn_train.mat convtrain;

filename=strcat(path, '21895test.h5');
hinfo = hdf5info(filename);
conv5 = hdf5read(hinfo.GroupHierarchy.Datasets(1));                                                                        
[c,d,fea,image_num]=size(conv5);
convtest=[];
for i=1:image_num
    for f=1:fea
      convtest(i,f)=mean(mean(conv5(:,:,f,i)));
    end  
end

save cnn_test.mat convtest;
