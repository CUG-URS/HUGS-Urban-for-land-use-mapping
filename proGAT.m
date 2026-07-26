clc;
clear all;



% datapath='C:\Users\urs\Desktop\pyGAT-master\data\cora\cora_content.txt';
% fid=fopen(datapath,'r');
% count=1;
% sumall=zeros(2708,1);
% while ~feof(fid)
%      str = fgetl(fid);
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split('	');
%          index=find(str(2:1434)=='1');
%          sumall(count,1)=size(index,1);
%          count=count+1;
%      end
% end
% maxnum=max(sumall);
% fclose(fid);

%街景采样点信息
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

%训练测试集目录
image_dir = 'E:\experiment\shenzhen\slic\parcel_0.3_0.2_0.5\ub\traintest'; 

child_dir = dir(image_dir);   
child_numfiles = size(child_dir,1);
filenames = cell(3088,1);
imagebasedir = cell(3088,1);
count = 1;
traintestname=zeros(3088,1);
traintestname=string(traintestname);
for x = 3:child_numfiles
    child_dir_name = child_dir(x).name;
    fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
    num_files = size(fnames,1);
    for y = 1:num_files
        y
        subname = fnames(y).name;
        subname=string(subname);
        subname=subname.split('.');
        traintestname(count,1)=subname(1);
        count=count+1;
    end
end

%验证集目录
image_dir = 'E:\experiment\shenzhen\slic\parcel_0.3_0.2_0.5\ub\valall'; 

child_dir = dir(image_dir);   
child_numfiles = size(child_dir,1);
filenames = cell(3095,1);
imagebasedir = cell(3095,1);
count = 1;
valname=zeros(3095,1);
valname=string(valname);
for x = 3:child_numfiles
    child_dir_name = child_dir(x).name;
    fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
    num_files = size(fnames,1);
    for y = 1:num_files
        y
        subname = fnames(y).name;
        subname=string(subname);
        subname=subname.split('.');
        valname(count,1)=subname(1);
        count=count+1;
    end
end
% 
% % 
% data=csvread('E:\experiment\CNN\results\new\feature.csv');
% label=csvread('E:\experiment\shenzhen\slic\NEW\label.csv');
% feature_visual=zeros(6183,2049);
% allname=[traintestname;valname];
% for i=1:6183
%     id=str2num(allname(i));
%     index=find(label(:,1)==id);
%     feature_visual(i,1)=id;
%     feature_visual(i,2)=label(index,2);
%     feature_visual(i,3:end)=data(i,:);
% end
% % path1='E:\experiment\shenzhen\slic\NEW\jj_pure';
% % jj=load(path1);
% % jj=cell2mat(struct2cell(jj));
% % path2='E:\experiment\shenzhen\slic\NEW\poinew\poiall_one.mat';
% % poi=load(path2);
% % poi=cell2mat(struct2cell(poi));
% path2='E:\experiment\shenzhen\slic\NEW\newfeature\jj_poi_poihe_gat';
% gat=load(path2);
% gat=cell2mat(struct2cell(gat));
% for i=1:6183
%     id=str2num(allname(i));
%     index=find(label(:,1)==id);
%     feature_visual(i,1)=id;
%     feature_visual(i,2)=label(index,2);
%     feature_visual(i,3:end)=data(i,:);
% end
% feature_all=zeros(6183,2209);
% for i=1:6183
%     i
%     id=feature_visual(i,1);
%     label=feature_visual(i,2);
%     feature_all(i,1)=id;
%     feature_all(i,2)=label;
% %     index1=find(jj(:,1)==id);
% %     index2=find(poi(:,1)==id);
%     feature_all(i,3:2049)=feature_visual(i,3:2049);
% %     if(index1-0~=0)
% %         feature_all(i,2050:2068)=jj(index1,3:end);
% %     end
% %     if(index2-0~=0)
% %         feature_all(i,2069:2089)=poi(index2,3:end);
% %     end
%     index1=find(gat(:,1)==id);
%     feature_all(i,3:2049)=feature_visual(i,3:2049);
%     if(index1-0~=0)
%         feature_all(i,2050:2209)=gat(index1,3:(end-1));
%     end
% end
% poi=csvread('E:\experiment\shenzhen\slic\NEW\poi.csv');
% jj=csvread('E:\experiment\shenzhen\slic\NEW\jj.csv');
% pfea=Gener(poi(:,2:15));
% jfea=Gener(jj(:,2:18));
% poi(:,1)=poi(:,1)+1;
% jj(:,1)=jj(:,1)+1;
% poi(:,2:15)=pfea;
% jj(:,2:18)=jfea;
% path='E:\experiment\shenzhen\slic\NEW\fea_jj_poi_poihe.mat';
% feature=load(path);
% feature=cell2mat(struct2cell(feature));
% path1='E:\experiment\shenzhen\slic\NEW\poihemidu\poihe_20704.mat';
% feature1=load(path1);
% feature1=cell2mat(struct2cell(feature1));
% feature_new=[];
% for i=1:20704
%     i
%     fid=jj(i,1);
%     label=feature(i,end);
%     index=find(poi(:,1)==fid);
%     if((index/1)~=0)
%         fea=[poi(index,:),jj(i,2:18),label];
%     else
%         fea=[fid,zeros(1,14),jj(i,2:18),label];
%     end
%     feature_new=[feature_new;fea];
% end


%多源特征-街景-poi-poi核密度-街景核密度
pathx='E:\experiment\shenzhen\slic\NEW\newfeature\fea_jj_poi_poihenew_jjhe.mat';
feature=load(pathx);
feature=cell2mat(struct2cell(feature));

path1='C:\Users\urs\Desktop\gatlabel_new1_1.mat';
labelnew=load(path1);
labelnew=cell2mat(struct2cell(labelnew));
% index0=cyinfo(:,2);
for i=1:5194
    id=labelnew(i,1);
    index=find(cyinfo(:,2)==string(id));
    feature(index,end)=labelnew(i,2);
end

xx=isnan(feature);
feature(xx)=0;

% index=find(feature(:,end)==12);
% feature(index,end)=5;

%写出到文本文档用于生成后续的图
out=fopen('C:\Users\urs\Desktop\test.txt','w');
strall=[];
% 
for i=1:3088
    id=traintestname(i,1);
    index=find(cyinfo(:,2)==id);
    for k=1:size(index,1)
        if(feature(index(k,1),1)~=0)
            str=feature(index(k,1),:);
%             subfeature=zeros(1,19);
%             for x=1:4
%                 subfeature(1,:)=subfeature(1,:)+feature(index(k,1),(2+(x-1)*19):(x*19+1));
%             end
%             subfeature=ceil(subfeature/3);
%             for y=1:19
%                 str=str+' '+ string(subfeature(1,y));
%             end
%             for z=78:92
%                 str=str+' '+ string(feature(index(k,1),z));
%             end
%             strall=[str,num2str(index(k,1));strall];
            for ii=1:279
                fprintf(out,'%d',str(ii));
                fprintf(out,' ');
            end
%             fprintf(out,'%s',str);
            fprintf(out,'\n');
        end
    end
end

for i=1:3095
    id=valname(i,1);
    index=find(cyinfo(:,2)==id);
    for k=1:size(index,1)
        if(feature(index(k,1),1)~=0)
            str=feature(index(k,1),:);
%             subfeature=zeros(1,19);
%             for x=1:4
%                 subfeature(1,:)=subfeature(1,:)+feature(index(k,1),(2+(x-1)*19):(x*19+1));
%             end
%             subfeature=ceil(subfeature/3);
%             for y=1:19
%                 str=str+' '+ string(subfeature(1,y));
%             end
%             for z=78:92
%                 str=str+' '+ string(feature(index(k,1),z));
%             end
%             strall=[str,num2str(index(k,1));strall];
            for ii=1:279
                fprintf(out,'%d',str(ii));
                fprintf(out,' ');
            end
%             fprintf(out,'%s',str);
            fprintf(out,'\n');
        end
    end
end


% for i=1:20704
%     i
%     if(feature(i,1)~=0)
%         str=string(feature(i,1));
%         subfeature=zeros(1,19);
%         for x=1:4
%             subfeature(1,:)=subfeature(1,:)+feature(i,(2+(x-1)*19):(x*19+1));
%         end
%         subfeature=ceil(subfeature/3);
%         for y=1:19
%             str=str+' '+ string(subfeature(1,y));
%         end
%         for z=78:92
%             str=str+' '+ string(feature(i,z));
%         end
%         fprintf(out,'%s\r\n',str);
%     end
% end

% 
% path='E:\experiment\shenzhen\slic\NEW\poi_jj_fea.mat';
% feature=load(path);
% feature=cell2mat(struct2cell(feature));
% path='E:\experiment\shenzhen\slic\NEW\name.mat';
% name=load(path);
% name=cell2mat(struct2cell(name));
% out=fopen('C:\Users\urs\Desktop\test1.txt','w');
% for i=1:20081
%     i
%     id0=string(name(i));
%     index0=find(cyinfo(:,1)==id0);
%     id=string(cyinfo(index0,2));
%     index=find(cyinfo(:,2)==id);
%     s=size(index);
%     if(s(1)>1)
%         for j=1:s(1)
%             if(index(j,1)~=i&&feature(index(j,1),1)~=0)
%                 str=cyinfo(index0,1)+' '+cyinfo(index(j,1),1);
%                 fprintf(out,'%s\r\n',str);
%             end
%         end
%     else
%         str=cyinfo(index0,1)+' '+cyinfo(index0,1);
%         fprintf(out,'%s\r\n',str);
%     end
% end


% datapath='E:\experiment\shenzhen\slic\NEW\poinew\poi_ori.txt';
% fid=fopen(datapath,'r','l','UTF-8');
% count=1;
% poiinfo=zeros(691482,2);
% poiinfo=string(poiinfo);
% while ~feof(fid)
%      str = fgetl(fid);
%      count
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split(',');
%          id=str2num(str(6));
%          label=str(12);
% 
%          poiinfo(count,1)=id;
%          poiinfo(count,2)=label;
%          count=count+1;
%      end
% end
% fclose(fid);
% poilabel=unique(poiinfo(:,2));
% poi=zeros(691482,2);
% for i=1:691482
%     i
%     id=poiinfo(i,1);
%     label=poiinfo(i,2);
%     indextrue=strfind(poilabel,label);
%     idx = find([indextrue{:}] == 1);
%     idx=0;
%     for k=1:1334
%         if(indextrue{k,1}==1)
%             idx=k;
%         end
%     end
%     poi(i,1)=id;
%     poi(i,2)=idx;
% end

% 对兴趣点数据进行重采样
% datapath='E:\experiment\shenzhen\slic\NEW\poinew\cy_100.txt';
% fid=fopen(datapath,'r','l','UTF-8');
% count=1;
% poiinfo=zeros(196685,2);
% % poiinfo=string(poiinfo);
% while ~feof(fid)
%      str = fgetl(fid);
%      count
%      if(isempty(str)~=1)
%          str=string(str);
%          str=str.split(',');
% %          sublongg=str(5);
% %          sublatt=str(6);
%          id=str2num(str(3))+1;
%          one=str(11);
%          two=str(12);
%          three=str(13);
%          
%          switch one
%              case '风景名胜'
%                  if(two=='公园广场')
%                     labeltrue=4;
%                  end
%              case '购物服务'
%                  labeltrue=5;
%              case '交通设施服务'
%                  if(two=='停车场')
%                     labeltrue=11;
%                  end
%              case '科教文化服务'
%                  if(two=='学校')
%                     labeltrue=12;
%                  end
%              case '商务住宅'
%                  if(two=='住宅区')
%                     if(three=='宿舍')
%                         labeltrue=10;
%                     else
%                         labeltrue=14;
%                     end
%                  end
%                  if(two=='楼宇')
%                     labeltrue=8;
%                  end
%                  if(two=='产业园区')
%                     labeltrue=1;
%                  end
%              case '政府机构及社会团体'
%                  labeltrue=13;             
%              case '公司企业'
%                  if(two=='工厂')
%                     labeltrue=2;
%                  end
%                  if(two=='公司')
%                     labeltrue=3;
%                  end
%                  if(two=='公司企业')
%                     labeltrue=6;
%                  end                             
% %              case '医疗保健服务'
% %                  labeltrue=4;             
%              case '地名地址信息'
%                  if(two=='交通地名')
%                     labeltrue=7;
%                  end
%                  if(two=='门牌信息')
%                     labeltrue=9;
%                  end
% %                  if(two=='自然地名')
% %                      if(three=='河流')
% %                         labeltrue=7;
% %                      end
% %                      if(three=='湖泊')
% %                         labeltrue=7;
% %                      end
% %                  end            
%              otherwise
%                  labeltrue=15;    
%          end
% %          sublong=sprintf('%.8f',sublongg);
% %          sublat=sprintf('%.8f',sublatt);
%          poiinfo(count,1)=id;
%          poiinfo(count,2)=labeltrue;
%          count=count+1;
%          
% %          switch label
% %              case '餐饮服务'
% %                  labeltrue=1;
% %              case '风景名胜'
% %                  labeltrue=2;
% %              case '公共设施'
% %                  labeltrue=3;
% %              case '公司企业'
% %                  labeltrue=4;
% %              case '购物服务'
% %                  labeltrue=5;
% %              case '交通设施服务'
% %                  labeltrue=6;
% %              case '金融保险服务'
% %                  labeltrue=7;             
% %              case '科教文化服务'
% %                  labeltrue=8;                 
% %              case '汽车服务'
% %                  labeltrue=9;                     
% %              case '汽车维修'
% %                  labeltrue=10;              
% %              case '商务住宅'
% %                  labeltrue=11;             
% %              case '体育休闲服务'
% %                  labeltrue=12;      
% %              case '政府机构及社会团体'
% %                  labeltrue=13;       
% %              case '住宿服务'
% %                  labeltrue=14;                    
% %              case '医疗保健服务'
% %                  labeltrue=15;  
% %              case '地名地址信息'
% %                  labeltrue=16;  
% %              case '摩托车服务'
% %                  labeltrue=17;  
% %              case '汽车销售'
% %                  labeltrue=18;  
% %              case '生活服务'
% %                  labeltrue=19;  
% %              case '通行设施'
% %                  labeltrue=20;  
% %              case '道路附属设施'
% %                  labeltrue=21;  
% %          end
% %          sublong=sprintf('%.8f',sublongg);
% %          sublat=sprintf('%.8f',sublatt);
% %          poiinfo(count,1)=sublong;
% %          poiinfo(count,2)=sublat;
% %          poiinfo(count,3)=labeltrue;
% %          count=count+1;
%      end
% end
% fclose(fid);
% % 
% feature_final=zeros(20704,99);
% % 
% % 
% file='E:\experiment\shenzhen\slic\jiejing_result\filenames.mat';
% file=load(file);
% filenames=file.filenames;
% mat_dir='E:\experiment\shenzhen\slic\NEW\feature_19_new.mat';
% feature=load(mat_dir);
% feature=cell2mat(struct2cell(feature));
% for i=1:82588
%     i
%     name=filenames{i};
%     name=string(name);
%     name=name.split('_');
%     sublong=name(1);
%     sublat=name(2);
%     angle=str2num(name(3))/90;
%     sublong=sprintf('%.8f',sublong);
%     sublat=sprintf('%.8f',sublat);
%     index=find(cyinfo(:,4)==sublong);
%     if(cyinfo(index,5)==sublat)
%         id=cyinfo(index(1),1);
%         label=cyinfo(index(1),3);
%         id=str2num(id);
%         label=str2num(label);
%         feature_final(id,1)=id;
%         feature_final(id,99)=label;
%         feature_final(id,(2+angle*19):((angle+1)*19+1))=feature(i,:);
%     end
% end
% % 
% % poipath='E:\experiment\shenzhen\slic\NEW\poiinfo_150.mat';
% % poiinfo=load(poipath);
% % poiinfo=struct2cell(cell2mat(poiinfo));
% subinfo=zeros(1,14);
% for x=1:14
%     m=find(poiinfo(:,3)==num2str(x));
%     e=size(m);
%     subinfo(1,x)=e(1);
% end
% 


% path='E:\experiment\shenzhen\slic\NEW\feature_final_19_new.mat';
% feature=load(path);
% feature=cell2mat(struct2cell(feature));
% path='E:\experiment\shenzhen\slic\NEW\poihemidu\poihe_20704_gener.mat';
% feature1=load(path);
% feature1=cell2mat(struct2cell(feature1));
% feature_final=zeros(20704,177);
% for i=1:20704
%     i
%     index=find(poiinfo(:,1)==i);
%     subinfo=zeros(1,15);
%     for x=1:15
%         m=find(poiinfo(index,2)==x);
%         e=size(m);
%         subinfo(1,x)=e(1);
%     end
%     feature_final(i,78:92)=subinfo(1,:);
%     if(feature1(i,1)~=0)
%         feature_final(i,93:176)=feature1(i,2:end);
%     end
%     feature_final(i,177)=feature(i,end);
%     feature_final(i,1:77)=feature(i,1:77);
% %     long=cyinfo(i,4);
% %     lat=cyinfo(i,5);
% %     index=find(poiinfo(:,1)==long);
% %     if(poiinfo(index,2)==lat)
% %         subinfo=zeros(1,21);
% %         for x=1:21
% %             m=find(poiinfo(index,3)==num2str(x));
% %             e=size(m);
% %             subinfo(1,x)=e(1);
% %         end
% %         id=cyinfo(i,1);
% %         id=str2num(id);
% %         feature_final(id,78:98)=subinfo;
% end

% data=csvread('E:\experiment\shenzhen\slic\NEW\visual.csv');
% datanew=Gener(data);
% train_word_image_matrix=data(1:3088,:);
% test_word_image_matrix=data(3089:end,:);


function [result] = Gener(mat)
row=size(mat,1);
for i=1:row
%     sumrowi=sum(mat(i,:));
%     mat(i,:)=ceil(30*mat(i,:)/sumrowi);
    maxrowi=max(mat(i,:));
    minrowi=min(mat(i,:));
    if(minrowi~=0)
        mat(i,:)=(mat(i,:)-minrowi)/(maxrowi-minrowi);
    end
end

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

result=mat;
end

