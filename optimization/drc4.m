
joint(1).index = 1;
joint(1).name = 'groundj';
joint(1).angle = 0.0;
joint(1).axis = [ 1 0 0 ];
joint(1).offset = [ 0 0 0 ];
joint(1).position_w = [ 0 0 0.92712 ];
joint(1).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(1).angle_limits = [ 0 0 ];
joint(1).velocity_limits = [ 0 0 ];
joint(1).torque_limits = [ 0 0 ];

link(1).index = 1;
link(1).name = 'pelvis';
link(1).parent = 0;
link(1).mass = 17.982;
link(1).offset_to_com_b = [ 0.0113715 0 0.0268706 ];
link(1).com_w = [ 0.0113715 0 0.953991 ];
link(1).moi_b = [ 0.125569 0.0008 -0.000499757
0.0008 0.0972062 -0.0005
-0.000499757 -0.0005 0.117937 ];
link(1).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(2).index = 2;
joint(2).name = 'back_lbz';
joint(2).angle = 0.0;
joint(2).axis = [ 0 0 1 ];
joint(2).offset = [ -0.0125 0 0 ];
joint(2).position_w = [ -0.0125 0 0.92712 ];
joint(2).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(2).angle_limits = [ -0.663225 0.663225 ];
joint(2).velocity_limits = [ -12 12 ];
joint(2).torque_limits = [ -124.016 124.016 ];

link(2).index = 2;
link(2).name = 'ltorso';
link(2).parent = 1;
link(2).mass = 2.409;
link(2).offset_to_com_b = [ -0.0112984 -3.15366e-06 0.0746835 ];
link(2).com_w = [ -0.0237984 -3.15366e-06 1.0018 ];
link(2).moi_b = [ 0.0039092 -5.04491e-08 -0.000342157
-5.04491e-08 0.00341694 4.87119e-07
-0.000342157 4.87119e-07 0.00174492 ];
link(2).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(3).index = 3;
joint(3).name = 'back_mby';
joint(3).angle = 0.0;
joint(3).axis = [ 0 1 0 ];
joint(3).offset = [ 0 0 0.16197 ];
joint(3).position_w = [ -0.0125 0 1.08909 ];
joint(3).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(3).angle_limits = [ -0.610691 0.438427 ];
joint(3).velocity_limits = [ -12 12 ];
joint(3).torque_limits = [ -206.843 206.843 ];

link(3).index = 3;
link(3).name = 'mtorso';
link(3).parent = 2;
link(3).mass = 0.69;
link(3).offset_to_com_b = [ -0.00816266 -0.0131245 0.0305974 ];
link(3).com_w = [ -0.0206627 -0.0131245 1.11969 ];
link(3).moi_b = [ 0.000454181 -6.10764e-05 3.94009e-05
-6.10764e-05 0.000483282 5.27463e-05
3.94009e-05 5.27463e-05 0.000444215 ];
link(3).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(4).index = 4;
joint(4).name = 'back_ubx';
joint(4).angle = 0.0;
joint(4).axis = [ 1 0 0 ];
joint(4).offset = [ 3.46945e-18 0 0.05 ];
joint(4).position_w = [ -0.0125 0 1.13909 ];
joint(4).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(4).angle_limits = [ -0.698132 0.698132 ];
joint(4).velocity_limits = [ -12 12 ];
joint(4).torque_limits = [ -200 200 ];

link(4).index = 4;
link(4).name = 'utorso';
link(4).parent = 3;
link(4).mass = 52.007;
link(4).offset_to_com_b = [ -0.0923 0 0.3 ];
link(4).com_w = [ -0.1048 0 1.43909 ];
link(4).moi_b = [ 1.466 0.00362 0.336
0.00362 1.51 0.001
0.336 0.001 1.3 ];
link(4).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(5).index = 5;
joint(5).name = 'neck_ay';
joint(5).angle = 0.0;
joint(5).axis = [ 0 1 0 ];
joint(5).offset = [ 0.21672 0 0.53796 ];
joint(5).position_w = [ 0.20422 0 1.67705 ];
joint(5).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(5).angle_limits = [ -0.602139 1.14494 ];
joint(5).velocity_limits = [ -12 12 ];
joint(5).torque_limits = [ -5 5 ];

link(5).index = 5;
link(5).name = 'head';
link(5).parent = 4;
link(5).mass = 1.47757;
link(5).offset_to_com_b = [ -0.0738031 4.84927e-05 0.0299297 ];
link(5).com_w = [ 0.130417 4.84927e-05 1.70698 ];
link(5).moi_b = [ 0.00418873 -2.36262e-06 -0.00101648
-2.36262e-06 0.00444693 -1.85704e-06
-0.00101648 -1.85704e-06 0.00367855 ];
link(5).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(6).index = 6;
joint(6).name = 'l_leg_uhz';
joint(6).angle = 0.0;
joint(6).axis = [ 0 0 1 ];
joint(6).offset = [ 0 0.089 0 ];
joint(6).position_w = [ 0 0.089 0.92712 ];
joint(6).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(6).angle_limits = [ -0.174533 1.22173 ];
joint(6).velocity_limits = [ -12 12 ];
joint(6).torque_limits = [ -110 110 ];

link(6).index = 6;
link(6).name = 'l_uglut';
link(6).parent = 1;
link(6).mass = 0.648;
link(6).offset_to_com_b = [ 0.00529262 -0.00344732 0.00313046 ];
link(6).com_w = [ 0.00529262 0.0855527 0.93025 ];
link(6).moi_b = [ 0.00074276 -3.79607e-08 -2.79549e-05
-3.79607e-08 0.000688179 -3.2735e-08
-2.79549e-05 -3.2735e-08 0.00041242 ];
link(6).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(7).index = 7;
joint(7).name = 'l_leg_mhx';
joint(7).angle = 0.0;
joint(7).axis = [ 1 0 0 ];
joint(7).offset = [ 0 0 0 ];
joint(7).position_w = [ 0 0.089 0.92712 ];
joint(7).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(7).angle_limits = [ -0.523599 0.523599 ];
joint(7).velocity_limits = [ -12 12 ];
joint(7).torque_limits = [ -180 180 ];

link(7).index = 7;
link(7).name = 'l_lglut';
link(7).parent = 6;
link(7).mass = 0.866;
link(7).offset_to_com_b = [ 0.0133341 0.0170484 -0.0312052 ];
link(7).com_w = [ 0.0133341 0.106048 0.895915 ];
link(7).moi_b = [ 0.000691326 -2.24344e-05 2.50508e-06
-2.24344e-05 0.00126856 0.000137862
2.50508e-06 0.000137862 0.00106487 ];
link(7).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(8).index = 8;
joint(8).name = 'l_leg_lhy';
joint(8).angle = 0.0;
joint(8).axis = [ 0 1 0 ];
joint(8).offset = [ 0.05 0 -0.05 ];
joint(8).position_w = [ 0.05 0.089 0.87712 ];
joint(8).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(8).angle_limits = [ -1.72072 0.524821 ];
joint(8).velocity_limits = [ -12 12 ];
joint(8).torque_limits = [ -260 260 ];

link(8).index = 8;
link(8).name = 'l_uleg';
link(8).parent = 7;
link(8).mass = 9.209;
link(8).offset_to_com_b = [ 0 0 -0.21 ];
link(8).com_w = [ 0.05 0.089 0.66712 ];
link(8).moi_b = [ 0.09 0 0
0 0.09 0
0 0 0.02 ];
link(8).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(9).index = 9;
joint(9).name = 'l_leg_kny';
joint(9).angle = 0.0;
joint(9).axis = [ 0 1 0 ];
joint(9).offset = [ -0.05 0 -0.374 ];
joint(9).position_w = [ 0 0.089 0.50312 ];
joint(9).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(9).angle_limits = [ 0 2.38569 ];
joint(9).velocity_limits = [ -12 12 ];
joint(9).torque_limits = [ -400 400 ];

link(9).index = 9;
link(9).name = 'l_lleg';
link(9).parent = 8;
link(9).mass = 5.479;
link(9).offset_to_com_b = [ 0.001 0 -0.187 ];
link(9).com_w = [ 0.001 0.089 0.31612 ];
link(9).moi_b = [ 0.077 0 -0.003
0 0.076 0
-0.003 0 0.01 ];
link(9).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(10).index = 10;
joint(10).name = 'l_leg_uay';
joint(10).angle = 0.0;
joint(10).axis = [ 0 1 0 ];
joint(10).offset = [ 0 0 -0.422 ];
joint(10).position_w = [ 0 0.089 0.08112 ];
joint(10).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(10).angle_limits = [ -1 0.7 ];
joint(10).velocity_limits = [ -12 12 ];
joint(10).torque_limits = [ -700 700 ];

link(10).index = 10;
link(10).name = 'l_talus';
link(10).parent = 9;
link(10).mass = 0.125;
link(10).offset_to_com_b = [ 0 0 0 ];
link(10).com_w = [ 0 0.089 0.08112 ];
link(10).moi_b = [ 0.001 0 0
0 0.001 0
0 0 0.001 ];
link(10).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(11).index = 11;
joint(11).name = 'l_leg_lax';
joint(11).angle = 0.0;
joint(11).axis = [ 1 0 0 ];
joint(11).offset = [ 0 0 0 ];
joint(11).position_w = [ 0 0.089 0.08112 ];
joint(11).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(11).angle_limits = [ -0.8 0.8 ];
joint(11).velocity_limits = [ -12 12 ];
joint(11).torque_limits = [ -300 300 ];

link(11).index = 11;
link(11).name = 'l_foot';
link(11).parent = 10;
link(11).mass = 2.05;
link(11).offset_to_com_b = [ 0.027 0 -0.067 ];
link(11).com_w = [ 0.027 0.089 0.01412 ];
link(11).moi_b = [ 0.002 0 0
0 0.007 0
0 0 0.008 ];
link(11).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(12).index = 12;
joint(12).name = 'r_leg_uhz';
joint(12).angle = 0.0;
joint(12).axis = [ 0 0 1 ];
joint(12).offset = [ 0 -0.089 0 ];
joint(12).position_w = [ 0 -0.089 0.92712 ];
joint(12).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(12).angle_limits = [ -1.22173 0.174533 ];
joint(12).velocity_limits = [ -12 12 ];
joint(12).torque_limits = [ -110 110 ];

link(12).index = 12;
link(12).name = 'r_uglut';
link(12).parent = 1;
link(12).mass = 0.648;
link(12).offset_to_com_b = [ 0.00529262 0.00344732 0.00313046 ];
link(12).com_w = [ 0.00529262 -0.0855527 0.93025 ];
link(12).moi_b = [ 0.00074276 3.79607e-08 -2.79549e-05
3.79607e-08 0.000688179 3.2735e-08
-2.79549e-05 3.2735e-08 0.00041242 ];
link(12).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(13).index = 13;
joint(13).name = 'r_leg_mhx';
joint(13).angle = 0.0;
joint(13).axis = [ 1 0 0 ];
joint(13).offset = [ 0 0 0 ];
joint(13).position_w = [ 0 -0.089 0.92712 ];
joint(13).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(13).angle_limits = [ -0.523599 0.523599 ];
joint(13).velocity_limits = [ -12 12 ];
joint(13).torque_limits = [ -180 180 ];

link(13).index = 13;
link(13).name = 'r_lglut';
link(13).parent = 12;
link(13).mass = 0.866;
link(13).offset_to_com_b = [ 0.0133341 -0.0170484 -0.0312052 ];
link(13).com_w = [ 0.0133341 -0.106048 0.895915 ];
link(13).moi_b = [ 0.000691326 2.24344e-05 2.50508e-06
2.24344e-05 0.00126856 -0.000137862
2.50508e-06 -0.000137862 0.00106487 ];
link(13).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(14).index = 14;
joint(14).name = 'r_leg_lhy';
joint(14).angle = 0.0;
joint(14).axis = [ 0 1 0 ];
joint(14).offset = [ 0.05 0 -0.05 ];
joint(14).position_w = [ 0.05 -0.089 0.87712 ];
joint(14).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(14).angle_limits = [ -1.72072 0.524821 ];
joint(14).velocity_limits = [ -12 12 ];
joint(14).torque_limits = [ -260 260 ];

link(14).index = 14;
link(14).name = 'r_uleg';
link(14).parent = 13;
link(14).mass = 9.209;
link(14).offset_to_com_b = [ 0 0 -0.21 ];
link(14).com_w = [ 0.05 -0.089 0.66712 ];
link(14).moi_b = [ 0.09 0 0
0 0.09 0
0 0 0.02 ];
link(14).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(15).index = 15;
joint(15).name = 'r_leg_kny';
joint(15).angle = 0.0;
joint(15).axis = [ 0 1 0 ];
joint(15).offset = [ -0.05 0 -0.374 ];
joint(15).position_w = [ 0 -0.089 0.50312 ];
joint(15).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(15).angle_limits = [ 0 2.38569 ];
joint(15).velocity_limits = [ -12 12 ];
joint(15).torque_limits = [ -400 400 ];

link(15).index = 15;
link(15).name = 'r_lleg';
link(15).parent = 14;
link(15).mass = 5.479;
link(15).offset_to_com_b = [ 0.001 0 -0.187 ];
link(15).com_w = [ 0.001 -0.089 0.31612 ];
link(15).moi_b = [ 0.077 -0 -0.003
-0 0.076 -0
-0.003 -0 0.01 ];
link(15).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(16).index = 16;
joint(16).name = 'r_leg_uay';
joint(16).angle = 0.0;
joint(16).axis = [ 0 1 0 ];
joint(16).offset = [ 0 0 -0.422 ];
joint(16).position_w = [ 0 -0.089 0.08112 ];
joint(16).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(16).angle_limits = [ -1 0.7 ];
joint(16).velocity_limits = [ -12 12 ];
joint(16).torque_limits = [ -700 700 ];

link(16).index = 16;
link(16).name = 'r_talus';
link(16).parent = 15;
link(16).mass = 0.125;
link(16).offset_to_com_b = [ 0 0 0 ];
link(16).com_w = [ 0 -0.089 0.08112 ];
link(16).moi_b = [ 0.001 0 0
0 0.001 0
0 0 0.001 ];
link(16).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(17).index = 17;
joint(17).name = 'r_leg_lax';
joint(17).angle = 0.0;
joint(17).axis = [ 1 0 0 ];
joint(17).offset = [ 0 0 0 ];
joint(17).position_w = [ 0 -0.089 0.08112 ];
joint(17).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(17).angle_limits = [ -0.8 0.8 ];
joint(17).velocity_limits = [ -12 12 ];
joint(17).torque_limits = [ -300 300 ];

link(17).index = 17;
link(17).name = 'r_foot';
link(17).parent = 16;
link(17).mass = 2.05;
link(17).offset_to_com_b = [ 0.027 0 -0.067 ];
link(17).com_w = [ 0.027 -0.089 0.01412 ];
link(17).moi_b = [ 0.002 0 0
0 0.007 0
0 0 0.008 ];
link(17).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(18).index = 18;
joint(18).name = 'l_arm_usy';
joint(18).angle = 0.0;
joint(18).axis = [ 0 0.5 0.866025 ];
joint(18).offset = [ 0.06441 0.13866 0.10718 ];
joint(18).position_w = [ 0.05191 0.13866 1.24627 ];
joint(18).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(18).angle_limits = [ -1.5708 0.785398 ];
joint(18).velocity_limits = [ -12 12 ];
joint(18).torque_limits = [ -212 212 ];

link(18).index = 18;
link(18).name = 'l_clav';
link(18).parent = 4;
link(18).mass = 3.45;
link(18).offset_to_com_b = [ 0 0.048 0.084 ];
link(18).com_w = [ 0.05191 0.18666 1.33027 ];
link(18).moi_b = [ 0.011 0 0
0 0.009 -0.004
0 -0.004 0.004 ];
link(18).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(19).index = 19;
joint(19).name = 'l_arm_shx';
joint(19).angle = 0.0;
joint(19).axis = [ 1 0 0 ];
joint(19).offset = [ 0 0.14035 0.19609 ];
joint(19).position_w = [ 0.05191 0.27901 1.44236 ];
joint(19).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(19).angle_limits = [ -1.5708 1.5708 ];
joint(19).velocity_limits = [ -12 12 ];
joint(19).torque_limits = [ -170 170 ];

link(19).index = 19;
link(19).name = 'l_scap';
link(19).parent = 18;
link(19).mass = 3.012;
link(19).offset_to_com_b = [ 0 0 0 ];
link(19).com_w = [ 0.05191 0.27901 1.44236 ];
link(19).moi_b = [ 0.00319 0 0
0 0.00583 0
0 0 0.00583 ];
link(19).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(20).index = 20;
joint(20).name = 'l_arm_ely';
joint(20).angle = 0.0;
joint(20).axis = [ 0 1 0 ];
joint(20).offset = [ 0 0.187 0.016 ];
joint(20).position_w = [ 0.05191 0.46601 1.45836 ];
joint(20).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(20).angle_limits = [ 0 3.14159 ];
joint(20).velocity_limits = [ -12 12 ];
joint(20).torque_limits = [ -114 114 ];

link(20).index = 20;
link(20).name = 'l_uarm';
link(20).parent = 19;
link(20).mass = 3.388;
link(20).offset_to_com_b = [ 0 -0.065 0 ];
link(20).com_w = [ 0.05191 0.40101 1.45836 ];
link(20).moi_b = [ 0.00656 0 0
0 0.00358 0
0 0 0.00656 ];
link(20).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(21).index = 21;
joint(21).name = 'l_arm_elx';
joint(21).angle = 0.0;
joint(21).axis = [ 1 0 0 ];
joint(21).offset = [ 0 0.119 0.00921 ];
joint(21).position_w = [ 0.05191 0.58501 1.46757 ];
joint(21).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(21).angle_limits = [ 0 2.35619 ];
joint(21).velocity_limits = [ -12 12 ];
joint(21).torque_limits = [ -114 114 ];

link(21).index = 21;
link(21).name = 'l_larm';
link(21).parent = 20;
link(21).mass = 2.509;
link(21).offset_to_com_b = [ 0 0 0 ];
link(21).com_w = [ 0.05191 0.58501 1.46757 ];
link(21).moi_b = [ 0.00265 0 0
0 0.00446 0
0 0 0.00446 ];
link(21).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(22).index = 22;
joint(22).name = 'l_arm_uwy';
joint(22).angle = 0.0;
joint(22).axis = [ 0 1 0 ];
joint(22).offset = [ 0 0.187 -0.00921 ];
joint(22).position_w = [ 0.05191 0.77201 1.45836 ];
joint(22).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(22).angle_limits = [ 0 3.14159 ];
joint(22).velocity_limits = [ -12 12 ];
joint(22).torque_limits = [ -114 114 ];

link(22).index = 22;
link(22).name = 'l_farm';
link(22).parent = 21;
link(22).mass = 3.388;
link(22).offset_to_com_b = [ 0 -0.065 0 ];
link(22).com_w = [ 0.05191 0.70701 1.45836 ];
link(22).moi_b = [ 0.00656 0 0
0 0.00358 0
0 0 0.00656 ];
link(22).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(23).index = 23;
joint(23).name = 'l_arm_mwx';
joint(23).angle = 0.0;
joint(23).axis = [ 1 0 0 ];
joint(23).offset = [ 0 0.119 0.00921 ];
joint(23).position_w = [ 0.05191 0.89101 1.46757 ];
joint(23).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(23).angle_limits = [ -1.1781 1.1781 ];
joint(23).velocity_limits = [ -12 12 ];
joint(23).torque_limits = [ -60 60 ];

link(23).index = 23;
link(23).name = 'l_hand';
link(23).parent = 22;
link(23).mass = 2.509;
link(23).offset_to_com_b = [ 0 0 0 ];
link(23).com_w = [ 0.05191 0.89101 1.46757 ];
link(23).moi_b = [ 0.00265 0 0
0 0.00446 0
0 0 0.00446 ];
link(23).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(24).index = 24;
joint(24).name = 'r_arm_usy';
joint(24).angle = 0.0;
joint(24).axis = [ 0 0.5 -0.866025 ];
joint(24).offset = [ 0.06441 -0.13866 0.10718 ];
joint(24).position_w = [ 0.05191 -0.13866 1.24627 ];
joint(24).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(24).angle_limits = [ -1.5708 0.785398 ];
joint(24).velocity_limits = [ -12 12 ];
joint(24).torque_limits = [ -212 212 ];

link(24).index = 24;
link(24).name = 'r_clav';
link(24).parent = 4;
link(24).mass = 3.45;
link(24).offset_to_com_b = [ 0 -0.048 0.084 ];
link(24).com_w = [ 0.05191 -0.18666 1.33027 ];
link(24).moi_b = [ 0.011 0 0
0 0.009 0.004
0 0.004 0.004 ];
link(24).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(25).index = 25;
joint(25).name = 'r_arm_shx';
joint(25).angle = 0.0;
joint(25).axis = [ 1 0 0 ];
joint(25).offset = [ 0 -0.14035 0.19609 ];
joint(25).position_w = [ 0.05191 -0.27901 1.44236 ];
joint(25).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(25).angle_limits = [ -1.5708 1.5708 ];
joint(25).velocity_limits = [ -12 12 ];
joint(25).torque_limits = [ -170 170 ];

link(25).index = 25;
link(25).name = 'r_scap';
link(25).parent = 24;
link(25).mass = 3.012;
link(25).offset_to_com_b = [ 0 0 0 ];
link(25).com_w = [ 0.05191 -0.27901 1.44236 ];
link(25).moi_b = [ 0.00319 0 0
0 0.00583 0
0 0 0.00583 ];
link(25).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(26).index = 26;
joint(26).name = 'r_arm_ely';
joint(26).angle = 0.0;
joint(26).axis = [ 0 1 0 ];
joint(26).offset = [ 0 -0.187 0.016 ];
joint(26).position_w = [ 0.05191 -0.46601 1.45836 ];
joint(26).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(26).angle_limits = [ 0 3.14159 ];
joint(26).velocity_limits = [ -12 12 ];
joint(26).torque_limits = [ -114 114 ];

link(26).index = 26;
link(26).name = 'r_uarm';
link(26).parent = 25;
link(26).mass = 3.388;
link(26).offset_to_com_b = [ 0 0.065 0 ];
link(26).com_w = [ 0.05191 -0.40101 1.45836 ];
link(26).moi_b = [ 0.00656 0 0
0 0.00358 0
0 0 0.00656 ];
link(26).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(27).index = 27;
joint(27).name = 'r_arm_elx';
joint(27).angle = 0.0;
joint(27).axis = [ 1 0 0 ];
joint(27).offset = [ 0 -0.119 0.00921 ];
joint(27).position_w = [ 0.05191 -0.58501 1.46757 ];
joint(27).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(27).angle_limits = [ -2.35619 0 ];
joint(27).velocity_limits = [ -12 12 ];
joint(27).torque_limits = [ -114 114 ];

link(27).index = 27;
link(27).name = 'r_larm';
link(27).parent = 26;
link(27).mass = 2.509;
link(27).offset_to_com_b = [ 0 0 0 ];
link(27).com_w = [ 0.05191 -0.58501 1.46757 ];
link(27).moi_b = [ 0.00265 0 0
0 0.00446 0
0 0 0.00446 ];
link(27).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(28).index = 28;
joint(28).name = 'r_arm_uwy';
joint(28).angle = 0.0;
joint(28).axis = [ 0 1 0 ];
joint(28).offset = [ 0 -0.187 -0.00921 ];
joint(28).position_w = [ 0.05191 -0.77201 1.45836 ];
joint(28).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(28).angle_limits = [ 0 3.14159 ];
joint(28).velocity_limits = [ -12 12 ];
joint(28).torque_limits = [ -114 114 ];

link(28).index = 28;
link(28).name = 'r_farm';
link(28).parent = 27;
link(28).mass = 3.388;
link(28).offset_to_com_b = [ 0 0.065 0 ];
link(28).com_w = [ 0.05191 -0.70701 1.45836 ];
link(28).moi_b = [ 0.00656 0 0
0 0.00358 0
0 0 0.00656 ];
link(28).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

joint(29).index = 29;
joint(29).name = 'r_arm_mwx';
joint(29).angle = 0.0;
joint(29).axis = [ 1 0 0 ];
joint(29).offset = [ 0 -0.119 0.00921 ];
joint(29).position_w = [ 0.05191 -0.89101 1.46757 ];
joint(29).rotation = [ 1 0 0 
0 1 0 
0 0 1 ];
joint(29).angle_limits = [ -1.1781 1.1781 ];
joint(29).velocity_limits = [ -12 12 ];
joint(29).torque_limits = [ -60 60 ];

link(29).index = 29;
link(29).name = 'r_hand';
link(29).parent = 28;
link(29).mass = 2.509;
link(29).offset_to_com_b = [ 0 0 0 ];
link(29).com_w = [ 0.05191 -0.89101 1.46757 ];
link(29).moi_b = [ 0.00265 0 0
0 0.00446 0
0 0 0.00446 ];
link(29).orientation = [ 1 0 0 
0 1 0 
0 0 1 ];

robot.j = joint;
robot.l = link;
