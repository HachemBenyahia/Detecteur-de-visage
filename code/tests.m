cd tests

images = dir(fullfile(pwd, '*.jpg'));
names = {images.name}';

tests = {};

for i = 1:size(images, 1)
    tests{i} = imread(char(names(i)));
end

cd ..

save('names.mat', 'names');
save('tests.mat', 'tests');