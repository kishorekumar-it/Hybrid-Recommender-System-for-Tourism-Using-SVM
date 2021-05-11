function TourismList = loadTourismList()
%% Read the fixed Tourismulary list
fid = fopen('Tour_ids.txt');

% Store all Tourisms in cell array Tourism{}
n = 1682;  % Total number of Tourisms 

TourismList = cell(n, 1);
for i = 1:n
    % Read line
    line = fgets(fid);
    % Word Index (can ignore since it will be = i)
    [idx, TourismName] = strtok(line, ' ');
    % Actual Word
    TourismList{i} = strtrim(TourismName);
end
fclose(fid);

end
