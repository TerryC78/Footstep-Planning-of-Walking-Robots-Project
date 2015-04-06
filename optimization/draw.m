function draw( tree,xd, com )

if nargin<3
    com = [0,0,0];
end
if nargin<2
    xd = [0,0,0];
end
% draw( tree ), return value is meaningless

for jj = 1:4
    subplot(2,2,jj)
    hold on
    plot3(xd(1),xd(2),xd(3),'rx')
    grid on
    for i = 2:29
        x(1) = tree.j(i).position_w(1);
        y(1) = tree.j(i).position_w(2);
        z(1) = tree.j(i).position_w(3);
        ii = tree.l(i).parent;
        x(2) = tree.j(ii).position_w(1);
        y(2) = tree.j(ii).position_w(2);
        z(2) = tree.j(ii).position_w(3);
        plot3( x, y, z )
        
    end
    %% rectangle of support
    w = 0.302/2;
    l = 0.262/2;
    z = 0.08112;
    
    
    %%
    
    rx=[-1 1 1 -1;1 1 -1 -1;1 1 -1 -1;-1 1 1 -1]*l;
    ry=[-1 -1 1 1;-1 1 1 -1;-1 1 1 -1;-1 -1 1 1]*w;
    rz=[0 0 0 0;0 0 0 0 ;1 1 1 1;1 1 1 1]*z;
    for kk=1:4
        plot3(rx(:,kk),ry(:,kk),rz(:,kk),'k');
    end
    plot3([com(1) com(1)], [com(2) com(2)], [0 com(3)],'x-g')
    %%
    axis( [-1 1 -1 1 0 2 ] );
    xlabel('Xaxis')
    ylabel('Yaxis')
    zlabel('Zaxis')
    hold off
    
    
end

subplot(221); view(3)
subplot(222); view(0,90);
subplot(223); view(90,0);
subplot(224); view(0,0);
grid on