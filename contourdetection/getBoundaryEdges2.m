function boundaryEdges = getBoundaryEdges2(wsgraph,marginSize,edgepixels,...
    nodeEdges,edgeIDs)

% from each boundary, along perpendicular lines get all the pixels nearest
% to the edge i.e. along each line given by a set of pixels.
% Remove the nodeInds from this list of pixels. Then we are left with the
% edge pixels. Get the boundaryEdgeIDs from these

visualize = 1;

[sizeR, sizeC] = size(wsgraph); % size of the image
% top edge pixels
topEdgePixels = zeros(sizeC,1);
for i=1:sizeC
    for j=1:marginSize
        if(wsgraph(j,i)>0)
            topEdgePixels(i) = sub2ind([sizeR sizeC],j,i);
            break
        end
    end
end

% bottom edge pixels
bottomEdgePixels = zeros(sizeC,1);
for i=1:sizeC
    for j=sizeR:-1:(sizeR-marginSize)
        if(wsgraph(j,i)>0)
            bottomEdgePixels(i) = sub2ind([sizeR sizeC],j,i);
            break
        end
    end
end

% left edge pixels
leftEdgePixels = zeros(sizeR,1);
for i=1:sizeR
    for j=1:marginSize
        if(wsgraph(i,j)>0)
            leftEdgePixels(i) = sub2ind([sizeR sizeC],i,j);
            break
        end
    end
end

% right edge pixels
rightEdgePixels = zeros(sizeR,1);
for i=1:sizeR
    for j=sizeC:-1:(sizeC-marginSize)
        if(wsgraph(i,j)>0)
            rightEdgePixels(i) = sub2ind([sizeR sizeC],i,j);
            break
        end
    end
end

allBoundaryEdgePixels = [topEdgePixels; bottomEdgePixels;...
                leftEdgePixels; rightEdgePixels];
allBoundaryEdgePixels = unique(allBoundaryEdgePixels);   
allBoundaryEdgePixels = allBoundaryEdgePixels(allBoundaryEdgePixels>0);

% remove the nodeInds
nodeInds = nodeEdges(:,1);
boundaryEdgePixels = setdiff(allBoundaryEdgePixels,nodeInds);

% for each boundaryEdgePixel, get the corresponding edgeID
numBoundaryEdgePixels = numel(boundaryEdgePixels);
boundaryEdges = zeros(numBoundaryEdgePixels,1);
boundaryEdges_listInds = zeros(numBoundaryEdgePixels,1);
for i=1:numBoundaryEdgePixels
    clear edgeListInd
    [edgeListInd,~] = find(edgepixels==boundaryEdgePixels(i));
    boundaryEdges_listInds(i) = edgeListInd;
    boundaryEdges(i) = edgeIDs(edgeListInd,1);
end

boundaryEdges = unique(boundaryEdges);
boundaryEdges_listInds = unique(boundaryEdges_listInds);
%% visualization
numBoundaryEdges = numel(boundaryEdges);
if(visualize)
    % visualize detected boundary edges
    imgTmp = zeros(sizeR,sizeC);
    % color all edge pixels : 1
    edgepix_all = edgepixels(edgepixels>0);
    imgTmp(edgepix_all) = 1;
    % color boundary edges with 0.5
    for i=1:numBoundaryEdges
        edgepix_i = edgepixels(boundaryEdges_listInds(i),:);
        edgepix_i = edgepix_i(edgepix_i>0);
        imgTmp(edgepix_i) = 0.5;
    end
    figure;imagesc(imgTmp);title('boundary edges');
end