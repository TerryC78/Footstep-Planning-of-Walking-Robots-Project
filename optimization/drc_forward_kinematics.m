function [ result com_total total_mass ] = drc_forward_kinematics( tree )
% drc_forward_kinematics( tree ), returns updated tree based on angles
% as well as COM and robot mass

% root is element 1
R_com = tree.l(1).orientation*tree.l(1).offset_to_com_b';
tree.l(1).com_w = tree.j(1).position_w + R_com';

total_mass = tree.l(1).mass;
com_total = tree.l(1).mass*tree.l(1).com_w;

for i = 2:29
 parent = tree.l(i).parent;
 tree.j(i).rotation = generate_axis_angle_rotation_matrix( tree.j(i).axis, ...
                                                         tree.j(i).angle );
 tree.l(i).orientation = tree.l( parent ).orientation*tree.j(i).rotation;
 R_offset = tree.l( parent ).orientation*tree.j(i).offset';
 tree.j(i).position_w = tree.j( parent ).position_w + R_offset';

 R_com = tree.l(i).orientation*tree.l(i).offset_to_com_b';
 tree.l(i).com_w = tree.j(i).position_w + R_com';
 total_mass = total_mass + tree.l(i).mass;
 com_total = com_total + tree.l(i).mass*tree.l(i).com_w;
 end

com_total = com_total/total_mass;
result = tree;
