% Software: Preprocessing
% Author: Hy Truong Son
% Position: PhD Student
% Institution: Department of Computer Science, The University of Chicago
% Email: sonpascal93@gmail.com, hytruongson@uchicago.edu
% Website: http://people.inf.elte.hu/hytruongson/
% Copyright 2016 (c) Hy Truong Son. All rights reserved.

function [X, label] = preprocessing(matfile)
    %% Constants
    database_path = './ORL_Face_Database';
    data_fn = 'all-samples.dat';
    
    nRows = 112;
    nCols = 92;
    
    %% Read and convert the database
    addpath(genpath(database_path));
    fid = fopen(data_fn, 'r');
    nSamples = str2num(fgets(fid));

    X = zeros(nRows * nCols, nSamples);
    label = zeros(nSamples, 1);
    
    for sample = 1 : nSamples
        label(sample) = str2num(fgets(fid));
        image_fn = fgets(fid);
        image_fn = image_fn(1, 1 : size(image_fn, 2) - 1);
        im = imread(image_fn);
        
        vector = matrix2vector(double(im));
        X(:, sample) = vector(:);
    end
    
    %% Save to the .mat file
    save(matfile, 'X', 'label');
end