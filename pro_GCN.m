clc;
clear all;

datapath='E:\experiment\shenzhen\slic\NEW\caiyang\cy_all.txt';
fid=fopen(datapath,'r');
count=1;
cyinfo=zeros(20704,5);
cyinfo=string(cyinfo);
while ~feof(fid)
     str = fgetl(fid);
     count
     if(isempty(str)~=1)
         str=string(str);
         str=str.split(',');
         fid1=str(1);
         fid1=str2num(fid1)+1;
         fid1=num2str(fid1);
         id=str(7);
         label=str(10);
         sublongg=str(4);
         sublatt=str(5);
         sublong=sprintf('%.8f',sublongg);
         sublat=sprintf('%.8f',sublatt);
         if(str2num(sublong)==0)
             sublongg=str(12);
             sublatt=str(13);
             sublong=sprintf('%.8f',sublongg);
             sublat=sprintf('%.8f',sublatt);
         end
         cyinfo(count,1)=fid1;
         cyinfo(count,2)=id;
         cyinfo(count,3)=label;
         cyinfo(count,4)=sublong;
         cyinfo(count,5)=sublat;
         count=count+1;
     end
end
fclose(fid);

% featurepath='E:\experiment\shenzhen\slic\NEW\pyGAT-master\result\poinew+jjhe_0.6046\852.txt';
% fid=fopen(featurepath,'r');
% feature_gat=zeros(20016,256);
% count=1;
% while ~feof(fid)
%      str = fgetl(fid);
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split(' ');
% %          for x=1:16
% %              feature_gat(count,x)=str2num(str(x));
% %          end
% %          for x=17:32
% %              feature_gat(count,x-16)=feature_gat(count,x-16)+str2num(str(x));
% %          end
% 
%          for x=1:256
%              feature_gat(count,x)=str2num(str(x));
%          end
%          count=count+1;
%      end
% end
% fclose(fid);

% 
% jjindex=load('E:\experiment\shenzhen\slic\NEW\jj_index.mat');
% jjindex=cell2mat(struct2cell(jjindex));
% jjindex=jjindex-1;
% jjfeature=zeros(20016,33);
% jjfeature(:,1)=jjindex;
% jjfeature(:,2:33)=feature_gat()


% feature_gat=load('E:\experiment\shenzhen\slic\NEW\newfeature\fea_jj_poi_poihenew_jjhe_gat1.mat');
% feature_gat=cell2mat(struct2cell(feature_gat));
% feature_gat=feature_gat(:,:);
% 
% path='E:\experiment\shenzhen\slic\NEW\finalindex.mat';
% finalindex=load(path);
% finalindex=cell2mat(struct2cell(finalindex));
% 
% feature_final=zeros(6910,258);
% for i=1:20016
%     id=finalindex(i,1);
%     id_parcel=cyinfo(id,2);
%     id_parcel=str2num(id_parcel);
%     label=cyinfo(id,3);
%     feature_final(id_parcel,1)=id_parcel;
%     feature_final(id_parcel,2)=str2num(label);
%     for x=1:256
%         feature_final(id_parcel,(x+2))=feature_final(id_parcel,(x+2))+feature_gat(i,x);
%     end
% end
% 
% path1='C:\Users\urs\Desktop\gatlabel_new.mat';
% labelnew=load(path1);
% labelnew=cell2mat(struct2cell(labelnew));
% % index0=cyinfo(:,2);
% for i=1:5201
%     id=labelnew(i,1);
%     index=find(feature_final(:,1)==id);
%     feature_final(index,2)=labelnew(i,2);
% end


feature_gat=load('E:\experiment\shenzhen\slic\NEW\newfeature\fea_jj_poi_poihenew_jjhe.mat');
feature_gat=cell2mat(struct2cell(feature_gat));
feature_gat=feature_gat(:,:);

path='E:\experiment\shenzhen\slic\NEW\finalindex.mat';
finalindex=load(path);
finalindex=cell2mat(struct2cell(finalindex));

feature_final=zeros(6910,279);
for i=1:20016
    id=finalindex(i,1);
    id_parcel=cyinfo(id,2);
    id_parcel=str2num(id_parcel);
    label=cyinfo(id,3);
    feature_final(id_parcel,1)=id_parcel;
    feature_final(id_parcel,2)=str2num(label);
    for x=1:277
        feature_final(id_parcel,(x+2))=feature_final(id_parcel,(x+2))+feature_gat(i,(x+1));
    end
end

path1='C:\Users\urs\Desktop\gatlabel_new1.mat';
labelnew=load(path1);
labelnew=cell2mat(struct2cell(labelnew));
% index0=cyinfo(:,2);
for i=1:5194
    id=labelnew(i,1);
    index=find(feature_final(:,1)==id);
    feature_final(index,2)=labelnew(i,2);
end


% path1='E:\experiment\shenzhen\slic\NEW\feature_final_19_new';
% feature_gat=load(path1);
% feature_gat=cell2mat(struct2cell(feature_gat));
% path='E:\experiment\shenzhen\slic\NEW\finalindex.mat';
% finalindex=load(path);
% finalindex=cell2mat(struct2cell(finalindex));
% 
% feature_pure=zeros(6910,35);
% feature_poi=zeros(6910,16);
% feature_jj=zeros(6910,21);
% for i=1:20016
%     id=finalindex(i,1);
%     id_parcel=cyinfo(id,2);
%     id_parcel=str2num(id_parcel);
%     label=cyinfo(id,3);
%     feature_pure(id_parcel,1)=id_parcel;
%     feature_pure(id_parcel,2)=str2num(label);
%     for x=1:4
%         feature_pure(id_parcel,3:21)=feature_pure(id_parcel,3:21)+feature_gat(i,((x-1)*19+2):(x*19+1));
%     end
%     feature_pure(id_parcel,22:35)=feature_gat(i,78:91);
%     
    
%     feature_poi(id_parcel,1)=id_parcel;
%     feature_poi(id_parcel,2)=str2num(label);
%     feature_jj(id_parcel,1)=id_parcel;
%     feature_jj(id_parcel,2)=str2num(label);
%     feature_poi(id_parcel,3:end)=feature_gat(i,78:91);
%     for x=1:4
%         feature_jj(id_parcel,3:21)=feature_jj(id_parcel,3:21)+feature_gat(i,((x-1)*19+2):(x*19+1));
%     end
%     feature_jj(id_parcel,35)=feature_jj(id_parcel,35)+1;
% end




% count0=0;
% for k=1:6910
%     if(sum(feature_final(k,3:34))==0)
%         count0=count0+1;
%     end
% end

% image_dir = 'E:\experiment\shenzhen\slic\parcel_0.3_0.2_0.5\ub\traintest'; 
% 
% child_dir = dir(image_dir);   
% child_numfiles = size(child_dir,1);
% filenames = cell(3088,1);
% imagebasedir = cell(3088,1);
% count = 1;
% traintestname=zeros(3088,1);
% traintestname=string(traintestname);
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         subname = fnames(y).name;
%         subname=string(subname);
%         subname=subname.split('.');
%         traintestname(count,1)=subname(1);
%         count=count+1;
%     end
% end
% 
% image_dir = 'E:\experiment\shenzhen\slic\parcel_0.3_0.2_0.5\ub\valall'; 
% 
% child_dir = dir(image_dir);   
% child_numfiles = size(child_dir,1);
% filenames = cell(3095,1);
% imagebasedir = cell(3095,1);
% count = 1;
% valname=zeros(3095,1);
% valname=string(valname);
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         subname = fnames(y).name;
%         subname=string(subname);
%         subname=subname.split('.');
%         valname(count,1)=subname(1);
%         count=count+1;
%     end
% end
% 
% finalindex=zeros(20016,1);
% 
% path='E:\experiment\shenzhen\slic\NEW\feature_final_19_new.mat';
% feature=load(path);
% feature=cell2mat(struct2cell(feature));
% out=fopen('C:\Users\urs\Desktop\test.txt','w');
% count=1;
% 
% for i=1:3088
%     id=traintestname(i,1);
%     index=find(cyinfo(:,2)==id);
%     for k=1:size(index,1)
%         if(feature(index(k,1),1)~=0)
%            finalindex(count,1)=index(k,1);
%            count=count+1;
%         end
%     end
% end
% 
% for i=1:3095
%     id=valname(i,1);
%     index=find(cyinfo(:,2)==id);
%     for k=1:size(index,1)
%         if(feature(index(k,1),1)~=0)
%            finalindex(count,1)=index(k,1);
%            count=count+1;
%         end
%     end
% end

