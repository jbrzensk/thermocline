close all; clear all; clc;



TMIN = 3;
TMAX = 20;
DEPTH = 1000;
depth_scale = DEPTH;
CENTER_OF_GRADIENT = 200;   % Where do you want the switch to take place.
THICKNESS_OF_TRANSITION = 0.002;  % Thickness of the gradient



xgrid = linspace(0,1,1000);
mu =  (DEPTH-CENTER_OF_GRADIENT)/DEPTH ;
sigma2 = THICKNESS_OF_TRANSITION;
denom = sqrt(2*sigma2);

ygrid = TMIN + ((TMAX-TMIN)/2)*(1 + erf( (xgrid - mu)/denom));
xgrid = xgrid - 1;
xgrid = xgrid * depth_scale;

plot(xgrid,ygrid);

%% Actual Thermocline Values
figure(3)
plot(ygrid,xgrid,'b','LineWidth',4); grid on;
xlim([YMIN-5 TMAX + 5]);
ylim([-DEPTH 0+5]);
xlabel('Temperature [c]','Interpreter','latex');
ylabel('Depth [m]','Interpreter','latex');
title('Thermocline Example Plot');