function plot_zeros(zz)

figure(gcf);

xmax=max(real(zz))+0.5;
xmax=max([1.5 xmax]);
xmin=min(real(zz))-0.5;
xmin=min([-1.5 xmin]);

ymax=max(imag(zz))+0.5;
ymax=max([1.5 ymax]);
ymin=min(imag(zz))-0.5;
ymin=min([-1.5 ymin]);

cc=linspace(0,2*pi,201);
cc=exp(i*cc);
plot(real(cc),imag(cc),'-b');
hold on;
hh=plot([xmin xmax],[0 0],'-y');
set(hh,'LineWidth',3);
hh=plot([0 0],[ymin ymax],'-y');
set(hh,'LineWidth',3);
hh=plot(real(zz),imag(zz),'or');
set(hh,'LineWidth',3);
hold off;
axis equal;
axis([xmin xmax ymin ymax]);
grid on;

xlabel('Re[z]');
ylabel('Im[z]');
