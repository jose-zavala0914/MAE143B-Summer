%%% Homework #3 143B Jose Zavala
clear; close all, d=0.1; a=1; G=RR_pade(d,2,2)*RR_tf(1,[1 a]); D=1; L=G*D;
 figure(1), RR_rlocus(G*D);
%% Problem 1 
% we are taking D = K in this case so, I started off with D =1 and tweaked
% it from there 
% For a sufficiently small K it appears that the system remains stable. A
% smaller gain when D(s) = K makes it so the response is smoother and less
% prone to overshooting, resulting in the system to have less oscillations 
%% Problem 2 
% For a big enough K the system becomes unstable. Although a bigger K value
% in this case can help the system with tracking reference inputs better,
% when the value of K surpasses a specific value, it actually makes the
% system turn unstable, as it is prone to very high levels of overshoot and
% creates oscillatory behaviour into the system.

%% Problem 3
%after testing with more attention to detail, at approximately K = 16 and
%above the system becomes unstable. For any value that is less than 16 the
%root locus shows all the poles in the LHP, which indicate stability. For
%small adjustments above 16, the system becomes marginally stable since the
%poles are in the Im axis and any value bigger is unstable as the poles
%cross into the RHP, and this creates oscillations that will grow unbounded
% instability.

%% problem 4
omega = 16.5;
figure(2), D=1*real(RR_evaluate(-1/L,i*omega)), RR_rlocus(G*D);
% When D =1 our omega value is approximately 16.5 and MATLAB gives D =16.53.
%using equation 10.6 from RR, the formula worls to find the value of K that
%corresponds to any point on the locus of s. This is by solving 10.6  tell
%us the the location of a closed-loop pole at any s that is within the
%locus. Using the relation s =(iw) is where the branch cross the imaginary
%axis into the RHP.

%% problem 5 !!!!

d = 0.1; a = 1;
G = RR_pade(d, 16, 12) * RR_tf(1, [1 a]) ;
D = 1; L = G * D
figure(4); RR_rlocus(G*D)
% the value of which it turns unstable decreased a small amount, making it
% K  16.3


%% problem 6

d = 0.1;
a = 1;
[numDelay, denDelay] = pade(d, 2);

%  transfer functions
Delay = tf(numDelay, denDelay);
Plant = tf(1, [1 a]);

%  open-loop transfer function without K
G = Delay * Plant;

% Critical gain from Problems 3 and 4
Kcrit = 16.5;

% Nyquist Plot 1: Half the critical gain (Stable)

K1 = Kcrit/2;       % K = 8.25
L1 = K1 * G; % using that L(s) = D(s)g(s)
figure(5)
nyquist(L1)
grid on
title('Nyquist Plot: K = 8.25, half of Kcrit stable')

% Nyquist Plot 2: Twice the critical gain should be Unstable

K2 = 2*Kcrit;       % K = 33
L2 = K2 * G;

figure(6)
nyquist(L2)
grid on
title('Nyquist Plot: K = 33, twice the value makes it unstable')

% After plotting the Nyquist plots, we can see the open loop system does
% not have any poles in the right half plane, making P = 0. Using the
% Nyquist criterion for stability, the closed loop system is stable when
% the Nyquist plot does not encircle the point of -1+j0.
% when Kcritical is half its value the -1 point is not encircled, meaning
% there are no RHP closed poles, meaning it is stable.
% When K = twice its value, the plot shows an 2 encirclemntes, meaning N
% =2, sinc P =0, it gives Z =2, meaning there are 2 RHP closed loop poles,
% since Z = open loop zeros in the RHP which are closed loop poles. Since
% these are in the RHP, system is unstable.