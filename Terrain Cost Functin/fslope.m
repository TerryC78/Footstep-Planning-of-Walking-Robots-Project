function [ z ] = fslope(x, y, Dire, Slope);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch Dire
        case 1
            z = -(Slope/4)*0.4 * x -(Slope/4)*0.0 * y; % [0.4 0 1]
        case 2
            z = -(Slope/4)*0.3 * x -(Slope/4)*0.1 * y; % []
        case 3
            z = -(Slope/4)*0.2 * x -(Slope/4)*0.2 * y; % []
        case 4
            z = -(Slope/4)*0.1 * x -(Slope/4)*0.3 * y; % []
        case 5
            z = -(Slope/4)*0.0 * x -(Slope/4)*0.4 * y; % []
        case 6
            z =  (Slope/4)*0.1 * x -(Slope/4)*0.3 * y; % [0.4 0 1]
        case 7
            z =  (Slope/4)*0.2 * x -(Slope/4)*0.2 * y; % []
        case 8
            z =  (Slope/4)*0.3 * x -(Slope/4)*0.1 * y; % []
        case 9
            z =  (Slope/4)*0.4 * x -(Slope/4)*0.0 * y; % []
        case 10
            z =  (Slope/4)*0.3 * x +(Slope/4)*0.1 * y; % []
        case 11
            z =  (Slope/4)*0.2 * x +(Slope/4)*0.2 * y; % [0.4 0 1]
        case 12
            z =  (Slope/4)*0.1 * x +(Slope/4)*0.3 * y; % []
        case 13
            z =  (Slope/4)*0.0 * x +(Slope/4)*0.4 * y; % []
        case 14
            z = -(Slope/4)*0.1 * x +(Slope/4)*0.3 * y; % []
        case 15
            z = -(Slope/4)*0.2 * x +(Slope/4)*0.2 * y; % []
        case 16
            z = -(Slope/4)*0.3 * x +(Slope/4)*0.1 * y; % []
    end

end

