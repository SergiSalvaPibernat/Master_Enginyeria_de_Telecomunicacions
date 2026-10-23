NLPS=30; % en dB
N=8;     % número de antenas

a=pol_chebychev(N-1);
x_z=roots(a);
x=linspace(0,3,501);
T=polyval(a,x);
x0=interp1(T,x,10^(NLPS/20),'spline');

psi=linspace(-pi,pi,201);
x=x0*cos(psi/2);
FA=polyval(a,x);

FA=FA/max(abs(FA));


psi_z=2*acos(x_z/x0);

figure(2);
zz=exp(i*psi_z);
plot_zeros(zz);

a=poly(zz);

FA2=zeros(size(psi));
for l=1:N
    n=l-(N+1)/2;
    FA2=FA2+a(l)*exp(i*n*psi);
end

FA2=FA2/max(abs(FA2));

figure(1);
plot(psi*180/pi,20*log10(abs(FA)),psi*180/pi,20*log10(abs(FA2)));
grid on;
axis([-180 180 -40 0]);
