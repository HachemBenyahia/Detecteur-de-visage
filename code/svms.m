load('positives.mat');
load('negatives.mat');

X = [];
Y = [];

positives = {};
negatives = {};

for i = 1 : size(pos, 3)
    positives{i} = pos(:, :, i);
    positives{i} = normalize(positives{i});
    X = [X ; extractHOGFeatures(positives{i})];
    Y = [Y ; 1];
    
    disp(i);
end

for i = 1 : size(neg, 3)
    negatives{i} = neg(:, :, i);
    negatives{i} = normalize(negatives{i});
    X = [X ; extractHOGFeatures(negatives{i})];
    Y = [Y ; -1];
    
    disp(i);
end

svm1 = fitcsvm(X, Y) 
svm2 = fitensemble(X, Y, 'AdaboostM1', 100, 'Tree')
svm3 = fitensemble(X, Y, 'RUSBoost', 500, 'Tree')
svm4 = fitensemble(X, Y, 'Subspace', 2000, 'Discriminant');

save('svm1.mat', 'svm1');
save('svm2.mat', 'svm2');
save('svm3.mat', 'svm3');
save('svm4.mat', 'svm4');