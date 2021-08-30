% Author: Sunwu Choi
% 2016 December

% --- drawer function that draws the calculated coordinate
function [out Y X time] = drawer(gravity,airRes,initdegree,velocity,spinXZ,mass,animation)
xinit = 0;
zinit = 0;
m = mass;
g = gravity;
air = airRes;
degree = initdegree*pi/180;
vinit = velocity;

x(1) = xinit;
z(1) = zinit;
vx(1) = vinit*sin(degree);
vz(1) = vinit*cos(degree);
v(1) = vinit;

flag = 1;
i = 1;
h = 0.01;

while flag
    v(i+1) = (vx(i)^2+vz(i)^2)^(1/2);
    vx(i+1) = vx(i) - h*(air*v(i)*vx(i)+spinXZ*vz(i))/m;
    vz(i+1) = vz(i) - h*(g + air*v(i)*vz(i)/m-spinXZ*vx(i)/m);
    x(i+1) = x(i) + h*vx(i);
    z(i+1) = z(i) + h*vz(i);
    
    if i > 1 && z(i) <= 0
        break;
    end
    
    i = i+1;
end
arraysize = size(x,2);
tmp = zeros(1,arraysize);
plot3(x,tmp,z);
title('Projectile Trajectory');
xlabel('X ( meter )');
ylabel('Y ( meter )');
zlabel('Z ( meter )');
legend('-DynamicLegend');

grid on
view([0 0]);
if animation == 1
    hold on
    p = plot3(x(1),tmp(1),z(1),'ro','MarkerFaceColor','red');
    hold off
    for i = 1:arraysize
        p.XData = x(i);
        p.YData = tmp(i);
        p.ZData = z(i);
        drawnow;
    end
    delete(p);
   
end
out = 1;
tmp = h*size(x); 
time = tmp(2);
land = x(size(x));
X = land(2);
Y = max(z);