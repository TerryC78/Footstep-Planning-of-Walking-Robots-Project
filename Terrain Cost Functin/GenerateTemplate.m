function [Terrain_template] = GenerateTemplate(TerrainWidth, TerrainLenth, WidthNum, DepthNum, Visualize)
%   Gnerate Terrain Template
%   Detailed explanation goes here   
    Z_concave = zeros(TerrainWidth, TerrainLenth, WidthNum*DepthNum); % concave ground
    Z_convex = zeros(TerrainWidth, TerrainLenth, WidthNum*DepthNum); % convex ground
    Z_flat = zeros(TerrainWidth, TerrainLenth); % flat ground  
    Z_slope = zeros(TerrainWidth, TerrainLenth, 16*4); % slope ground
    
    i = 1;
    for a = linspace(0.01, 0.05, WidthNum)  % 5 different width
        b = a;
        for c = linspace(0.01, 0.05, DepthNum)  % 5 different depth
            for x = -0.05:0.01:0.05
                for y = -0.05:0.01:0.05
                    Z_concave(i) = fvalue(x, y, a, b, c, 0); % f function
                    Z_convex(i) = fvalue(x, y, a, b, c, 1);
                    i = i + 1;
                end 
            end
        end
    end
    
    i = 1;
    for j = 1:16 % 16 different directions slope grounds
        for k = 1:4 % 
            for x = -0.05:0.01:0.05
                for y = -0.05:0.01:0.05
                    Z_slope(i) = fslope(x, y, j, k);
                    i = i + 1;
                end
            end
        end
    end
    
    if Visualize
        x = -0.05:0.01:0.05; % for mesh
        y = x;
        [X, Y] = meshgrid(x, y);
%         for i = 1:WidthNum*DepthNum
%             figure
%             mesh(X, Y, Z_concave(:,:, i));
%             axis([-0.05 0.05 -0.05 0.05 -0.05 0.05])
%         end
% 
%         for i = 1:WidthNum*DepthNum
%             figure
%             mesh(X, Y, Z_convex(:,:, i));
%             axis([-0.05 0.05 -0.05 0.05 -0.05 0.05])
%         end
%         
%         figure
%         mesh(X, Y, Z_flat);
%         axis([-0.05 0.05 -0.05 0.05 -0.05 0.05])
        
        for i = 1:16*4
            figure
            mesh(X, Y, Z_slope(:,:, i));
            axis([-0.05 0.05 -0.05 0.05 -0.05 0.05])
        end
    end
    
    Z_concave_mean = mean(mean(Z_concave));
    Z_convex_mean = mean(mean(Z_convex));
    
    Terrain_template = zeros(TerrainWidth, TerrainLenth, WidthNum*DepthNum+1+16*4);
    Terrain_template(:,:, 1) = Z_flat;
    for i = 2:26
        Terrain_template(:,:, i) = Z_concave(:,:,i-1) - Z_concave_mean(:,:,i-1);
    end
    for i = 27:51
        Terrain_template(:,:, i) = Z_convex(:,:,i-26) - Z_convex_mean(:,:,i-26);
    end
    for i = 52:115
        Terrain_template(:,:, i) = Z_slope(:,:,i-51);
    end
     
    % ezmesh('0.005*sqrt(1 - (x/0.05).^2 - (y/0.05).^2)', [-0.05 0.05 -0.05 0.05], 10)
    % ezmesh('0.005*sqrt(1 - (x/0.05).^2 - (y/0.05).^2)', [-0.1 0.1 -0.1 0.1], 21)
    
end

