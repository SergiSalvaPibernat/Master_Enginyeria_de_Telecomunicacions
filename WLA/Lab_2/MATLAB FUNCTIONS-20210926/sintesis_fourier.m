
psi=linspace(-pi,pi,401);

% definimos la funcion a sintetizar
FA = (psi > -pi/2).*(psi < pi/2); % FA=1 -pi/2 < psi < pi/2, FA=0 resto


N=12; % Nḿero de elementos para realizar la síntesis


a=zeros(N,1);
for l=1:N
    n=l-(N+1)/2;
    a(l)=sum(FA.*exp(-i*n*psi))/(length(psi)-1);
end

zz=roots(a);
figure(1);
plot_zeros(zz);



FA2=zeros(size(psi));
for l=1:N
    n=l-(N+1)/2;
    FA2=FA2+a(l)*exp(i*n*psi);
end

figure(2);
plot(psi*180/pi,abs(FA),psi*180/pi,abs(FA2));
grid on;
xlim([-180 180]);
xlabel('\psi (deg.)');