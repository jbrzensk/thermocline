function [ temp, depth ] = thermocline( TMIN, TMAX, DEPTH, CENTER_OF_GRADIENT, THICKNESS, NPOINTS )
%% thermocline function:
% Generates a temperature gradient that mimicks a thermocline.
%
% INPUT : 
%           TMIN : minimum temperature
%           TMAX : maximum temperature of the gradient
%           DEPTH : maximum depth of the output ( +meters )
%           CENTER_OF_GRADIENT : center of transition region ( +meters )
%           
%           optional-->
%           THICKNESS : Thickness of the transition region, 0.1 - 0.001,
%                       default=0.01, play with this.
%           NPOINTS : Number of points of output desired, default=1000;
%
% OUTPUT :
%           temp : temperatures (x-axis)
%           depth : depth, negative values, from 0 to -DEPTH;
%
% EXAMPLE :
%           To generate a thermocline between 10 and 25 degrees (c), with
%           the center of the transition at -200m, with approximately a
%           transition width of 100 meters, a maximum depth of 1000
%           meters, and using 3000 points, the command would be:
%
%           [temp, depth] = thermocline(10,25,1000,200,0.001,3000);
%
%%
if (nargin == 5 )
    NPOINTS = 1000;
elseif ( nargin == 4 )
    NPOINTS = 1000;
    THICKNESS = 0.01;
end

% Settign up the variables for the erf
depth = linspace(0,1,NPOINTS);
mu =  (DEPTH-CENTER_OF_GRADIENT)/DEPTH ;
sigma2 = THICKNESS;
denom = sqrt(2*sigma2);

% temperature values calculated here
temp = TMIN + ((TMAX-TMIN)/2)*(1 + erf( (depth - mu)/denom));

% rescale depth from 0->1 to 0->-depth
depth = depth - 1;
depth = depth * DEPTH;

%% Plot final distribution
figure(3)
plot(temp,depth,'b','LineWidth',4); grid on;
xlim([TMIN-5 TMAX + 5]);
ylim([-DEPTH 0+5]);
xlabel('Temperature [c]','Interpreter','latex');
ylabel('Depth [m]','Interpreter','latex');
title('Thermocline Example Plot');

end