close all; clear;

%% Homework #2 Answers
% in the third figure, the issue with the step response is that the
% temperature rises above the T max value of 50 degrees, which represents
% something that is physically not possible in this system. This error can
% lead to further inaccurate tracking which increases isntabilities in the
% system.

%this creates an issue because the reference input would be wrong leading
%to the controller to decrease the high temperature input and believes it
%needs to compensate even more than it really does.

% I started off with a proprtional controller where D(S) = K and noted that
% the recurring issue with the new plots was a overshoot in the system,
% which led me to implementing a PI controller as it would be better at
% tracking and predict the overshoot in a better manner. After tweaking the
% gain (K) value, I found it to be somewhere around K = 1.15 that gives us
% the desired results.



%% given values from problem description
d = 12; 
a0 = 0.02; 

% using the 2nd-order Pade approximation
G = RR_pade(d, 2, 2) * RR_tf(1, [1/a0 1]); 

K = 1.15; 
z = 0.02; %% i introduced this value to make a pole-zer0  cancellation
pf = 0.1;
D = K * pf * RR_tf([1 z], [1 pf 0]); 
P = 1; % Loop prefactor for integral control
% Root Locus plot
figure(1); 
RR_rlocus(G); 
axis([-.4 .3 -.3 .3]);

% Figure 2: graphing the y(t)
figure(2); 
g.T = 200; 
RR_step(35 + 10*P*G*D/(1 + G*D), g); 
axis([0 200 32 55]);

% Figure 3: u(t)
figure(3); 
RR_step(35 + 10*P*D/(1 + G*D), g); 
axis([0 200 35 52]);

% Figure 4: High-Order Verification 16th-order Pade model
G_high = RR_pade(d, 16, 13) * RR_tf(1, [1/a0 1]);
figure(4);
RR_step(35 + 10*P*G_high*D/(1 + G_high*D), g);
axis([0 200 32 55]);