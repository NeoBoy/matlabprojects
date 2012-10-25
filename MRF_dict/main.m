% MRF learning
% Thanuja

%% parameters, variables and other inputs
hasInitDict = 1;                                % 1 if initial dictionary is provided
pathToDict = 'Dictionary_256x_400w_16bb_NN.mat';
bb = 16;                                        % block size
% get the dictionary words
if(hasInitDict)
    load(pathToDict);       % loads the structure output (from KSVD)
    Dictionary = output.D;  % copy the dictionary
    clear output;           % output from KSVD is no more required 
else
    % generateDictionary()
end
numWords = size(Dictionary,2);

% image for training
trImageFilePath = '/home/thanuja/matlabprojects/data/mitoData/';
imageName = 'stem1_256by256.png';

% Get input image
[IMin,pp]=imread(strcat([trImageFilePath,imageName]));

% imSize = size(IMin_0);
% resizeDim = [imSize(1)-removedEdgeSize imSize(2)-removedEdgeSize];
% IMin = IMin_0(1:resizeDim(1), 1:resizeDim(2), 1);

% fixing input image format
IMin=im2double(IMin);
if (length(size(IMin))>2)
    IMin = rgb2gray(IMin);
end
if (max(IMin(:))<2)
    IMin = IMin*255;
end

% build the association matrices 
% HorizontalAssociations = getHorizontalAssociations(image,Dictionary);
% (remember to add 1)

%% Build MRF
imgInPatches = img2patches(IMin,bb);                        % TODO
% imgInPatches is 3D matrix mxnxk
%   m: number of patches in each column
%   n: number of patches in each row
%   k: number of pixels in each patch = bb*bb

% make edge structure
NN1 = size(imgInPatches,1);
NN2 = size(imgInPatches,2);
numNodes = prod([NN1,NN2]-bb+1);

adj = getAdjMatrix(size(IMin,1),size(IMin,2),bb);           % adjacency matrix
adj = adj + adj';

edgeStruct = UGM_makeEdgeStruct(adj,numWords);
nEdges = edgeStruct.nEdges;

%% Training Ising edge potentials

% Make node map
nodeMap = zeros(numNodes,numWords,'int32');
nodeMap(:,1) = 1;               % initialize with all nodes with word #1. TODO ############

% Make edge map
edgeMap = zeros(numWords,numWords,nEdges,'int32');







