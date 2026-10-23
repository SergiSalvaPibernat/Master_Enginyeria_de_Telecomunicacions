clear all;
close all
clc
%% Exercici 1
% Plot the real and imaginary part of the mutual impedance of two segments of length
% /10 as function of the distance between their centers from 0 to 3
separation=linspace(0.1,3,500);
l=0.1;
Z=zeros(1,length(separation));
for n1=1:length(separation)
    Z(n1)=z12_dip(l,l,separation(n1),0);
end
figure (1)
plot(separation, real(Z), separation, imag(Z));
title("Real and Imaginary part of mutual impedance of two segments of length lambda/10")
legend("Real part", "Imaginary part")
grid on;
%% Exercici 2 & 3
H=0.5;
a=0.001;
N=131;
[I, zz, II]=current_distribution(H,a,N);
figure(2);
plot(zz, abs(II)/max(max(abs(II))));
title("Current distribution for H=0,5\lambda")
ylabel("I(A)")
grid on;
Zin=1/I((N+1)/2)
%% Exercici 4
%Case 1: 0.1*lambda
H_1=0.1;
[I_1, zz_1, II_1]=current_distribution(H_1,a,N);
I_TL_1 = sin(2*pi*(H_1-abs(zz_1)));
figure (3);
plot(zz, abs(II_1)/max(max(abs(II_1))),zz, abs(I_TL_1)/max(max(abs(I_TL_1))));
title("Current distribution for H=0,1\lambda")
ylabel("I(A)")
grid on;
legend("MoM", "Transmission line model")
Zin_1=1/I_1((N+1)/2)
%Case 2:0.25*lambda
H_2=0.25;
[I_2, zz_2, II_2]=current_distribution(H_2,a,N);
I_TL_2 = sin(2*pi*(H_2-abs(zz_2)));
figure (4);
plot(zz_2, abs(II_2)/max(max(abs(II_2))), zz_2, abs(I_TL_2)/max(max(abs(I_TL_2))));
title("Current distribution for H=0,25\lambda")
ylabel("I(A)")
grid on;
legend("MoM", "Transmission line model")
Zin_2=1/I_2((N+1)/2)
%Case 3: (5/8)*lambda
H_3=5/8;
[I_3, zz_3, II_3]=current_distribution(H_3,a,N);
I_TL_3 = sin(2*pi*(H_3-abs(zz_3)));
figure (5);
plot(zz_3, abs(II_3)/max(max(abs(II_3))), zz_3, abs(I_TL_3)/max(max(abs(I_TL_3))));
title("Current distribution for H=(5/8)\lambda")
ylabel("I(A)")
grid on;
legend("MoM", "TLM")
Zin_3=1/I_3((N+1)/2)
%% DATA
 Nth = 181;
 Nph = 360;
 inc_th = pi/(Nth-1);
 inc_ph = 2*pi/Nph;
 [ph,th] = meshgrid([0:Nph-1]*inc_ph,[0:Nth-1]*inc_th);
%% Exercici 5
aux = [0.1, 0.25, 0.5, 5/8];
for v = aux
    H=v;
   
    %MoM
    [I,zz,II]=current_distribution(H,a,N);
    II_norm = II/norm(II);
    Eth = zeros(size(th));
    Eph = zeros(size(ph));
    for f=1:length(II)
        Eth = Eth+sin(th).*II(f,:).*exp(1i*2*pi*cos(th).*zz(f,:));
    end
    P = abs(Eth).^2+abs(Eph).^2;
    t = P/max(max(P));
    D = (4*pi)/(sum(sum(t.*sin(th)))*inc_th*inc_ph);

    %Transmission line
    Eth_tl = zeros(size(th));
    Eph_tl = zeros(size(ph));
    II_tl = sin(2*pi*(H-abs(zz)));
    II_tl_nomr=II_tl/norm(II_tl);
    for f_tl=1:length(II_tl)
        Eth_tl = Eth_tl+sin(th).*II_tl(f_tl,:).*exp(j*2*pi*cos(th).*zz(f_tl,:));
    end
    P_tl = abs(Eth_tl).^2+abs(Eph_tl).^2;
    t_tl = P_tl/max(max(P_tl));
    D_tl = (4*pi)/(sum(sum(t_tl.*sin(th)))*inc_th*inc_ph);

    disp("The directivity of H=");
    disp(H);
    disp(" using the MoM model is D=");
    disp(D);
    disp("and using the TL model is D_tl=");
    disp(D_tl);

    %Plots
    figure();
    [ang,E] = extrae_corte(t,'XY');
    polar_xy(ang,E,1,0,5,12,'b');
    title("H-Plane H="+v+"\lambda");
    hold on
    [ang_tl,E_tl] = extrae_corte(t_tl,'XY');
    polar_xy(ang_tl,E_tl,1,0,5,12,'r');
    legend('MoM','TL');
    hold off
     
    figure();
    [ang,E] = extrae_corte(t,'ZX');
    polar_zx(ang,E,1,0,5,12,'b');
    title("E-Plane H="+v+"\lambda");
    hold on
    [ang_tl,E_tl] = extrae_corte(t_tl,'ZX');
    polar_zx(ang_tl,E_tl,1,0,5,12,'r');
    legend('MoM','TL');
    hold off
end
%% Exercici 6
H_6=(0.01:0.01:1.5)/2;
N_6=31;
Z = zeros(N,N);
V = zeros(N,1);
V((N+1)/2) = 1;
D=zeros(size(H_6));
D_tl=zeros(size(H_6));

for h=1:length(H_6) 
    %MoM
    l = (2*H_6(:,h))/((N_6+1)/2);
    z = [-(N_6-1)/2:(N_6-1)/2]'*l/2;
    Eth = zeros(size(th));
    Eph = zeros(size(ph));
    for n1 = 1:N_6
        Z(n1,n1) = z12_dip(l,l,a,0);
        for n2 = n1+1:N_6
            Z(n1,n2) = z12_dip(l,l,a,(z(n2)-z(n1)));
            Z(n2,n1) = Z(n1,n2);
        end
    end
    I = inv(Z)*V;
    zz = [z(1)-l/2;z;z(N_6)+l/2];
    II = [0;I;0];
    II_norm = II/norm(II);
    for f=1:length(II)
       Eth = Eth+sin(th).*II(f,:).*exp(j*2*pi*cos(th).*zz(f,:));
    end 
    P = abs(Eth).^2+abs(Eph).^2;
    t = P/max(max(P));
    D(:,h) = (4*pi)/(sum(sum(t.*sin(th)))*inc_th*inc_ph);

    %Transmission line
    Eth_tl = zeros(size(th));
    Eph_tl = zeros(size(ph));
    II_tl = sin(2*pi*(H_6(:,h)-abs(zz)));
    II_tl_nomr=II_tl/norm(II_tl);
    for f_tl=1:length(II_tl)
        Eth_tl = Eth_tl+sin(th).*II_tl(f_tl,:).*exp(j*2*pi*cos(th).*zz(f_tl,:));
    end
    P_tl = abs(Eth_tl).^2+abs(Eph_tl).^2;
    t_tl = P_tl/max(max(P_tl));
    D_tl(:,h) = (4*pi)/(sum(sum(t_tl.*sin(th)))*inc_th*inc_ph);
end
figure();
plot(2*H_6,D,2*H_6,D_tl);
title("Evolution of directivity");
xlabel('2H in respect of \lambda');
ylabel('Directivity');
legend('MoM', 'TL');
grid on;