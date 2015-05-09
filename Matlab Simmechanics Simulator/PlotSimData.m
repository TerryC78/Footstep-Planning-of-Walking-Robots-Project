% Plots Data from the Simulation
%
% Author: Simon Kalouche
% BioRobotics Lab

close all

%% Plot Simulation Data
%---------------------------------------------
f1 = figure(1); % COM position vs time
hold on
grid on
title('Hexapod Center of Mass Position','FontSize',20)
xlabel('Time [s]','FontSize',20)
ylabel('Distance [m]','FontSize',20)
plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,1));
plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,2));
plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,3));
%plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,4));
%plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,5),'m');
%plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,6));
legend('x-pos','y-pos','z-pos');
hold off


%---------------------------------------------
f2 = figure(2); % hexapod speed
hold on
grid on
title('Hexapod Velocity Data','FontSize',20)
xlabel('Time [s]','FontSize',20)
ylabel('Velocity [m/s]','FontSize',20)
%plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,4));
plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,5));
%plot(COG_pos_vel.time,COG_pos_vel.signals.values(:,6));

%calculate avg speed
avgSpeed = ones(length(COG_pos_vel.time),1)*mean(COG_pos_vel.signals.values(:,5));
plot(COG_pos_vel.time, avgSpeed);
legend('y-vel');
hold off


%---------------------------------------------
if (exist('CPGsigA'))
    f3 = figure(3); % CPG Signals
    hold on
    grid on
    title('CPG Signals','FontSize',20)
    xlabel('Time [s]','FontSize',20)
    ylabel('CPG Output Signal','FontSize',20)
    plot(CPGsigA.time,CPGsigA.signals.values(:,1));
    plot(CPGsigB.time,CPGsigB.signals.values(:,1));
    legend('limb set A','limb set B');
    hold off
end

%---------------------------------------------
f4 = figure(4); % IK joint angles 
subplot(1,2,1)
hold on 
grid on
title('Set A: Joint Angles','FontSize',20)
xlabel('% of gait','FontSize',20)
ylabel('Angle [deg]','FontSize',20)
%plot(5.2*CPGsigA.time(1:13000),CPGsigA.signals.values(1:13000,1));
plot(1:num,leg(1).hip.angles.data(1:num));
plot(1:num,leg(1).knee.angles.data(1:num));
plot(1:num,leg(1).ankle.angles.data(1:num));
legend('hip angle (CPG)','knee angle','ankle angle','Location','SouthWest');
hold off

subplot(1,2,2)
hold on
grid on
%title('Manipulating Limbs: Joint Angles','FontSize',20)
title('Set B: Joint Angles','FontSize',20)
xlabel('% of gait','FontSize',20)
ylabel('Angle [deg]','FontSize',20)
%plot(5.2*CPGsigB.time(1:13000),CPGsigB.signals.values(1:13000,1));
plot(1:num,leg(2).hip.angles.data(1:num));
plot(1:num,leg(2).knee.angles.data(1:num));
plot(1:num,leg(2).ankle.angles.data(1:num));
legend('hip angle (CPG)','knee angle','ankle angle','Location','SouthWest');
hold off


%---------------------------------------------
f5 = figure(5); % Ground Reaction Forces
hold on
grid on
title('Ground Reaction Forces','FontSize',20)
xlabel('Time [s]','FontSize',20)
ylabel('Force [N]','FontSize',20)
plot(GRF.time,GRF.signals.values(:,1));
plot(GRF.time,GRF.signals.values(:,2));
plot(GRF.time,GRF.signals.values(:,3));
legend('F_x','F_y','F_z','FontSize',50);
ylim([-100 250])
hold off

 
% saveas(f1,'COM_position','jpg');
% saveas(f2,'Hexapod_speed','jpg');
% %saveas(f3,'CPG_signals','jpg');
% saveas(f4,'Joint_angles','jpg');
% saveas(f5,'GRF','jpg');



