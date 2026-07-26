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

% datapath='E:\experiment\shenzhen\slic\NEW\caiyang\cy_all.txt';
% fid=fopen(datapath,'r');
% count=1;
% cyinfo=zeros(20704,5);
% cyinfo=string(cyinfo);
% while ~feof(fid)
%      str = fgetl(fid);
%      count
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split(',');
%          fid1=str(1);
%          fid1=str2num(fid1)+1;
%          fid1=num2str(fid1);
%          id=str(7);
%          label=str(10);
%          sublongg=str(4);
%          sublatt=str(5);
%          sublong=sprintf('%.8f',sublongg);
%          sublat=sprintf('%.8f',sublatt);
%          if(str2num(sublong)==0)
%              sublongg=str(12);
%              sublatt=str(13);
%              sublong=sprintf('%.8f',sublongg);
%              sublat=sprintf('%.8f',sublatt);
%          end
%          cyinfo(count,1)=fid1;
%          cyinfo(count,2)=id;
%          cyinfo(count,3)=label;
%          cyinfo(count,4)=sublong;
%          cyinfo(count,5)=sublat;
%          count=count+1;
%      end
% end
% fclose(fid);
% data=csvread('E:\experiment\shenzhen\slic\NEW\newfeature\feapoi.csv');
% datanew=zeros(6910,17);
% for i=1:20704
%     i
%     id=str2num(cyinfo(i,2));
%     label=str2num(cyinfo(i,3));
%     if label==12
%         label=5;
%     end
%     if label==3
%         label=9;
%     end
% %     part=zeros(1,19);
% %     for k=1:4
% %         part=part(1,:)+data(i,(3+(k-1)*19):(2+k*19));
% %     end
% %     datanew(id,3:end)=datanew(id,3:end)+ part;
%     datanew(id,3:end)=datanew(id,3:end)+ data(i,3:end);
%     datanew(id,1)=id;
%     datanew(id,2)=label;
% end
% dataf=zeros(4205,17);
% count=1;
% for i=1:6910
%     if(datanew(i,2)~=0)
%         if(sum(datanew(i,3:end)~=0))
%             dataf(count,1:end)=datanew(i,1:end);
%             count=count+1;
%         end
%     end
% end


% hist='E:\experiment\shenzhen\slic\NEW\newfeature\feature_allnew.mat';
% hist = load(hist);
% hist=cell2mat(struct2cell(hist));
% histnew=[hist(1:6183,1:2),hist(1:6183,2050:end)];
% label=hist(1:6183,2);
% label(label==12)=5;
% histnew(:,2)=label;
% histf=zeros(5100,163);
% count=1;
% for i=1:6183
%     if(sum(histnew(i,3:end)~=0))
%         histf(count,1:163)=histnew(i,1:end);
%         count=count+1;
%     end
% end

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

% path1='E:\experiment\shenzhen\slic\NEW\newfeature\feature_allnew.mat';
% fea1 = load(path1);
% fea1=cell2mat(struct2cell(fea1));
% for i=1:100
%     i
%     path_all='E:\experiment\shenzhen\slic\NEW\fstm\visualmutual-0.3';
%     train_other=sprintf('%s\\info\\train_other-%d.mat',path_all,i);
%     info1=load(train_other);
%     info1=cell2mat(struct2cell(info1));
%     id1=info1(:,3);
%     test_other=sprintf('%s\\info\\test_other-%d.mat',path_all,i);
%     info2=load(test_other);
%     info2=cell2mat(struct2cell(info2));
%     id2=info2(:,3);
%     train_word_image_matrix=fea1(id1,3:2210);
%     training_name=sprintf('%s\\data_train\\train_word_image_matrix-%d.mat',path_all,i);
%     save(training_name,'train_word_image_matrix');   
%     test_word_image_matrix=fea1(id2,3:2210);
%     testing_name=sprintf('%s\\data_test\\test_word_image_matrix-%d.mat',path_all,i);
%     save(testing_name,'test_word_image_matrix');
% end


% path1='E:\experiment\shenzhen\slic\NEW\newfeature\feature_all.mat';
% path2='E:\experiment\shenzhen\slic\NEW\newfeature\jj_poi_poihe_gat.mat';
% fea1 = load(path1);
% fea1=cell2mat(struct2cell(fea1));
% fea2 = load(path2);
% fea2=cell2mat(struct2cell(fea2));
% fea_visual=fea1(:,1:2050);
% fea_all=zeros(6183,2210);
% for i=1:6183
%     id=fea1(i,1);
%     index=find(fea1(:,1)==id);
%     index1=find(fea2(:,1)==id);
%     if((index1-0)~=0)
%         fea_all(index1,2051:end)=fea2(index,3:end-1);
%     end
%     fea_all(index,1:2050)=fea_visual(index,1:2050);
% end

% 
% data=csvread('C:\Users\urs\Downloads\10553964_深圳市.csv\10553964_深圳市.csv');
% path='E:\experiment\shenzhen\slic\NEW\poinew\poiori_all_se2.mat';
% fea=load(path);
% fea=cell2mat(struct2cell(fea));
% la=[];
% for i=1:24
%     e=find(fea(:,2)==i);
%     h=length(e);
%     la=[la;h];
% end

% path1='E:\experiment\shenzhen\slic\NEW\newfeature\fea_jj_poi_poihe.mat';
% fea=load(path1);
% fea=cell2mat(struct2cell(fea));
% path2='E:\experiment\shenzhen\slic\NEW\newfeature\jjhe.mat';
% jj=load(path2);
% jj=cell2mat(struct2cell(jj));
% path3='E:\experiment\shenzhen\slic\NEW\newfeature\poihe_new.mat';
% poi=load(path3);
% poi=cell2mat(struct2cell(poi));
% feall=[fea(:,(1:92)),poi(:,(2:end)),jj(:,(2:end)),fea(:,end)];
% label=fea(:,end);
% label(label==12)=5;
% label(label==3)=9;
% feajj=[fea(:,(1:77)),label];
% feapoi=[fea(:,1),label,fea(:,(78:92))];
% feajjh=[fea(:,1),jj(:,(2:end)),label];
% feapoih=[fea(:,1),poi(:,(2:end)),label];


% path1='C:\Users\urs\Desktop\visualresult.mat';
% label1=load(path1);
% label1=cell2mat(struct2cell(label1));
% path2='C:\Users\urs\Desktop\visualid.mat';
% id=load(path2);
% id=cell2mat(struct2cell(id));
% labelnew=zeros(6183,3);
% for i=1:100
%     labelnew(:,1)=id(:,1);
%     labelnew(:,2)=label1(:,1);
%     labelnew(:,3)=label1(:,3*i)+labelnew(:,3);
% end
% labelnew(:,3)=round(labelnew(:,3)/100);
% labelall=zeros(6183,2);
% for i=1:6183
%     labelall(i,1)=labelnew(i,1);
%     labelall(i,2)=labelnew(i,2);
%     if(labelnew(i,3)==4||labelnew(i,3)==5)
%         if(labelnew(i,2)==4||labelnew(i,2)==5)
%             labelall(i,2)=labelnew(i,3);
%         end 
%     end
% end

% path='E:\experiment\shenzhen\slic\NEW\jj_hmd\txt';
% child_dir = dir(path);
% feaall=zeros(20704,103);
% for i=3:19
%     i
%     name=string(child_dir(i).name);
%     name=fullfile(path,'\',name);
%     fid=fopen(name,'r');
%     str = fgetl(fid);
%     while ~feof(fid)
%          str = fgetl(fid);
%          if(isempty(str)~=1)
%              str=string(str);
%              str=str.split(',');
%              id=str2num(str(2))+1;
%              x1=str2num(str(5));
%              x2=str2num(str(6));
%              x3=str2num(str(7));
%              x4=str2num(str(8));
%              x5=str2num(str(9));
%              x6=str2num(str(10));
%              feaall(id,1)=id;
%              feaall(id,((i-2)+1))=x1;
%              feaall(id,((i-2)+18))=x2;
%              feaall(id,((i-2)+35))=x3;
%              feaall(id,((i-2)+52))=x4;
%              feaall(id,((i-2)+69))=x5;
%              feaall(id,((i-2)+86))=x6;
%          end
%     end
%     fclose(fid);
% end
% for i=1:6
%     sub=feaall(:,((i-1)*17+2):(i*17+1));
%     sub=Gener(sub);
%     feaall(:,((i-1)*17+2):(i*17+1))=sub;
% end
% 
% 
% function [result] = Gener(mat)
% row=size(mat,1);
% for i=1:row
%     sumrowi=sum(mat(i,:));
%     mat(i,:)=ceil(100*mat(i,:)/sumrowi);
% %     maxrowi=max(mat(i,:));
% %     minrowi=min(mat(i,:));
% %     if(minrowi~=0)
% %         mat(i,:)=(mat(i,:)-minrowi)/(maxrowi-minrowi)*100;
% %     end
% end
% result=mat;
% end

% col=size(mat,2);
% for i=1:col
% %     sumrowi=sum(mat(i,:));
% %     mat(i,:)=ceil(30*mat(i,:)/sumrowi);
%     maxcoli=max(mat(:,i));
%     mincoli=min(mat(:,i));
%     if(maxcoli~=0)
%         mat(:,i)=(mat(:,i)-mincoli)/(maxcoli-mincoli);
%     end
% end

% result=mat;
% end

% path='E:\experiment\shenzhen\slic\NEW\poinew\poiori_all_se2.mat';
% fea=load(path);
% fea=cell2mat(struct2cell(fea));
% in=find(fea(:,2)==0);
% x=length(in);
% label=csvread('E:\experiment\shenzhen\slic\NEW\label.csv');
% poiall=zeros(6913,9);
% for i=1:6913
%     i
%     indexlabel=find(label(:,1)==i);
%     if((indexlabel/1)~=0)
%         labeli=label(indexlabel,2);
%     end
%     index=find(fea(:,1)==i);
%     subfea=fea(index,:);
%     info=[];
%     for j=1:7
%         e=find(subfea(:,2)==j);
%         h=length(e);
%         info=[info,h];
%     end
%     poiall(i,1)=i;
%     poiall(i,2)=labeli;
%     sumi=sum(info);
% %     if(sumi~=0)
% %         info=ceil(info/sumi*10);
% %     end
%     poiall(i,3:end)=info;
% end
% 

% path='E:\experiment\shenzhen\slic\NEW\poi_pure.mat';
% fea=load(path);
% fea=cell2mat(struct2cell(fea));
% sumall=[];
% maxmin=[];
% numall=zeros(12,17);
% for i=1:16
%     sumi=sum(fea(:,i));
%     sumall=[sumall,sumi];
%     maxi=max(fea(:,i));
%     mini=min(fea(:,i));
%     maxmin=[maxmin;maxi,mini];
% end
% for i=1:6910
%     label=fea(i,2);
%     if(label~=0)
%         numall(label,1:16)=numall(label,1:16)+fea(i,:);
%         numall(label,17)=numall(label,17)+1;
%     end
% end
% for i=1:12
%     nummean(i,:)=numall(i,:)/numall(i,17);
% end



% path='E:\experiment\shenzhen\slic\NEW\visual_pure.mat';
% fea=load(path);
% fea=cell2mat(struct2cell(fea));
% hist1='E:\experiment\shenzhen\slic\patch_spe_sift.mat';
% hist1 = load(hist1);
% hist1=cell2mat(struct2cell(hist1));
% for i=1:6183
%     id=fea(i,1);
%     index=find(hist1(:,2)==id);
%     fea(i,2)=hist1(index,1);
% end

% path='E:\experiment\shenzhen\slic\NEW\jjfea_num_per.mat';
% fea=load(path);
% fea=cell2mat(struct2cell(fea));
% col=[];
% for i=1:66
%     sumi=sum(fea(:,i));
%     if(sumi~=0)
%         col=[col;i];
%     end
% end
% feanew=fea(:,col);
% img=imread('E:\experiment\syw\label.tif');
% img1=imresize(img,[18608 21673],'bicubic');
% enviwrite(uint8(img1(1:18608,1:21673))',21673,18608,1,'labelnew');

% data=csvread('E:\experiment\shenzhen\slic\NEW\poi.csv');


% jjfea=load('E:\experiment\shenzhen\slic\NEW\feature_final_19_new.mat');
% jjfea=cell2mat(struct2cell(jjfea));
% jjindex=load('E:\experiment\shenzhen\slic\NEW\jj_index.mat');
% jjindex=cell2mat(struct2cell(jjindex));
% jjfeature=zeros(20016,20);
% for i=1:20016
%     index=jjindex(i);
%     jjfeature(i,1)=index-1;
%     fea=jjfea(index,2:77);
%     subfeature=zeros(1,19);
%     for x=1:4
%         subfeature(1,:)=subfeature(1,:)+fea(1,(1+(x-1)*19):(x*19));
%     end
%     subfeature=ceil(subfeature/4);
%     jjfeature(i,2:20)=subfeature;
% end


% img_dir = 'E:\experiment\shenzhen\slic\jiejing_result\img';
% data_out= 'E:\experiment\shenzhen\slic\jiejing_result\img_ori\result';
% datapath='E:\experiment\shenzhen\slic\NEW\caiyang\cy_ori.txt';
% fid=fopen(datapath,'r');
% count=1;
% longlat=zeros(15904,2);
% longlat=string(longlat);
% while ~feof(fid)
%      str = fgetl(fid);
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split(',');
%          sublongg=str(4);
%          sublatt=str(5);
%          sublong=sprintf('%.8f',sublongg);
%          sublat=sprintf('%.8f',sublatt);
%          longlat(count,1)=sublong;
%          longlat(count,2)=sublat;
%          count=count+1;
%      end
% end
% fclose(fid);
% % long=xlsread('E:\experiment\shenzhen\slic\NEW\caiyang\cy_ori.xlsx','b2:b15905');
% % lat=xlsread('E:\experiment\shenzhen\slic\NEW\caiyang\cy_ori.xlsx','c2:c15905');
% child_dir = dir(img_dir);
% child_numfiles = size(child_dir,1);
% count=0;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(img_dir,child_dir_name, '*.png'));
%     num_files = size(fnames,1);   
%     for i=1:num_files
%         i
%         str=fnames(i).name;
%         index=string(str);
%         index=index.split('_');
%         sublong=index(1);
%         sublat=index(2);
%         sublong=sprintf('%.8f',sublong);
%         sublat=sprintf('%.8f',sublat);
%         subindex=find(longlat==sublong);
%         if(longlat(subindex,2)==sublat)
%             path_in=fullfile(img_dir,"\",child_dir_name,"\",str);
%             path_out=fullfile(data_out);
%             copyfile(path_in,path_out);
%             count=count+1;
%         end
%     end
% end


% nocy=xlsread('E:\experiment\shenzhen\slic\NEW\caiyang\final_nocy.xlsx','a2:a981');
% file1='E:\experiment\shenzhen\parcel_color';
% file2='E:\experiment\shenzhen\slic\parcelall';
% filenames1=zeros(6366,1);
% filenames2=zeros(6183,1);
% child_dir1 = dir(file1);
% child_numfiles1 = size(child_dir1,1);
% count=1;
% for x = 3:child_numfiles1
%     child_dir_name = child_dir1(x).name;
%     fnames = dir(fullfile(file1,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         subfile = fnames(y).name;
%         str=string(subfile);
%         str=str.split('.');
%         str=str(1);
%         filenames1(count)=str2num(str);
%         count=count+1;
%     end
% end
% child_dir2 = dir(file2);
% child_numfiles2 = size(child_dir2,1);
% count=1;
% for x = 3:child_numfiles2
%     child_dir_name = child_dir2(x).name;
%     fnames = dir(fullfile(file2,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         subfile = fnames(y).name;
%         str=string(subfile);
%         str=str.split('.');
%         str=str(1);
%         str=str.split('_');
%         str=str(2);
%         filenames2(count)=str2num(str);
%         count=count+1;
%     end
% end



% poi_dir = 'E:\experiment\shenzhen\slic\poiall';
% id=xlsread('E:\experiment\shenzhen\sz_gt.xlsx','Sheet9','a1:a6366');
% label=xlsread('E:\experiment\shenzhen\sz_gt.xlsx','Sheet9','c1:c6366');
% labelnew=zeros(6257,3);
% child_dir = dir(poi_dir);
% child_numfiles = size(child_dir,1);
% count=1;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(poi_dir,child_dir_name, '*.mat'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         child_dir_name = child_dir(x).name;
%         fnames = dir(fullfile(poi_dir,child_dir_name, '*.mat'));
%         poifile = fnames(y).name;
%         str=string(poifile);
%         str=str.split('.');
%         str=str(1);
%         str=str2num(str);
%         index=find(id==str);
%         labelnew(count,1)=label(index);
%         labelnew(count,2)=str;
%         labelnew(count,3)=index;
%         count=count+1;
%     end
% end
% labelnew=sortrows(labelnew,3);
% 
% labelnew=load('E:\experiment\shenzhen\slic\labelnew.mat');
% labelnew=cell2mat(struct2cell(labelnew));
% spe=load('E:\experiment\shenzhen\spe\str_6500\ucm_msd_H_100.mat');
% spe=cell2mat(struct2cell(spe));
% sift=load('E:\experiment\shenzhen\sift\str_6500\ucm_msd_H_100.mat');
% sift=cell2mat(struct2cell(sift));
% poi=load('E:\experiment\shenzhen\slic\poiall_new.mat');
% poi=cell2mat(struct2cell(poi));
% index=labelnew(:,3);
% feature_spe=spe(index,:);
% feature_sift=sift(index,:);
% feature=[labelnew(:,1),labelnew(:,2),feature_spe,feature_sift];
% % feature=[poi(:,1),poi(:,2),poi(:,3:end),poi(:,3:end),poi(:,3:end),poi(:,3:end),poi(:,3:end),poi(:,3:end),poi(:,3:end)];
% feature_path='E:\experiment\shenzhen\slic\patch_spestr100_siftstr100.mat';
% save(feature_path,'feature');


% A=[1,2,3,4,5,6];
% B=[1,2,3,4,5,6,7,8,9];
% C=[1;3;5;7;9;11];
% D=[1;2;3;4;5;6;7;8;9];
% result0=intersect(A(1,:),B(1,:));
% result1=intersect(C(:,1),D(:,1));


% matinfo=load('E:\experiment\shenzhen\slic\poiall.mat');
% matinfo=cell2mat(struct2cell(matinfo));
% sumall=sum(matinfo);
% 
% poi_dir = 'E:\experiment\shenzhen\slic\poi_new';
% sizeall=zeros(6258,14);
% child_dir = dir(poi_dir);
% child_numfiles = size(child_dir,1);
% countall=[];
% for x = 3:child_numfiles
%     x
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(poi_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     count=0;
%     for y = 1:num_files
%         child_dir_name = child_dir(x).name;
%         fnames = dir(fullfile(poi_dir,child_dir_name, '*.tif'));
%         poifile = fnames(y).name;
%         poidir = poi_dir +"\"+ child_dir_name;
%         filepath=fullfile(poidir,poifile);
%         img=imread(filepath); 
%         e = find(img==1); 
%         h = length(e);  
%         count=count+h;
%     end
%     countall=[countall,count];
% end

% I=imread('E:\experiment\18pd\ocrnew\segcolor\img\17.tif');
% I=rgb2gray(I);
% figure;imshow(I,[]);title('Original Image');
% sobelBW=edge(I,'sobel');
% figure;imshow(sobelBW,[]);title('sobel');


% 
% image_dir = 'E:\experiment\shenzhen\newlabel'; 
% data_out='E:\experiment\shenzhen\sz_ocr';
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% count = 2000;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.png'));
%     num_files = size(fnames,1);   
%     for i=1:num_files
%         i
%         str=fnames(i).name;
%         if(strcmp(str,'img.png')==1)
%             path_in=fullfile(image_dir,"\",child_dir_name,"\",str);
%             name=sprintf('%d_ori.png',count);
%             path_out=fullfile(data_out,'\',name);
%             copyfile(path_in,path_out);
%         end
%         if(strcmp(str,'label.png')==1)
%             path_in=fullfile(image_dir,"\",child_dir_name,"\",str);
%             name=sprintf('%d_label.png',count);
%             path_out=fullfile(data_out,'\',name);
%             copyfile(path_in,path_out);
%              continue;
%         end
%     end
%     count=count+1;
% end


% img_dir = 'E:\experiment\shenzhen\slic\img';
% data_out= 'E:\experiment\shenzhen\slic\imgnew';
% child_dir = dir(img_dir);
% child_numfiles = size(child_dir,1);
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(img_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);   
%     for i=1:num_files
%         str=fnames(i).name;
%         path_in=fullfile(img_dir,"\",child_dir_name,"\",str);
%         img=imread(path_in);  
%         [row col band]=size(img);
%         gray1=mean(mean(img(:,:,1)));
%         gray2=mean(mean(img(:,:,2)));
%         gray3=mean(mean(img(:,:,3)));
%         if(row>=8&&col>=8)
%             if(gray1>0&&gray2>0&&gray3>0)
%                 path_out=fullfile(data_out,'\',child_dir_name);
%                 if(exist(path_out,'dir')==0)
%                     mkdir(path_out);
%                 end
%                 copyfile(path_in,path_out);
%             end
%         end
%     end
% end

% image_dir = 'E:\experiment\shenzhen\slic\imgnew'; 
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% filenames = cell(6258,1);
% childdir=cell(6258,1);
% imagebasedir = cell(6258,1);
% count=1;
% count1=1;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     childdir{count1}=child_dir_name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     count1=count1+1;
%     for y = 1:num_files
%         filenames{count} = fnames(y).name;
%         imagebasedir{count} = image_dir +"/"+ child_dir_name;
%         count=count+1;
%     end
% end
% 
% img_dir = 'E:\experiment\shenzhen\slic\test';
% data_in = 'E:\experiment\shenzhen\slic\imgnew';
% data_out= 'E:\experiment\shenzhen\slic\test';
% child_dir = dir(img_dir);
% child_numfiles = size(child_dir,1);
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(img_dir,child_dir_name, '*.mat'));
%     num_files = size(fnames,1);   
%     for i=1:num_files
%         i
%         str=fnames(i).name;
%         index=string(str);
%         index=index.split('.');
%         index=index(1);
%         
%         index=index.split('_');
%         file=index(1);
%         sub=index(2);
%         path_in=sprintf("%s\\%s\\%s_%s.tif",data_in,file,file,sub);
%         
%         path_in=fullfile(img_dir,"\",child_dir_name,"\",str);
%         path_out=fullfile(data_out,'\',child_dir_name);
%         
%         movefile(path_in,path_out);
%         
%         if(exist(path_out,'dir')==0)
%             mkdir(path_out);
%         end
%         idx=find(strcmp(childdir,index));
%         if(idx~=0)
%             copyfile(path_in,path_out);
%         end
%     end
% end

% img1=imread('C:\Users\urs\Desktop\carbon\data\lulc\10\tif2.tif');
% img2=imread('C:\Users\urs\Desktop\carbon\data\lulc\05\tif1.tif');
% imgnew=img1-img2;
% x=find(imgnew~=0);

% load('C:\Users\urs\Desktop\carbon\data\lulc\00_05_10.mat'); 
% imgnew=img(:,:,2)-img(:,:,1);
% x=find(imgnew~=0);
% enviwrite(uint8(imgnew(1:5164,1:5123))',5123,5164,1,'imgnew');
% 
% filename='C:\Users\urs\Desktop\carbon\data\lulc\00lulc_30.txt';
% filename1='C:\Users\urs\Desktop\carbon\data\lulc\05lulc_30.txt';
% filename2='C:\Users\urs\Desktop\carbon\data\lulc\10lulc_30.txt';
% fid=fopen(filename,'r');
% fid1=fopen(filename1,'r');
% fid2=fopen(filename2,'r');
% count=1;
% img=zeros(5164,5123,3);
% while ~feof(fid)
%      str = fgetl(fid);
%      str1 = fgetl(fid1);
%      str2 = fgetl(fid2);
%      if(isempty(str)~=1)
% %         disp(str);
%          if(count>6)
%              count
% %            disp(str);
%            str=string(str);
%            str1=string(str1);
%            str2=string(str2);
%            str=strtrim(str);
%            str1=strtrim(str1);
%            str2=strtrim(str2);
%            split0=str.split(' ');
%            split1=str1.split(' ');
%            split2=str2.split(' ');
%            col=size(split0);
%            for i=1:col
% %                i
%                label0=split0(i);
%                label1=split1(i);
%                label2=split2(i);
%                label0=str2num(split0(i));
%                label1=str2num(split1(i));
%                label2=str2num(split2(i));
%                img(count-6,i,1)=label0;
%                img(count-6,i,2)=label1;
%                img(count-6,i,3)=label2;
%            end
%          end
%          count=count+1;
%      end
% end
% save('C:\Users\urs\Desktop\carbon\data\lulc\00_05_10.mat','img');
% fclose(fid);
% fclose(fid1);
% fclose(fid2);

% data1=zeros(168,145);
% data2=zeros(168,145);
% data3=zeros(168,145);
% for U=2:169
% U
% str=['A',num2str(U),':','EO',num2str(U)];
% data1(U-1,:)=xlsread('C:\Users\urs\Desktop\carbon\data\carbonchange.xlsx','00',str);
% data2(U-1,:)=xlsread('C:\Users\urs\Desktop\carbon\data\carbonchange.xlsx','05',str);
% end
% data3=data2-data1;
% enviwrite(uint8(data3(1:168,1:145))',145,168,1,'data3');

% data1=zeros(168,145);
% data2=zeros(168,145);
% data3=zeros(168,145);
% for U=2:169
% U
% str=['A',num2str(U),':','EO',num2str(U)];
% data1(U-1,:)=xlsread('C:\Users\urs\Desktop\carbon\data\carbonchange.xlsx','05',str);
% data2(U-1,:)=xlsread('C:\Users\urs\Desktop\carbon\data\carbonchange.xlsx','10',str);
% end
% 
% data3=data2-data1;
% x=find(data3==0)
% y=find(data2==-9999)

% sum1=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','e2:e1323');
% sum2=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','f2:f1323');
% sum3=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','g2:g1323');
% sum4=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','h2:h1323');
% sum5=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','i2:i1323');
% sum6=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','j2:j1323');
% sum7=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','k2:k1323');
% sum8=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','l2:l1323');
% sum9=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','m2:m1323');
% sum11=xlsread('E:\experiment\18pd\result\result.xlsx','Sheet1','o2:o1323');
% sumall=[sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum11];
% for i=1:10
%     maxi=max(sumall(:,i));
%     mini=min(sumall(:,i));
%     for j=1:1322
%         sumall(j,i)=(sumall(j,i)-mini)/(maxi-mini);
%     end
% end

% image_dir = 'E:\experiment\shenzhen\ocr_parcel'; 
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% filenames = cell(6910,1);
% imagebasedir = cell(6910,1);
% landcover=zeros(6910,12);
% count = 1;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         filenames{count} = fnames(y).name;
%         imagebasedir{count} = image_dir +"\"+ child_dir_name;
%         imgpath=image_dir +"\"+ child_dir_name+"\"+fnames(y).name;
%         name=string(fnames(y).name);
%         index=name.split('.');
%         index=str2num(index(1,1));
%         img=imread(imgpath);
%         for m=1:13
%             e=find(img==m);
%             h=length(e);
%             landcover(index,m)=h;
%         end
%         count=count+1;
%     end
% end


% image_dir = 'E:\experiment\shenzhen\parcel_color'; 
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% filenames = cell(6366,1);
% imagebasedir = cell(6366,1);
% id = xlsread('E:\experiment\shenzhen\sz_gt.xlsx','Sheet9','a1:a6366');
% labelall=xlsread('E:\experiment\shenzhen\sz_gt.xlsx','Sheet9','c1:c6366');
% base_dir='E:\experiment\shenzhen\sz_class';
% for i=1:12
%     data_dir=sprintf('%s\\%d',base_dir,i);
%     if(exist(data_dir)==0)
%         mkdir(data_dir);
%     end
% end
% count = 1;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         y
%         filenames{count} = fnames(y).name;
%         imagebasedir{count} = image_dir +"\"+ child_dir_name;
%         imgpath=image_dir +"\"+ child_dir_name+"\"+fnames(y).name;
%         name=string(fnames(y).name);
%         index=name.split('.');
%         index=str2num(index(1,1));
%         indexlabel=find(id==index);
%         label=labelall(indexlabel);
%         data=sprintf('%s\\%d',base_dir,label);
%         copyfile(imgpath,data);
%     end
% end


% data='E:\experiment\18pd\fstm\speori_siftori_ocr-0.5\info';
% save_path='E:\experiment\18pd\fstm\speori_siftori_ocr-0.5\ocr';
% ocr_path='E:\experiment\18pd\ocrnew\seg\ucm_msd_H_1000.mat';
% ocr=load(ocr_path);
% ocr=cell2mat(struct2cell(ocr));
% 
% for i=1:100
%     i   
%     train_all_path=sprintf('%s\\train_other-%d.mat',data,i);
%     test_all_path=sprintf('%s\\test_other-%d.mat',data,i);
%     
%     train_all=load(train_all_path);
%     test_all=load(test_all_path);
%     train_all=cell2mat(struct2cell(train_all));
%     test_all=cell2mat(struct2cell(test_all));
%     
%     row_train=size(train_all,1);
%     row_test=size(test_all,1);  
%     train_word_image_matrix=zeros(row_train,1000);
%     test_word_image_matrix=zeros(row_test,1000);
%     
%     for j=1:row_train
%         index=train_all(j,3);
%         train_word_image_matrix(j,:)=ocr(index,:);
%     end
%     
%     for j=1:row_test
%         index=test_all(j,3);
%         test_word_image_matrix(j,:)=ocr(index,:);
%     end
%     
%     train=sprintf('%s\\data_train\\train_word_image_matrix-%d.mat',save_path,i);
%     test=sprintf('%s\\data_test\\test_word_image_matrix-%d.mat',save_path,i);
%     save(train,'train_word_image_matrix');
%     save(test,'test_word_image_matrix');
% end

% image_dir = 'C:\Users\urs\Desktop\output3(1)';   
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% filenames = cell(420,1);  
% imagebasedir = cell(420,1);
% ocr=zeros(420,100,100); 
% count = 1;
% %读取数据路径
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.png'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         filenames{count} = fnames(y).name;
%         imagebasedir{count} = image_dir +"\"+ child_dir_name;
%         count = count + 1;
%     end
% end
% imageFileList=filenames;
% numall=length(imageFileList);
% 
% for f = 1:numall
%     f
%     base_dir = imagebasedir{f};
%     imageFName = imageFileList{f};
%     [dirN base] = fileparts(imageFName);
%     indexall=string(base);
%     indexall=indexall.split('_');
%     index=indexall(1);
%     index=str2num(index);
%     index
%     baseFName = [dirN filesep base];
%     imageFName = string(fullfile(base_dir, imageFName));
% 
%     img=imread(imageFName);
%     ocr(index,:,:)=img; 
% end
% imgall=zeros(2000,2100);
% 
% for i=1:20 
%     i
%     for j=1:21
%         imgall((((i-1)*100+1):i*100),(((j-1)*100+1):j*100))=ocr((i-1)*21+j,:,:);
%     end
% end
% enviwrite(uint8(imgall(1:2000,1:2100))',2100,2000,1,'xm');

% img=imread('C:\Users\urs\Desktop\hy\tif3.tif');
% [row col band]=size(img);
% index_1=761;
% index_2=926;
% index_3=8763;
% index_4=7426;
% % for i=1:row
% %     for j=1:col
% %         if(img(i,j,1)==9)
% %             if(i>=index_3)
% %                 index_3=i;
% %             end
% %             if(j>=index_4)
% %                 index_4=j;
% %             end
% %             if(i<=index_1)
% %                 index_1=i;
% %             end
% %             if(j<=index_2)
% %                 index_2=j;
% %             end
% %         end
% %     end
% % end
% img1=img(index_1:index_3,index_2:index_4,:);
% img2=img1(4:8003,2:6501,:);
% [row col band]=size(img2);
% img3=zeros(row,col);
% img3=img2(:,:,1);
% imwrite(img3,'C:\Users\urs\Desktop\result1.jpg');

% img=imread('C:\Users\urs\Desktop\hy\tif3.tif');
% [row col]=size(img);
% index_1=761;
% index_2=926;
% index_3=8763;
% index_4=7426;
% img1=img(index_1:index_3,index_2:index_4);
% img2=img1(4:8003,2:6501);
% [row col]=size(img2);
% countl=[];
%  for m = 1:100
%     e = find(img2==m); 
%     h = length(e);
%     countl =[countl,h];
% end  
% img3=img2(:,:);
% img3=double(img3)+128;
% img3=uint8(img3);
% countr=[];
%  for m = 129:229
%     e = find(img3==m); 
%     h = length(e);
%     countr =[countr,h];
% end  
% imwrite(img3,'C:\Users\urs\Desktop\result1.png');
% img4=imread('C:\Users\urs\Desktop\result1.png');
% countr=[];
%  for m = 129:229
%     e = find(img4==m); 
%     h = length(e);
%     countr =[countr,h];
% end  

% img=imread('C:\Users\urs\Desktop\hyahf\result1.jpg');
% [row col]=size(img);
% amount=zeros(255,1);
% for i=1:row
%     for j=1:col
%         amount(img(i,j),1)=amount(img(i,j),1)+1;
%     end
% end

% clc;
% clear all;
% 
% mat_dir = 'C:\Users\urs\Desktop\ahf_exp\pdahf\socm_out'; 
% child_dir = dir(mat_dir);   
% child_numfiles = size(child_dir,1);
% filenames = cell(664,1);
% matbasedir = cell(664,1);
% count=1;
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(mat_dir,child_dir_name, '*.mat'));
%     num_files = size(fnames,1);
%     for y = 1:num_files
%         filenames{count} = fnames(y).name;
%         matbasedir{count} = mat_dir +"\"+ child_dir_name;
%         count = count + 1;
%     end
% end
% matFileList=filenames;
% numall=length(matFileList);
% feature_out=cell(numall,1);
% 
% for f = 1:numall
%     f
%     base_dir = matbasedir{f};
%     matFName = matFileList{f};
%     [dirN base] = fileparts(matFName);
%     baseFName = [dirN filesep base];
%     matFName = string(fullfile(base_dir, matFName));
%     part=matFName.split('\');
%     num=str2num(base(3:end-4));
%     index=str2num(part(8));
% 
% 
%     load(matFName);
%     row=size(features,1);
%     feature=[];
%     for x=1:row
%         feature=[feature,features(x,1),features(x,2)];
%     end  
%     count=[];
%     count=[num,index,feature];
%     feature_out{f}=count;
%     out_dir='C:\Users\urs\Desktop\ahf_exp\pdahf\feature_out.mat';
%     save(out_dir,'feature_out');
% end
