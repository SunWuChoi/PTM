% Author: Sunwu Choi
% 2016 December

% --- drawer function for 3d mode
function [out Y X time] = drawer3d(gravity,airRes,initdegree,velocity,initspinxy,initspinxz,initspinyz,mass,animation)
xinit = 0;
yinit = 0;
zinit = 0;

m = mass;
g = gravity;
air = airRes;
degree = initdegree*pi/180;
vinit = velocity;
spinxy = initspinxy;
spinxz = initspinxz;
spinyz = initspinyz;



x(1) = xinit;
y(1) = yinit;
z(1) = zinit;
vx(1) = vinit*sin(degree);
vy(1) = 0;
vz(1) = vinit*cos(degree);
v(1) = vinit;

flag = 1;
i = 1;
h = 0.01;

while flag
    v(i+1) = (vx(i)^2+vy(i)^2+vz(i)^2)^(1/2);
    vx(i+1) = vx(i) - h*(air*v(i)*vx(i)-spinxy*vy(i)+spinxz*vz(i))/m;
    vy(i+1) = vy(i) - h*(air*v(i)*vy(i)+spinxy*vx(i)+spinyz*vz(i))/m;
    vz(i+1) = vz(i) - h*(g + (air*v(i)*vz(i)-spinyz*vy(i)-spinxz*vx(i))/m);
    x(i+1) = x(i) + h*vx(i);
    y(i+1) = y(i) + h*vy(i);
    z(i+1) = z(i) + h*vz(i);
    
    
    
    if i > 1 && z(i) <= 0
        break;
    end
    
    i = i+1;
end
arraysize = size(x,2);
plot3(x,y,z);
title('Projectile Trajectory');
xlabel('X ( meter )');
ylabel('Y ( meter )');
zlabel('Z ( meter )');
legend('-DynamicLegend');

grid on
view([-21 12]);
if animation == 1
    hold on
    p = plot3(x(1),y(1),z(1),'ro','MarkerFaceColor','red');
    hold off
    for i = 1:arraysize
        drawnow;
        p.XData = x(i);
        p.YData = y(i);
        p.ZData = z(i);
    end
    delete(p);
end
out = 1;
tmp = h*size(x); 
time = tmp(2);
land = (x(size(x)).^2+y(size(y)).^2).^(1/2);
X = land(2);
Y = max(z);