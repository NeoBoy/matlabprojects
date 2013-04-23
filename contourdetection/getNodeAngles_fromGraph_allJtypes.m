function jAnglesAll_alpha = getNodeAngles_fromGraph_allJtypes(junctionTypeListInds,...
    nodeInds,jEdgesAll,edges2pixels,sizeR,sizeC,edges2nodes)
% returns a cell array.
% jAnglesAll{i} - each row corresponds to the set of angles for each
% junction of type i (type 1 = J2)

% Inputs:
%   ...
%   jEdgesAll - cell array with jEdgesAll{i} corresponding the edgeSet of
%   junction type i. each row in the edge set corresponds to a junction
%   instance of that type

[nre,nce] = size(edges2pixels);  % first column is the edgeID
edgepixels = edges2pixels(:,2:nce);

[maxNodesPerJtype, numJtypes] = size(junctionTypeListInds);
maxNumEdgesPerNode = numJtypes + 1;     % list starts with J2 (= two edges)

% jAnglesAll = zeros(maxNodesPerJtype,maxNumEdgesPerNode,numJtypes);
jAnglesAll_alpha = cell(1,numJtypes);

for dim=1:numJtypes
    if(jEdgesAll{dim}==0)
        jAnglesAll_alpha{dim} = 0;
    else
        jEdges0 = jEdgesAll{dim};
        % jEdges = jEdges0(jEdges0>0);
        [r,c] = find(jEdges0>0);
        rmax = max(r);
        cmax = max(c);
        jEdges = zeros(rmax,cmax);
        jEdges(r,c) = jEdges0(r,c);       
        [numJ,degree] = size(jEdges);
        jAngles = zeros(numJ,degree);
        for i=1:numJ
            % for each node
            edges_i = jEdges(i,:);
            nodeListInd = junctionTypeListInds(i,dim);% get the index of the node in concern
            nodeInd = nodeInds(nodeListInd); 
            [rNode,cNode] = ind2sub([sizeR sizeC],nodeInd);
            for j=1:degree
                % for each edge of this node
                edgeID = edges_i(j);
                if(edgeID~=0)
                    edgeListInd = find(edges2pixels(:,1)==edgeID);  
                    if(isempty(edgeListInd))
                        continue;
                    end
                    edgePixelInds0 = edgepixels(edgeListInd,:);
                    %edgePixelInds = edgePixelInds(edgePixelInds>0);
                    [r1,c1] = find(edgePixelInds0>0);
                    rmax = max(r1);
                    cmax = max(c1);
                    edgePixelInds = zeros(rmax,cmax);
                    edgePixelInds(r1,c1) = edgePixelInds0(r1,c1);
                    % get the edge pixels(3) which are closest to the node i
                    nodePixels = getNodeEdgePixel(nodeInd,edgePixelInds,sizeR,sizeC);
                    % get their orientation
                    [rP,cP] = ind2sub([sizeR sizeC],nodePixels');
                    numEdgePix = numel(nodePixels);
%                     orientations = zeros(numEdgePix,1);
                    if(numEdgePix==1)
                        % just one edge pixel
                        % get the 2 junction nodes
                        edgeNodes = edges2nodes(edgeListInd,:);
                        if(edgeNodes(1)==nodeListInd)
                            node2ListInd = edgeNodes(2);
                        elseif(edgeNodes(2)==nodeListInd)
                            node2ListInd = edgeNodes(1);
                        else
                            disp('ERROR: getNodeAngles_fromGraph_allJtypes. node mismatch');
                        end
                        % calculate alpha based on these 2
                        nodeInd2 = nodeInds(node2ListInd); 
                        [rNode2,cNode2] = ind2sub([sizeR sizeC],nodeInd2);
                        y = rNode2 - rNode;
                        x = cNode2 - cNode;
                    else
                        % get alpha wrt the end edge pixels
%                         for k=1:numEdgePix
%                             y = rP(k) - rNode;
%                             x = cP(k) - cNode;
%                             alpha = atan2d(y,x);
%                             if(alpha<0)
%                                 alpha = alpha + 360;
%                             end
%                         orientations(k) = alpha;
%                         end
                        % get the first in the list
                        rp1 = rP(1);
                        rp2 = rP(end);
                        cp1 = cP(1);
                        cp2 = cP(end);
                        y = rp2 - rp1;
                        x = cp2 - cp1;
                    end
                    alpha = atan2d(y,x);
                    if(alpha<0)
                        alpha = alpha + 360;
                    end
%                         medianAlpha = median(orientations);
%                     if(numel(alpha)>1)
%                         % prob
%                         alpha
%                     else
                    jAngles(i,j) = alpha;
%                     end
                end
                    
            end
        end
        % assign the jAngles for this Jtype into jAnglesAll(:,:,Jtype)
        jAnglesAll_alpha{dim} = jAngles;
    end
end