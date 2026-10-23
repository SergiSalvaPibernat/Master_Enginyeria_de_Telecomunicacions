psi_z=[45 -45 90 135 180 -135 -90 ]*pi/180;

zz=exp(i*psi_z);

figure(1);
plot_zeros(zz);

a=poly(zz);

psi=linspace(-pi,pi,301);
FA=zeros(size(psi));
N=length(a);
for l=1:N
    n=l-(N+1)/2;
    FA=FA+a(l)*exp(i*n*psi);
end

figure(2);
plot(psi*180/pi,abs(FA));
grid on;
xlim([-180 180]);
xlabel('\psi (deg.)');
