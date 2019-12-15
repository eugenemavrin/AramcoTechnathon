close all
clear all

STEP = 1;
% a_bound = 1160;
% b_bound = 2060;

%%%%%%

alldata = getfn('.', 'txt$');
for k=1:length(alldata)
    fileName = alldata(k);
    fileName = fileName{1};
    
    [depthpath,~,~] = fileparts(fileName);
    depth_file = strcat(depthpath,'/depth.range');
    
    fid = fopen(depth_file,'rt');
    ds = textscan(fid, '%u %u %u %u');
    fclose(fid);
    ds = double([ds{1} ds{2} ds{3} ds{4}]);
    
    a_bound = ds(3);
    b_bound = ds(4);
    
    dsr = ds(2) - ds(1);

    fid = fopen(fileName,'rt');
    C = textscan(fid, '%n%n','Delimiter',{',',';'});
    fclose(fid);

    M = [C{1,2} C{1,1}];

    % normalize depth
    minV = min(M(:,1));
    maxV = max(M(:,1));
    M(:,1) = ( M(:,1) - minV ) / (maxV - minV);
    M(:,1) = (M(:,1)*dsr) + ds(1);

    % mean ambiguity
    [X,ia,idx] = unique(M(:,1),'stable');
    Y = accumarray(idx,M(:,2),[],@mean);
    H = interp1(X,Y,a_bound:STEP:b_bound,'linear');

    % save
    fileName = fileName(3:end);

    fileID = fopen(strcat('../well_logs/',fileName),'w+');
    fprintf(fileID,'%f ',H);
    fclose(fileID);

    %plot(H)
end
