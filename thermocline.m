function [ temp, depth ] = thermocline( TMIN, TMAX, DEPTH, CENTER_OF_GRADIENT, THICKNESS, NPOINTS )
%% Thermocline function:
% Generates a temperature gradient that mimics a thermocline.
%
% INPUT : 
%           TMIN : minimum temperature
%           TMAX : maximum temperature of the gradient
%           DEPTH : maximum depth of the output ( +meters )
%           CENTER_OF_GRADIENT : center of transition region ( +meters )
%           
%           optional-->
%           THICKNESS : Thickness of the transition region, this is based
%                       on an estimate of the standard deviation.
%                       Default = DEPTH/10;
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
%           [temp, depth] = thermocline(10,25,1000,200,100,3000);
%
% BY: Jared Brzenski
% San Diego State University
%
%%
if (nargin == 5 )
    NPOINTS = 1000;
elseif ( nargin == 4 )
    NPOINTS = 1000;
    THICKNESS = DEPTH/10; % 1/10th the depth
end

% Settign up the variables for the erf
depth = linspace(0,1,NPOINTS);
mu =  (DEPTH-CENTER_OF_GRADIENT)/DEPTH ;
sigma2 = THICKNESS;
sigma2 = THICKNESS / DEPTH;    % Scale the thickness
sigma2 = sigma2 / 2.3548 / 2 ; % FWHM estimate of SD
denom = sigma2 * sqrt(2);      % sigma * sqrt(2)

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
xlabel('Temperature [c]');
ylabel('Depth [m]');
title('Thermocline Example Plot');

end