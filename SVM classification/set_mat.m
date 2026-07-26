function rt = set_mat(input)
 m=size(input,1);
 n=size(input,2);
 rt=zeros(m,n+1);
 for i=1:m
     rt(i,1)=i;
 end
 rt(1:m,2:n+1)=input;
 return