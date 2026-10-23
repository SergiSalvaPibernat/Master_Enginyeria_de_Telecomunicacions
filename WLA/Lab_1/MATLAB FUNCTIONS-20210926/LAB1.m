clear all
clc

%% LAB 1 WLA Antoni Esteva Gelabert

% We define the angles theta and phi
Nth=181;
Nph=360;

% We describe a function to increase all the angles of theta and phi

inc_th=pi/(Nth-1);
inc_ph=2*pi/Nph;

[ph,th]=meshgrid([0:Nph-1]*inc_ph,[0:Nth-1]*inc_th);

%% PART 1

%% 1. Find the directivity of the antenna of the Pre-Work

%% and

%% 2. Plot the E plain and the H plain of the Pre-Work

% Electric field expression of the different components (theta and phi)

Eth=sin(th);

Eph=zeros(size(th));

P=abs(Eth).^2+abs(Eph).^2;

% We normalize the P
t=P/max(max(P));

% Find the Directivity of the antenna of the Pre-Work
D1=(4*pi)/(sum(sum(t.*sin(th)))*inc_th*inc_ph);

disp(" ");
disp("First part results:");
disp(" ");

disp('1. Directivity of the antenna of the Pre-Work:');
disp(D1);

% Plot the figures

% Figure 1 H PLANE

figure(1);
[ang,E]=extrae_corte(t,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 X PLANE

figure(2);
[ang,E]=extrae_corte(t,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

%% 3. Repeat exercise 1 and 2 for the new electric field expression

% Electric field expression of the different components (theta and phi)

Eth1=sin(th).*cos(0.7*pi*sin(th).*cos(ph));

Eph1=zeros(size(th));

P1=abs(Eth1).^2+abs(Eph1).^2;

% We normalize the P
t1=P1/max(max(P1));

% Find the Directivity of the new antenna 
D2=(4*pi)/(sum(sum(t1.*sin(th)))*inc_th*inc_ph);

disp('2. Directivity of the new antenna:')
disp(D2);

% Plot the figures

% Figure 1 H PLANE

figure(3);
[ang,E]=extrae_corte(t1,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 X PLANE

figure(4);
[ang,E]=extrae_corte(t1,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');


%% 4. Plot the diagrams of the point 4 of the Pre-Work

% Electric field expression of the different components (theta and phi) for
% d=0.25*landa, d=0.5*landa and d=0.75*landa

% When we normalize all the constants ara deleted, so it's not necessary to
% put the constants (j,w,I,2) to the Eth formula, it's enough if we put
% just de cosinus and sinus of the expression.

% --> For d=0.25*landa

Eth_25=cos((pi/4).*sin(th).*cos(ph)).*sin(th);

Eph_25=zeros(size(th));
P_25=abs(Eth_25).^2+abs(Eph_25).^2;
% We normalize the P
t_25=P_25/max(max(P_25));

% Plot the figures

% Figure 1 PLA H

figure(5);
[ang,E]=extrae_corte(t_25,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(6);
[ang,E]=extrae_corte(t_25,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

% --> For d=0.5*landa

Eth_50=cos((pi/2).*sin(th).*cos(ph)).*sin(th);


Eph_50=zeros(size(th));
P_50=abs(Eth_50).^2+abs(Eph_50).^2;
% We normalize the P
t_50=P_50/max(max(P_50));

% Plot the figures

% Figure 1 PLA H

figure(7);
[ang,E]=extrae_corte(t_50,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(8);
[ang,E]=extrae_corte(t_50,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

% --> For d=0.75*landa

Eth_75=cos((3*pi/4).*sin(th).*cos(ph)).*sin(th);


Eph_75=zeros(size(th));
P_75=abs(Eth_75).^2+abs(Eph_75).^2;
% We normalize the P
t_75=P_75/max(max(P_75));

% Plot the figures

% Figure 1 PLA H

figure(9);
[ang,E]=extrae_corte(t_75,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(10);
[ang,E]=extrae_corte(t_75,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');



%% 5. Repeat the point 4 but know I2=-I1

% Electric field expression of the different components (theta and phi) for
% d=0.25*landa, d=0.5*landa and d=0.75*landa

% When we normalize all the constants ara deleted, so it's not necessary to
% put the constants (j,w,I,2) to the Eth formula, it's enough if we put
% just de cosinus and sinus of the expression.

% --> For d=0.25*landa

Eth_25_=sin((pi/4).*sin(th).*cos(ph)).*sin(th);


Eph_25_=zeros(size(th));
P_25_=abs(Eth_25_).^2+abs(Eph_25_).^2;
% We normalize the P
t_25_=P_25_/max(max(P_25_));

% Plot the figures

% Figure 1 PLA H

figure(11);
[ang,E]=extrae_corte(t_25_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(12);
[ang,E]=extrae_corte(t_25_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

% --> For d=0.5*landa

Eth_50_=sin((pi/2).*sin(th).*cos(ph)).*sin(th);


Eph_50_=zeros(size(th));
P_50_=abs(Eth_50_).^2+abs(Eph_50_).^2;
% We normalize the P
t_50_=P_50_/max(max(P_50_));

% Plot the figures

% Figure 1 PLA H

figure(13);
[ang,E]=extrae_corte(t_50_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(14);
[ang,E]=extrae_corte(t_50_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

% --> For d=0.75*landa

Eth_75_=sin((3*pi/4).*sin(th).*cos(ph)).*sin(th);


Eph_75_=zeros(size(th));
P_75_=abs(Eth_75_).^2+abs(Eph_75_).^2;
% We normalize the P
t_75_=P_75_/max(max(P_75_));

% Plot the figures

% Figure 1 PLA H

figure(15);
[ang,E]=extrae_corte(t_75_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');

% Figure 2 PLA X

figure(16);
[ang,E]=extrae_corte(t_75_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');


%% PART 2

%% Analysis of a large antena as the superposition of elemental contriubtions for 2H=0.5

% Length of a single arm of the dipole
H=0.25;
% Number of segments in which we distribute the thread
N=15;
% Length of each segment of the thread
l=2*H/N;

% Now we know the current and we don't know the Electric field

Eth_=zeros(size(th));
Eph_=zeros(size(ph));

% We have to do a loop to find out the Eth of each segment

for n=1:N
    % Position of the center of the segment
    z=-H+l/2+(n-1)*l;
    % Sinusioidal current distribution
    I=sin(2*pi*(H-abs(z)));
    % Eth electric field
    Eth_=Eth_+sin(th)*I.*exp(i*2*pi*cos(th)*z);

end

P_=abs(Eth_).^2+abs(Eph_).^2;

% We normalize the P
t_=P_/max(max(P_));


% Find the Directivity of the new antenna 
D_=(4*pi)/(sum(sum(t_.*sin(th)))*inc_th*inc_ph);


disp(" ");
disp("Second part results:");
disp(" ");

disp('Directivity of the large antenna for 2H=0.5')
disp(D_);

% We plot E PLANE

figure(17);
[ang,E]=extrae_corte(t_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

%% Analysis of a large antena as the superposition of elemental contriubtions for H=0.75 and H=1

% ---> For 2H=0.75

% Length of a single arm of the dipole
H_=3/8;
% Number of segments in which we distribute the thread
N_=30;
% Length of each segment of the thread
l_=2*H_/N_;

% Now we know the current and we don't know the Electric field

Eth_1=zeros(size(th));
Eph_1=zeros(size(ph));

% We have to do a loop to find out the Eth of each segment

for n=1:N_
    % Position of the center of the segment
    z_=-H_+l_/2+(n-1)*l_;
    % Sinusioidal current distribution
    I_=sin(2*pi*(H_-abs(z_)));
    % Eth electric field
    Eth_1=Eth_1+sin(th)*I_.*exp(i*2*pi*cos(th)*z_);

end

P_1=abs(Eth_1).^2+abs(Eph_1).^2;

% We normalize the P
t_1=P_1/max(max(P_1));


% Find the Directivity of the new antenna 
D_1=(4*pi)/(sum(sum(t_1.*sin(th)))*inc_th*inc_ph);


disp('Directivity of the large antenna for 2H=0.75:')
disp(D_1);

% We plot PLA E

figure(18);
[ang,E]=extrae_corte(t_1,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

% ---> For 2H=1

% Length of a single arm of the dipole
H_2=0.5;
% Number of segments in which we distribute the thread
N_2=15;
% Length of each segment of the thread
l_2=2*H_2/N_2;

% Now we know the current and we don't know the Electric field

Eth_2=zeros(size(th));
Eph_2=zeros(size(ph));

% We have to do a loop to find out the Eth of each segment

for n=1:N_2
    % Position of the center of the segment
    z_2=-H_2+l_2/2+(n-1)*l_2;
    % Sinusioidal current distribution
    I_2=sin(2*pi*(H_2-abs(z_2)));
    % Eth electric field
    Eth_2=Eth_2+sin(th)*I_2.*exp(i*2*pi*cos(th)*z_2);

end

P_2=abs(Eth_2).^2+abs(Eph_2).^2;

% We normalize the P
t_2=P_2/max(max(P_2));


% Find the Directivity of the new antenna 
D_2=(4*pi)/(sum(sum(t_2.*sin(th)))*inc_th*inc_ph);


disp('Directivity of the large antenna for 2H=1:')
disp(D_2);

% We plot PLA E

figure(19);
[ang,E]=extrae_corte(t_2,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');

%% Plot the evolution of the Directivity as a function of 2H from 0 to 1.5*landa

H_3=(0:0.01:1.5)/2;
D_3=zeros(size(H_3));

for h=1:1:length(H_3)

    
    N_3=15;
    l_3=2*H_3(:,h)/N_3;

    Eth_3=zeros(size(th));
    Eph_3=zeros(size(ph));

    for n=1:N_3
    % Position of the center of the segment
    z_3=-H_3(:,h)+l_3/2+(n-1)*l_3;
    % Sinusioidal current distribution
    I_3=sin(2*pi*(H_3(:,h)-abs(z_3)));
    % Eth electric field
    Eth_3=Eth_3+sin(th).*I_3.*exp(i*2*pi*cos(th)*z_3);

    end

    P_3=abs(Eth_3).^2+abs(Eph_3).^2;

    % We normalize the P
    t_3=P_3/max(max(P_3));

    % Find the Directivity of the new antenna 
    D_3(:,h)=(4*pi)/(sum(sum(t_3.*sin(th)))*inc_th*inc_ph);

end

figure(20);
plot(2*H_3,D_3);
title("Directivity depending on the length 2H");
xlabel('Length 2H');
ylabel('Directivity');
   


