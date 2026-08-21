clc;
clear all;
format long
%% problem1a
Num  = [1, 2.58];
Den = [1, 38.73];
sys = tf(Num,Den);
figure
bode(sys);
legend('lead compensator');
grid on;

%% problem2a
Num2 = [1,100];
Den2 = [1,1];
sys2 = tf(Num2,Den2);
figure 
bode(sys2);
grid on;
legend('lag compensator')

%% problem2b
Num2b = [1,31.62];
Den2b = [1, 3.16];
sys2b = tf(Num2b,Den2b)^2;
figure 
bode(sys2,sys2b);
grid on;
legend('lag compensator', 'double lag');

%% problem3a
F = RR_LPF_butterworth(4,300)
num = 8.1e9;
den = [1 783.94 307279 7.055e7 8.1e9];
figure 
G3a = tf(num,den);
bode(G3a)
grid on

%% 3b 

F =  RR_LPF_inv_chebyshev(4,0.001,950)
% make the bode diagram
num = [.001 0 7219.99 0 6.51e9];
den = [ 1 735.7 270634.72 5.85e7 6.51e9];
figure 
G3b = tf(num,den);
bode (G3a,G3b)


%% 4b
s = tf('s')
Dlead = (s+2.58)/(s+38.73);
Ddouble = ((s+31.62)/(s+3.16))^2;
Dinv = ((0.001*s^4 + 7219.99*s^2 + 6.51e9)/(s^4 + 735.7*s^3 + 270634.72*s^2 + 5.85e7*s + 6.51e9));
Ds = Dlead*Ddouble*Dinv
opt = c2dOptions('Method','tustin','PrewarpFrequency',10);
Dz = c2d(Ds,0.01,opt)


%% 5b
G5b = 100/(s^2-100);

Dsimple = (s-10 )/s;

K = 1/abs(evalfr(G5b*Ds, 1i*10));

Dloop = K*Ds
figure
subplot(2,2,1)
rlocus(G5b*Dsimple)
subplot(2,2,2)
rlocus(G5b*Dloop)
subplot(2,2,3)
bode (G5b *Dsimple)
subplot(2,2,4)
bode(G5b *Dloop)

Tsimple = feedback(G5b *Dsimple,1);
Tloop = feedback(G5b *Dloop,1);

figure
step (Tsimple,Tloop)
legend ('simple', 'loop shape')
grid on



%opt = c2dOptions('Method','tustin','PrewarpFrequency',10);
%Dz = c2d(Ds,0.01,opt)