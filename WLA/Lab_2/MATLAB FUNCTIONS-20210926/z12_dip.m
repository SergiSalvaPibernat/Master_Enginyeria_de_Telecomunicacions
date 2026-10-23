function Z12=z12_dip(l1,l2,x0,z0)
% function Z12=z12_dip(l1,l2,x0,z0)
% Funcion que calcula la impedancia mútua entre dos dipolos paralelos (corrientes orientadas en la misma dirección)
% con distribución senoidal de corriente
% l1,l2 : longitudes de los dipolos (en lambdas)
% x0 : distancia entre centros de los dipolos en la dirección perpendicular a las corrientes
% z0 : distancia entre centros de los dipolos en la dirección de las corrientes


if ( x0 < 1e-4)
    x0=1e-4;
end

N=151;
inc_z=l2/(N-1);
z=[-(N-1)/2:(N-1)/2]*inc_z;
I=sin(2*pi*(l2/2-abs(z)))/sin(2*pi*l2/2);

R1=sqrt((z+z0-l1/2).^2+x0^2);
r=sqrt((z+z0).^2+x0^2);
R2=sqrt((z+z0+l1/2).^2+x0^2);

Z12=i*30*sum((exp(-i*2*pi*R1)./R1+exp(-i*2*pi*R2)./R2-2*cos(2*pi*l1/2)*exp(-i*2*pi*r)./r).*I)*inc_z/sin(2*pi*l1/2);

