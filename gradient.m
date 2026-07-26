clc;
clear all;

img_dir='E:\experiment\shenzhen\slic\parcel325\325\ub\traintest';
out_dir='E:\experiment\shenzhen\slic\parcel325\325\boost_65536\traintest';

child_dir = dir(img_dir);
child_numfiles = size(child_dir,1);
count = 1;
indextrue=[]
for x = 3:child_numfiles
    child_dir_name = child_dir(x).name;
    fnames = dir(fullfile(img_dir,child_dir_name, '*.tif'));
    num_files = size(fnames,1);
    for y = 1:num_files
        str=string(fnames(y).name);
        str=str.split('.');
        str=str(1).split('_');
        str=str2num(str(2));
        filenames(y)=str;
        filen=sprintf('a_%d.tif',str);
        imgpath=sprintf('%s\\%s\\%s',img_dir,child_dir_name,filen);
        I=imread(imgpath);
        [rowI colI bandI]=size(I);
        if((rowI*colI)>65536)
            outdir=sprintf('%s\\%s',out_dir,child_dir_name);
            outpath=sprintf('%s\\%s\\%d.tif',out_dir,child_dir_name,str);
            if(exist(outdir,'dir')==0)
                mkdir(outdir);
            end
            copyfile(imgpath,outpath);
        else
            I0=zeros(rowI,colI,bandI,6);
            I0(:,:,:,1)=I;
            I0(:,:,:,2)=imrotate(I0(:,:,:,1),45,'nearest','crop');
            w=fspecial('gaussian',[3,3],3);
            I0(:,:,:,3)=imfilter(I0(:,:,:,1),w);

            bandnew=6;
            row=size(I,1);
            col=size(I,2);
            row_new=floor(row*0.70);
            col_new=floor(col*0.70);
            row_start=row-row_new;
            col_start=col-col_new;
            x=randperm(row_start,1);
            y=randperm(col_start,1);
            I_test=I(x:(x+row_new-1),y:(y+col_new-1),:);
            [row col band]=size(I_test);
            gray1=mean(mean(I_test(:,:,1)));
            gray2=mean(mean(I_test(:,:,2)));
            gray3=mean(mean(I_test(:,:,3)));
             if(gray1>0&&gray2>0&&gray3>0)
                I0(1:row_new,1:col_new,:,4)=I_test(:,:,:);
                I0(:,:,:,5)=imrotate(I0(:,:,:,4),45,'nearest','crop');
                I0(:,:,:,6)=imfilter(I0(:,:,:,4),w);
             else
                bandnew=3;
             end
        end

            for k=1:bandnew
                outdir=sprintf('%s\\%s',out_dir,child_dir_name);
                outpath=sprintf('%s\\%s\\%d_%d.tif',out_dir,child_dir_name,str,k);
                if(exist(outdir,'dir')==0)
                    mkdir(outdir);
                end
                imwrite(uint8(I0(:,:,:,k)),outpath);
            end
%         end
    end
end
% 
% 
% indexall='E:\experiment\shenzhen\slic\indexall.mat';
% indexall = load(indexall);
% indexall=cell2mat(struct2cell(indexall));
% hist1='E:\experiment\shenzhen\slic\patch_spe_sift.mat';
% hist1 = load(hist1);
% hist1=cell2mat(struct2cell(hist1));
% 
% txtpath='E:\experiment\shenzhen\slic\result_boost0.5k_best.txt';
% fid=fopen(txtpath,'r');
% count=1;
% label=zeros(6183,1);
% while ~feof(fid)
%      str = fgetl(fid);
%      str=string(str);
%      str=str.split(':');
% %      str1=str(1).split('/');
% %      str1=str1(end);
% %      str1=str1.split('.');
% %      str1=str2num(str1(1));
%      labelpre=str2num(str(2));
%      label(count,1)=labelpre;
%      count=count+1;
% end
% fclose(fid);
% 
% countall=[];
% for m=0:12
%     e=find(label(:)==m)
%     h=length(e);
%     countall=[countall;h];
% end
% 
% % label=label+20;
% % label(label==20)=1;
% % label(label==21)=2;
% % label(label==22)=10;
% % label(label==23)=9;
% % label(label==24)=4;
% % label(label==25)=12;
% % label(label==26)=6;
% % label(label==27)=8;
% % label(label==28)=5;
% % label(label==29)=7;
% 
% % label=label+20;
% % label(label==20)=1;
% % label(label==21)=10;
% % label(label==22)=12;
% % label(label==23)=2;
% % label(label==24)=4;
% % label(label==25)=5;
% % label(label==26)=6;
% % label(label==27)=7;
% % label(label==28)=8;
% % label(label==29)=9;
% 
% 
% % 
% % for m=0:12
% %     e=find(label(:,2)==m)
% %     h=length(e);
% %     countall=[countall;h];
% % end
% 
% % image_dir = 'E:\experiment\shenzhen\slic\parcelpart\valall'; 
% image_dir = 'E:\experiment\shenzhen\slic\parcelall'; 
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% count = 1;
% indextrue=[]
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     x
%     for y = 1:num_files
%         str=string(fnames(y).name);
%         str=str.split('.');
%         str=str(1).split('_');
%         str=str2num(str(2));
% %         str=str2num(str(1));
%         indextrue=[indextrue;str];
%     end
% end
% 
% 
% labeltrue=[];
% sumtrue=0;
% for i=1:6183
%     i
%     indexsub=indextrue(i);
%     index0=find(hist1(:,2)==indexsub);
%     label0=hist1(index0,1);
%     if(label0==label(i))
%         sumtrue=sumtrue+1;
%     end
% %     imgpath=sprintf('%s\\%d.tif',img_dir,indexsub);
% %     I=imread(imgpath);
% %     outdir=sprintf('%s\\%d',out_dir,label0);
% %     outpath=sprintf('%s\\%d\\%d.tif',out_dir,label0,indexsub);
% %     if(exist(outdir,'dir')==0)
% %         mkdir(outdir);
% %     end
% %     copyfile(imgpath,outpath);
% end

% image_dir = 'E:\experiment\shenzhen\slic\parcelall'; 
% % image_dir = 'E:\experiment\shenzhen\slic\parcelori'; 
% out_dir='E:\experiment\shenzhen\slic\parcel325';
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% count = 1;
% indextrue=[];
% 
% label=csvread('E:\experiment\shenzhen\slic\NEW\label.csv');
% path1='C:\Users\urs\Desktop\gatlabel_new1.mat';
% labelnew=load(path1);
% labelnew=cell2mat(struct2cell(labelnew));
% for i=1:5194
%     id=labelnew(i,1);
%     index=find(label(:,1)==id);
%     label(index,2)=labelnew(i,2);
% end
% label((label(:,2)==12),2)=5;
% label=sortrows(label,2);

% base_dir='E:\experiment\shenzhen\slic\parcel325';
% for i=1:11
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
%         index=index(1).split('_');
%         index=index(end);
%         index=str2num(index);
%         indexlabel=find(label(:,1)==index);
%         labeli=label(indexlabel,2);
%         data=sprintf('%s\\%d',base_dir,labeli);
%         copyfile(imgpath,data);
%     end
% end

% 
% image_dir = 'E:\experiment\shenzhen\slic\parcel325\ori'; 
% % image_dir = 'E:\experiment\shenzhen\slic\parcelori'; 
% out_dir='E:\experiment\shenzhen\slic\parcel325\325\ub';
% child_dir = dir(image_dir);
% child_numfiles = size(child_dir,1);
% count = 1;
% indextrue=[];
% 
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     traintest=floor(num_files*0.5);
%     indextraintest=zeros(traintest,1);
%     indexval=zeros(num_files-traintest,1);
%     filenames=zeros(num_files,1);
%     x
%     for y = 1:num_files
%         str=string(fnames(y).name);
%         str=str.split('.');
%         str=str(1).split('_');
%         str=str2num(str(2));
%         filenames(y)=str;
%     end
%     idx=randperm(num_files);
%     indextraintest=filenames(idx(1:traintest));
%     indexval=filenames(idx((traintest+1):end));
%     for xx=1:traintest
%         filen=sprintf('a_%d.tif',indextraintest(xx));
%         imgpath=sprintf('%s\\%s\\%s',image_dir,child_dir_name,filen);
%         outdir=sprintf('%s\\traintest\\%s',out_dir,child_dir_name);
%         outpath=sprintf('%s\\traintest\\%s\\%s',out_dir,child_dir_name,filen);
%         if(exist(outdir,'dir')==0)
%             mkdir(outdir);
%         end
%         copyfile(imgpath,outpath);
%     end
%     for yy=1:size(indexval,1)
%         filen=sprintf('a_%d.tif',indexval(yy));
%         imgpath=sprintf('%s\\%s\\%s',image_dir,child_dir_name,filen);
%         outdir=sprintf('%s\\val\\%s',out_dir,child_dir_name);
%         outpath=sprintf('%s\\val\\%s\\%s',out_dir,child_dir_name,filen);
%         if(exist(outdir,'dir')==0)
%             mkdir(outdir);
%         end
%         copyfile(imgpath,outpath);
%     end
% end
% 
% for x = 3:child_numfiles
%     child_dir_name = child_dir(x).name;
%     fnames = dir(fullfile(image_dir,child_dir_name, '*.tif'));
%     num_files = size(fnames,1);
%     traintest=floor(num_files*0.5);
%     indextraintest=zeros(traintest,1);
%     indexval=zeros(num_files-traintest,1);
%     filenames=zeros(num_files,1);
%     x
%     for y = 1:num_files
%         str=string(fnames(y).name);
%         str=str.split('.');
%         str=str2num(str(1));
%         filenames(y)=str;
%     end
%     idx=randperm(num_files);
%     indextraintest=filenames(idx(1:traintest));
%     indexval=filenames(idx((traintest+1):end));
%     for xx=1:traintest
%         imgpath=sprintf('%s\\%s\\%d.tif',image_dir,child_dir_name,indextraintest(xx));
%         outdir=sprintf('%s\\traintest\\%s',out_dir,child_dir_name);
%         outpath=sprintf('%s\\traintest\\%s\\%d.tif',out_dir,child_dir_name,indextraintest(xx));
%         if(exist(outdir,'dir')==0)
%             mkdir(outdir);
%         end
%         copyfile(imgpath,outpath);
%     end
%     for yy=1:size(indexval,1)
%         imgpath=sprintf('%s\\%s\\%d.tif',image_dir,child_dir_name,indexval(yy));
%         outdir=sprintf('%s\\val\\%s',out_dir,child_dir_name);
%         outpath=sprintf('%s\\val\\%s\\%d.tif',out_dir,child_dir_name,indexval(yy));
%         if(exist(outdir,'dir')==0)
%             mkdir(outdir);
%         end
%         copyfile(imgpath,outpath);
%     end
% end



% img_dir='E:\experiment\shenzhen\parcel_color\img';
% out_dir='E:\experiment\shenzhen\slic\parcel_boost_3k';
% indexall='E:\experiment\shenzhen\slic\indexall.mat';
% indexall = load(indexall);
% indexall=cell2mat(struct2cell(indexall));
% hist1='E:\experiment\shenzhen\slic\patch_spe_sift.mat';
% hist1 = load(hist1);
% hist1=cell2mat(struct2cell(hist1));
% for i=1:6183
%     i
%     indexsub=indexall(i);
%     index0=find(hist1(:,2)==indexsub);
%     label0=hist1(index0,1);
%     imgpath=sprintf('%s\\%d.tif',img_dir,indexsub);
%     I=imread(imgpath);
%     [rowI colI bandI]=size(I);
%     if((rowI*colI)>3000)
%         outdir=sprintf('%s\\%d',out_dir,label0);
%         outpath=sprintf('%s\\%d\\%d.tif',out_dir,label0,indexsub);
%         if(exist(outdir,'dir')==0)
%             mkdir(outdir);
%         end
%         copyfile(imgpath,outpath);
%     else
%         I0=zeros(rowI,colI,bandI,6);
%         I0(:,:,:,1)=I;
%         I0(:,:,:,2)=imrotate(I0(:,:,:,1),45,'nearest','crop');
%         w=fspecial('gaussian',[3,3],3);
%         I0(:,:,:,3)=imfilter(I0(:,:,:,1),w);
% 
%         bandnew=6;
%         row=size(I,1);
%         col=size(I,2);
%         row_new=floor(row*0.70);
%         col_new=floor(col*0.70);
%         row_start=row-row_new;
%         col_start=col-col_new;
%         x=randperm(row_start,1);
%         y=randperm(col_start,1);
%         I_test=I(x:(x+row_new-1),y:(y+col_new-1),:);
%         [row col band]=size(I_test);
%         gray1=mean(mean(I_test(:,:,1)));
%         gray2=mean(mean(I_test(:,:,2)));
%         gray3=mean(mean(I_test(:,:,3)));
%          if(gray1>0&&gray2>0&&gray3>0)
%             I0(1:row_new,1:col_new,:,4)=I_test(:,:,:);
%             I0(:,:,:,5)=imrotate(I0(:,:,:,4),45,'nearest','crop');
%             I0(:,:,:,6)=imfilter(I0(:,:,:,4),w);
%          else
%             bandnew=3;
%          end
%         
%         for k=1:bandnew
%             outdir=sprintf('%s\\%d',out_dir,label0);
%             outpath=sprintf('%s\\%d\\%d_%d.tif',out_dir,label0,indexsub,k);
%             if(exist(outdir,'dir')==0)
%                 mkdir(outdir);
%             end
%             imwrite(uint8(I0(:,:,:,k)),outpath);
%         end
%     end
% end