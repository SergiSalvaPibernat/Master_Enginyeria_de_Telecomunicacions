Nth=181;
Nph=360;
inc_th=pi/(Nth-1);
inc_ph=2*pi/Nph;
[ph,th]=meshgrid([0:Nph-1]*inc_ph,[0:Nth-1]*inc_th);
%%
%Exercise 1
Eth1=sin(th);
Eph1=zeros(size(ph));

P1=abs(Eth1).^2+abs(Eph1).^2;
t1=P1/max(max(P1));

D1=(4*pi)/(sum(sum(t1.*sin(th)))*inc_th*inc_ph);

disp(" ");
disp("First part results:");
disp(" ");
disp('1. Directivity of the antenna of the Pre-Work:');
disp(D1);

%%
%Exercise 2
%Figure of the H plane
figure(1);
[ang,E]=extrae_corte(t1,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane");

%Figure of the E plane
figure(2);
[ang,E]=extrae_corte(t1,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane");

%%
%Exercise 3
Eth3=cos(0.7.*pi.*sin(th).*cos(ph)).*sin(th);
Eph3=zeros(size(th));

P3=abs(Eth3).^2+abs(Eph3).^2;
t3=P3/max(max(P3));

D3=(4*pi)/(sum(sum(t3.*sin(th)))*inc_th*inc_ph);
disp('3. Directivity of the new antenna:')
disp(D3);

figure(3);
[ang,E]=extrae_corte(t3,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane");

figure(4);
[ang,E]=extrae_corte(t3,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane");

%%
%Exercise 4

%d=0.25*landa
Eth_25=cos((pi/4).*sin(th).*cos(ph)).*sin(th);
Eph_25=zeros(size(th));

P_25=abs(Eth_25).^2+abs(Eph_25).^2;
t_25=P_25/max(max(P_25));
%H
figure(5);
[ang,E]=extrae_corte(t_25,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.25*lambda");
%E
figure(6);
[ang,E]=extrae_corte(t_25,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.25*lambda");

%d=0.5*landa

Eth_50=cos((pi/2).*sin(th).*cos(ph)).*sin(th);
Eph_50=zeros(size(th));

P_50=abs(Eth_50).^2+abs(Eph_50).^2;
t_50=P_50/max(max(P_50));
%H
figure(7);
[ang,E]=extrae_corte(t_50,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.5*lambda");
%E
figure(8);
[ang,E]=extrae_corte(t_50,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.5*lambda");

%d=0.75*landa

Eth_75=cos((3*pi/4).*sin(th).*cos(ph)).*sin(th);
Eph_75=zeros(size(th));

P_75=abs(Eth_75).^2+abs(Eph_75).^2;
t_75=P_75/max(max(P_75));
%H
figure(9);
[ang,E]=extrae_corte(t_75,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.75*lambda");
%E
figure(10);
[ang,E]=extrae_corte(t_75,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.75*lambda");

%%
%Exercise 5

%d=0.25*landa
Eth_25_=sin((pi/4).*sin(th).*cos(ph)).*sin(th);
Eph_25_=zeros(size(th));

P_25_=abs(Eth_25_).^2+abs(Eph_25_).^2;
t_25_=P_25_/max(max(P_25_));
%H
figure(11);
[ang,E]=extrae_corte(t_25_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.25*lambda");
%E
figure(12);
[ang,E]=extrae_corte(t_25_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.25*lambda");

%d=0.5*landa

Eth_50_=sin((pi/2).*sin(th).*cos(ph)).*sin(th);
Eph_50_=zeros(size(th));

P_50_=abs(Eth_50_).^2+abs(Eph_50_).^2;
t_50_=P_50_/max(max(P_50_));
%H
figure(13);
[ang,E]=extrae_corte(t_50_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.5*lambda");
%E
figure(14);
[ang,E]=extrae_corte(t_50_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.5*lambda");

%d=0.75*landa

Eth_75_=sin((3*pi/4).*sin(th).*cos(ph)).*sin(th);
Eph_75_=zeros(size(th));

P_75_=abs(Eth_75_).^2+abs(Eph_75_).^2;
t_75_=P_75_/max(max(P_75_));
%H
figure(15);
[ang,E]=extrae_corte(t_75_,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane for d=0.75*lambda");
%E
figure(16);
[ang,E]=extrae_corte(t_75_,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane for d=0.75*lambda");

%% Exerci 1 part 2
% Length of a single arm of the dipole
H=0.25;
% Number of segments in which we distribute the thread
N=15;
% Length of each segment of the thread
l=2*H/N;

Eth_=zeros(size(th));
Eph_=zeros(size(ph));

for n=1:N
    % Position of the center of the segment
    z=-H+l/2+(n-1)*l;
    % Sinusioidal current distribution
    I=sin(2*pi*(H-abs(z)));
    % Eth electric field
    Eth_=Eth_+sin(th)*I.*exp(i*2*pi*cos(th)*z);
end
P2_1=abs(Eth_).^2+abs(Eph_).^2;
t2_1=P2_1/max(max(P2_1));
%H
figure(17);
[ang,E]=extrae_corte(t2_1,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane");
%E
figure(18);
[ang,E]=extrae_corte(t2_1,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane");

D2_1=(4*pi)/(sum(sum(t2_1.*sin(th)))*inc_th*inc_ph);
disp(" ");
disp("Second part results:");
disp(" ");
disp('Directivity of the large antenna for 2H=0.5')
disp(D2_1);


%% Exerci 2 part 2
%2H=0.75*lambda
% Length of a single arm of the dipole
H=3/8;
% Number of segments in which we distribute the thread
N=30;
% Length of each segment of the thread
l=2*H/N;
Eth_=zeros(size(th));
Eph_=zeros(size(ph));

for n=1:N
    z=-H+l/2+(n-1)*l;
    I=sin(2*pi*(H-abs(z)));
    Eth_=Eth_+sin(th)*I.*exp(1i*2*pi*cos(th)*z);
end
P2_75=abs(Eth_).^2+abs(Eph_).^2;
t2_75=P2_75/max(max(P2_75));
%H
figure(19);
[ang,E]=extrae_corte(t2_75,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane");
%E
figure(20);
[ang,E]=extrae_corte(t2_75,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane");

D2_2=(4*pi)/(sum(sum(t2_75.*sin(th)))*inc_th*inc_ph);
disp('Directivity of the large antenna for 2H=0.75:')
disp(D2_2);

%2H=lambda
% Length of a single arm of the dipole
H=0.5;
% Number of segments in which we distribute the thread
N=15;
% Length of each segment of the thread
l=2*H/N;
Eth_=zeros(size(th));
Eph_=zeros(size(ph));

for n=1:N
    z=-H+l/2+(n-1)*l;
    I=sin(2*pi*(H-abs(z)));
    Eth_=Eth_+sin(th)*I.*exp(1i*2*pi*cos(th)*z);
end
P2_1=abs(Eth_).^2+abs(Eph_).^2;
t2_1=P2_1/max(max(P2_1));
%H
figure(21);
[ang,E]=extrae_corte(t2_1,'XY');
polar_xy(ang,E,1,0,5,12,'b-');
title("Figure of the H plane");
%E
figure(22);
[ang,E]=extrae_corte(t2_1,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
title("Figure of the E plane");

D2_2_1=(4*pi)/(sum(sum(t2_1.*sin(th)))*inc_th*inc_ph);
disp('Directivity of the large antenna for 2H=1:')
disp(D2_2_1);

%% Exercici 3 part 2
H_3=(0:0.001:1.5)/2;
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
    t_3=P_3/max(max(P_3));

    % Find the Directivity of the new antenna 
    D_3(:,h)=(4*pi)/(sum(sum(t_3.*sin(th)))*inc_th*inc_ph);

end

figure(23);
plot(2*H_3,D_3);
title("Directivity depending on the length 2H");
xlabel('Length 2H');
ylabel('Directivity');
