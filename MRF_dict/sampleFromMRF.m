%% function IOut = sampleFromMRF(imgDim,bb,Hmat,Vmat,prior,Dictionary)

% generates a sample image based on the learned MRF

% Inputs:
% imgDim - vector containing the size of the output image to be sampled [rows columns]
% bb - block size
% Hmat - horizontal association matrix learned (row,column -> left to right)
% Vmat - vertical association matrix learned (row,column -> top to bottom)
% prior - prior for label (word) usage
% Dictionary

% Output:
% Iout - sampled image

function IOut = sampleFromMRF(imgDim,bb,Hmat,Vmat,prior,Dictionary) 

% Initialize random field
rows = imgDim(1) - bb + 1;              % number of overlapping image patches per column
cols = imgDim(2) - bb + 1;              % number of overlapping image patches per row

totPatches = rows*cols;                 % total number of patches to be generated

coefMat = sparse(size(Dictionary,2),totPatches);

for i = 0:totPatches
    % loop until all the patches are processed
 
    patchInd = ceil(rand(1) * totPatches);
    if(length(find(coefMat(:,patchInd)))==0)
        % i.e. this patch has not been processed before
        % pick a word for this
        
    else
        % i.e. this pach has already been assigned
        % pick another patch - one that has not been assigned yet
        
    end
    
end






