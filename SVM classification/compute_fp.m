function [confusion_matrix]=compute_fp(predict_label,num_in_class,name_class,test_num)

num_class=length(num_in_class);%45

confusion_matrix=size(num_class,num_class);
false_positive=size(1,num_class);%误检 按正常的流程若K个位置都为1但实际上呢该值不再集合中，
false_negative=size(1,num_class);%漏检 应该属于1分到其他类别，
for ci=1:num_class
    for cj=1:num_class
        c_start=sum(num_in_class(1:(ci-1)))+1;
        c_end=sum(num_in_class(1:ci));
        confusion_matrix(ci,cj)=size(find(predict_label(c_start:c_end)==cj),1);
    end
    false_negative(1,ci)=(test_num-confusion_matrix(ci,ci))/test_num;%漏检 
end
save confusion_num.mat confusion_matrix;
fn_rate=sum(false_negative)/num_class;
for cj=1:num_class
    false_positive(1,cj)=(sum(confusion_matrix(:,cj))-confusion_matrix(cj,cj))/(test_num*(num_class-1));
end
fp_rate=sum(false_positive)/num_class;
fn_fp=[fn_rate fp_rate];
save fn_fp.mat fn_fp;
end
