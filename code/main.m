load('svm1.mat');
load('svm2.mat');
load('svm3.mat');
load('svm4.mat');
load('names.mat');
load('tests.mat');

jump = 15;
jumpWindow = 20;

for k = 1 : size(tests, 2)
    M = tests{k}
    data = [];
    scores = [];
    windowSize = 24;
    maxSize = min(size(M, 1), size(M, 2));
    while (windowSize < maxSize)
        for i = 1 : jump : (size(M, 1) - windowSize)
            for j = 1 : jump : (size(M, 2) - windowSize)
                window = imresize(M(i : (i + windowSize), j : (j + windowSize)), [24 24]);
                window = normalize(window);
                X = extractHOGFeatures(window);

                [label, score] = predict(svm1, X);
%                 if label == 1
%                     [label, score] = predict(svm2, X);
%                     if label == 1
%                         [label, score] = predict(svm3, X);
%                         if label == 1
%                             [label, score] = predict(svm4, X);
%                             if label == 1
%                                   %return;
%                             end
%                         end
%                     end
%                 end

                data = [data ; i j windowSize label]; 
                scores = [scores ; abs(score(1))];
                str = [i j windowSize label abs(score(1))];
                disp(str);
            end
        end

        windowSize = windowSize + jumpWindow;
    end
    
    name = char(strcat(names(k), '.txt'));
    fid = fopen(name,'wt');
    for m = 1 : size(data, 1)
        fprintf(fid, '%d\t', data(m, :));
        fprintf(fid, '%.2f\t', scores(m));
        fprintf(fid, '\n');
    end
    fclose(fid);
end