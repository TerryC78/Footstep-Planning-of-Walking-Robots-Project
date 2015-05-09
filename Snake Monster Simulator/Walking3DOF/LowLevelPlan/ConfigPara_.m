function [ Config ]= ConfigPara_()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    Config.Radius = 2;  % search radius for every foot
    Config.BodyLen = 45;  % robot body length in the cost map
    Config.BodyWid = 35;  % robot body width in the cost map
    Config.Gap = 20;  % the distance from search region to the robot
    
    Config.MarginX  = Config.BodyWid + Config.Gap + ceil(Config.BodyWid/2); % margin of the cost map
    Config.MarginY  = Config.BodyLen + Config.Gap + ceil(Config.BodyLen/2);   
    Config.OffsetX1 = Config.BodyWid + Config.Gap - Config.Radius; % used to calc body cost
    Config.OffsetX2 = Config.BodyWid + Config.Gap + Config.Radius;
    Config.OffsetY1 = Config.BodyLen + Config.Gap - Config.Radius;
    Config.OffsetY2 = Config.BodyLen + Config.Gap + Config.Radius;
    
    Config.FootX1 = Config.Gap + ceil(Config.BodyWid/2)+5;
    Config.FootX2 = Config.MarginX-5;
    Config.FootX3 = Config.Gap + ceil(Config.BodyWid/2)+10+5;
    Config.FootX4 = Config.MarginX+10-5;
    Config.FootY1 = Config.Gap + ceil(Config.BodyLen/2)+5;
    Config.FootY2 = Config.MarginY-5;
    Config.FootY3 = - ceil(Config.BodyLen/2)+2; % for leg 3 and leg 4
    Config.FootY4 =   ceil(Config.BodyLen/2)-5; % for leg 3 and leg 4
    
end

