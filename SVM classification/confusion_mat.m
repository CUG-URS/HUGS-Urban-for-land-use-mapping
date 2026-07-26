%confusion matrix;
function []=confusion_mat()
load testclass_result.mat;
n1=1;
n2=0;
t=size(test_num,2); %场景类别数
confusion_matrix=zeros(t,t);
for i=1:t %列表示正确类别数
    n=test_num(1,i);
    n2=n2+n;
    for ii=n1:n2
        a=D_part(2,ii);
        confusion_matrix(a,i)=confusion_matrix(a,i)+1;
    end
    n1=n2+1;
end
save('confusion_matrix.mat','confusion_matrix');
end
