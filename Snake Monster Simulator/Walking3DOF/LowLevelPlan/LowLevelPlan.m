function [Footstep, BodyPath ] = LowLevelPlan(CostMap, TerrainMap)
%   Low Level planning
%   plan the footsteps of the robot on a rugged terrain
%
%   Auther: Tianyu Chen

% [Note]: All x, y are defined in the terrain coordinate.
% o----------------->y
% |      1 2 3 ... c2
% |   c2+1
% | 2*c2+1 
% |   .
% |   .
% |c1*c2+1
% ?
% x

% Input : 457 by 457 terrain cost map
% Output: 3 by 6 by StepNum pages matrix and 3 by 

% search criterion
Config = ConfigPara_();

% 1) first generate an estimated body cost map
% TerrainCostMap: c1*c2 
%    BodyCostMap: c1-2*MarginX * c2-2*MarginY
fprintf('[Low Level Plan] Calculating body cost...\n');
[BodyCostMap] = BodyCost(CostMap, Config);  % 311 by 311 matrix
BodyCostMap = BodyCostMap - min(BodyCostMap(:));

% 2) then generate a body path that has the lowest cost
fprintf('[Low Level Plan] Searching body traj...\n');
[BodyPathNaive] = SearchBody(BodyCostMap);  % StepNum by 2 matrix, the Body path is defined
                                       % in BodyCostMap

% 3) discretize the body path
fprintf('[Low Level Plan] Discretizing body path...\n');
[BodyPathDis] = DiscreteBodyPath(BodyPathNaive, BodyCostMap);

% 4) generate footstep planb and map NewBodyPath
fprintf('[Low Level Plan] Generating footstep plan...\n');
[Footstep, BodyPath] = GenerateFootstep(BodyPathDis, CostMap, TerrainMap, Config); % 3 by 6 by StepNum pages matrix

end

