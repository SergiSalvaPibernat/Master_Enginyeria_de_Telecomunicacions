a=[1 2 3 4 3 2 1 ];
d=.5;
alpha=0 *pi/180;

% ---------------------

figure(1);
zz=roots(a);
plot_zeros(zz);

mv_max=2*pi*d+alpha;
mv_min=-2*pi*d+alpha;

mv_max=ceil(mv_max/(pi/2))*pi/2;
mv_min=floor(mv_min/(pi/2))*pi/2;

mv_max=max([mv_max pi]);
mv_min=min([mv_min -pi]);

psi=linspace(mv_min,mv_max,401);
N=length(a);
FA=zeros(size(psi));
for l=1:N
    n=l-(N+1)/2;
    FA=FA+a(l)*exp(i*n*psi);
end
FA=FA/max(abs(FA));


figure(2);
plot(psi*180/pi,abs(FA));
hold on;
hh=plot([2*pi*d+alpha 2*pi*d+alpha]*180/pi,[0 1],'y');
set(hh,'LineWidth',3);
hh=plot([-2*pi*d+alpha -2*pi*d+alpha]*180/pi,[0 1],'y');
set(hh,'LineWidth',3);
hh=plot([alpha alpha]*180/pi,[0 1],'r');
set(hh,'LineWidth',1);
hold off;
grid on;
xlim([mv_min mv_max]*180/pi);
xlabel('\psi (deg.)');

th=linspace(0,pi,201);
N=length(a);
FA=zeros(size(th));
for l=1:N
    n=l-(N+1)/2;
    FA=FA+a(l)*exp(i*n*(2*pi*d*cos(th)+alpha));
end
FA=FA/max(abs(FA));

figure(3);
plot(th*180/pi,abs(FA));
grid on;
xlim([0 180]);
xlabel('\theta (deg.)');

figure(4);
polar_xy(th*180/pi,abs(FA),1,0,5,8,'-b');



