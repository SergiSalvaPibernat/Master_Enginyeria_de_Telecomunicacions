function zin=zin_dipolo(l,a)
%
% zin=zin_dipolo(l,a)
%  Funcion que calcula la impedancia de entrada de un dipolo cilíndrico
%     con distribución senosoidal de corriente
% l : longitud total del dipolo (en términos de lambda (longitud de onda))
% a : radio del dipolo (en términos de lambda)
% l y a pueden ser vectores


zin=zeros(size(l));

for n=1:length(l)
    zin(n)=z12_dip(l(n),l(n),a(n),0);
end