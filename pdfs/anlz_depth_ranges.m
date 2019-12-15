alldepth = getfn('.', 'range$');
ds_matrix = zeros(length(alldepth),2);
for k=1:length(alldepth)
    fileName = alldepth(k);
    fileName = fileName{1};
    
    fid = fopen(fileName,'rt');
    ds = textscan(fid, '%u %u %u %u');
    fclose(fid);
    ds_matrix(k,:) = double([ds{3} ds{4}]);
end

a_bound = max(ds_matrix(:,1))
b_bound = min(ds_matrix(:,2))

ds_matrix