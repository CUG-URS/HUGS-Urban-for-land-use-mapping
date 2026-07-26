[heart_scale_label, heart_scale_inst] = libsvmread('../heart_scale');
repnum =  50;
heart_scale_inst = repmat(heart_scale_inst, [repnum,1]);
heart_scale_label = repmat(heart_scale_label,[repnum, 1]);
set_num_threads(4); % 3 threads
tic;
model = svmtrain(heart_scale_label, heart_scale_inst, '-t 4 -c 100 -g 0.07 -q');
toc;
tic;
[predict_label, accuracy, dec_values] = svmpredict(heart_scale_label, heart_scale_inst, model); % test the training data
toc;