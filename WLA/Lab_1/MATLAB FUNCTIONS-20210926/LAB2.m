clear all
clc

%% LAB 2 WLA Antoni Esteva Gelabert


% We define the angles theta and phi
Nth=181;
Nph=360;

% We describe a function to increase all the angles of theta and phi

inc_th=pi/(Nth-1);
inc_ph=2*pi/Nph;

[ph,th]=meshgrid([0:Nph-1]*inc_ph,[0:Nth-1]*inc_th);

%% 1. Plot the real and imaginary part of the mutual impedance of two 
% segments of length landa/10 as function of the distance between their 
% centers from 0 to 3*landa

x=1;

l=0:0.01:3;

for i=0:0.01:3

   T(x)=z12_dip(0.1,0.1,0.1,i);
   x=x+1;

end

figure(1);
plot(l,real(T));
title('Absolute value of the Mutual Impedance');
hold on
plot(l,imag(T));
legend('Real','Imaginary');
hold off



%% 2. Compute de MATLAB code and 3. Check the results

% Length of half dipole
H=0.1;
% Radius of the dipole
a=0.001;
% Number of segments of the dipole (odd number)
N=31;

% Length of the segment
l=(2*H)/((N+1)/2);

% Coordinate z
z=[-(N-1)/2:(N-1)/2]'*l/2;

% Z matrix
Z=zeros(N,N);
% V matrix
V=zeros(N,1);

% The center element of the V matrix has to be 1
V((N+1)/2)=1;

% We do the loop through the different segments of the dipole (N) to find 
% the different variables

for n1=1:N

    % We find de value and put it in the Z matrix
    Z(n1,n1)=z12_dip(l,l,a,0);

    for n2=n1+1:N

        Z(n1,n2)=z12_dip(l,l,a,(z(n2)-z(n1)));
        Z(n2,n1)=Z(n1,n2);

    end

end

% Now we calculate and compute the I matrix

I=inv(Z)*V;

zz=[z(1)-l/2;z;z(N)+l/2];

II=[0;I;0];

figure(2);
plot(zz,abs(II));
title('Current distribution for H=0.25*landa');

% Zin=Voltage/Current and due to V=1:

Zin=1/I((N+1)/2);

disp('The input impedance is: ');
disp(Zin);

%% 4. Compare the current distribution for a dipole H=0.1landa, H=0.25landa and
% 5/8landa, with the transmission line model.

% Length of half dipole
H=0.1;
% Radius of the dipole
a=0.001;
% Number of segments of the dipole (odd number)
N=179;

Eth=zeros(size(th));
Eph=zeros(size(ph));

% Length of the segment
l=(2*H)/((N+1)/2);

% Coordinate z
z=[-(N-1)/2:(N-1)/2]'*l/2;

% Z matrix
Z=zeros(N,N);
% V matrix
V=zeros(N,1);

% The center element of the V matrix has to be 1
V((N+1)/2)=1;

% We do the loop through the different segments of the dipole (N) to find 
% the different variables

for n1=1:N

    % We find de value and put it in the Z matrix
    Z(n1,n1)=z12_dip(l,l,a,0);

    for n2=n1+1:N

        Z(n1,n2)=z12_dip(l,l,a,(z(n2)-z(n1)));
        Z(n2,n1)=Z(n1,n2);

    end

end

for n=1:N

      I_tl=sin(2*pi*(H-abs(z)));

end

% Now we calculate and compute the I matrix

I=inv(Z)*V;

zz=[z(1)-l/2;z;z(N)+l/2];

II=[0;I;0];

II_norm=II/norm(II);

II_tl=[0;I_tl;0];

II_tl_norm=II_tl/norm(II_tl);

    for f=1:length(II)
            Eth = Eth+sin(th).*II(f,:).*exp(j*2*pi*cos(th).*zz(f,:));
    end
         
     P = abs(Eth).^2+abs(Eph).^2;
     t = P/max(max(P));
     
     D = (4*pi)/(sum(sum(t.*sin(th)))*inc_th*inc_ph);

    disp('Directivity');
    disp(D)

figure(3);
[ang,E]=extrae_corte(t,'ZX');
polar_zx(ang,E,1,0,5,12,'b-');
figure(4)
[ang,E]=extrae_corte(t,'XY');
polar_xy(ang,E,1,0,5,12,'b-');


% Now we find the I for a transmission line

figure(5);
plot(zz,abs(II_norm));
title('H=5/8*landa');
hold on
plot(zz,abs(II_tl_norm));
legend('MoM','Transmission Line');
hold off

% Zin=Voltage/Current and due to V=1:

Zin=1/I((N+1)/2);

disp('Results part 3');
disp('The input impedance is: ');
disp(Zin);

% %% 5. Obtain a plot for the directivity as function of 2H/ from 0.1 to 1.5 using the transmission
% % line model and the MoM. 
% 
% % MOM
% 
% H = (0.1:0.01:1.5)/2; %dipole length
%  D = zeros(size(H));
%  D_tl = zeros(size(H));
%  
%  a = 0.001; % radius
%  N = 31; %number of segments
%  
%  Z = zeros(N,N);
%  V = zeros(N,1);
%  V((N+1)/2) = 1;
%  
%  for h=1:length(H)
%      
%      l = (2*H(:,h))/((N+1)/2);
%      z = [-(N-1)/2:(N-1)/2]'*l/2;
%      Eth = zeros(size(th));
%      Eph = zeros(size(ph));
%      Eth_tl = zeros(size(th));
%      Eph_tl = zeros(size(ph));
%      
%      for n1 = 1:N
%          Z(n1,n1) = z12_dip(l,l,a,0);
%          for n2 = n1+1:N
%              Z(n1,n2) = z12_dip(l,l,a,(z(n2)-z(n1)));
%              Z(n2,n1) = Z(n1,n2);
%          end
%      end
% 
%      I_tl = sin(2*pi*(H(:,h)-abs(z)));
% 
%      I = inv(Z)*V;
% 
%      zz = [z(1)-l/2;z;z(N)+l/2];
%      II = [0;I;0];
% 
%      II_norm = II/norm(II);
%      II_tl = [0;I_tl;0];
%      II_tl_norm = II_tl/norm(II_tl);
%      
%      for f=1:length(II)
%         Eth = Eth+sin(th).*II(f,:).*exp(j*2*pi*cos(th).*zz(f,:));
%      end
%      
%      P = abs(Eth).^2+abs(Eph).^2;
%      t = P/max(max(P));
%      
%      D(:,h) = (4*pi)/(sum(sum(t.*sin(th)))*inc_th*inc_ph);
%      
%      %Transmision line
%      
%      for f_tl=1:length(II_tl)
%         Eth_tl = Eth_tl+sin(th).*II_tl(f_tl,:).*exp(j*2*pi*cos(th).*zz(f_tl,:));
%      end
%      
%      P_tl = abs(Eth_tl).^2+abs(Eph_tl).^2;
%      t_tl = P_tl/max(max(P_tl));
%      
%      D_tl(:,h) = (4*pi)/(sum(sum(t_tl.*sin(th)))*inc_th*inc_ph);
%  end
%  
% figure(5);
% plot(2*H,D);
% hold on
% plot(2*H,D_tl);
% title("Directivity depending on the length 2H");
% xlabel('Length 2H');
% ylabel('Directivity');
% legend('MoM', 'Transmission Line');
% hold off





