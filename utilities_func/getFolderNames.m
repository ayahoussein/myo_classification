function [ names ] = getFolderNames()

d=dir; %List files
isub = [d(:).isdir]; % Take only folders
names = {d(isub).name}'; % Get names
names(ismember(names,{'.','..'})) = []; % Exclude . and .. folders

end

