function [] = displayInst(name,varargin)
    %Usage
    %displayInst(name)
    %displayInst(name,'sqrBox')
    %displayInst(name,[],'sqrData')
    %displayInst(name,'sqrBox','sqrData')   


    %% start plotting
    load(name);
    
    %plot original dataset
    scatter(x1(:,1),x1(:,2));
    grid on;
    hold on;
    
    %plot distorted dataset
    scatter(y2a(:,1),y2a(:,2));
    
    %apply optional settings
    if (~isempty(varargin))
        %boxplot aspect ratio
        if strcmp(varargin{1},'sqrBox')
            pbaspect([1 1 1]);
        end
        
        %data aspect ratio
        if strcmp(varargin{2},'sqrData')
            daspect([1 1 1]);
        end
    end
    
end

