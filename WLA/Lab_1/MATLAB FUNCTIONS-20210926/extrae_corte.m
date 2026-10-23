%  [ang,E]=extrae_corte(t,corte)
%  function to obtain the cut of a radiation pattern from a data matrix.
%  t : matrix with dimension  Nth x Nph , where Nth are the number of points in theta, Nph the number of points in phi
% where the rows are the samples in theta frop 0 to pi and rhe columns are the samples in phi from 0 to (2*pi-inc_phi)
%   
%  corte :it can be  'XY'  'ZX'  o  'ZY' indicating the plane of the cut
%  ang: angle in degrees
%  E: Result of the cut
%

function [ang,E]=extrae_corte(t,corte)

[Nth,Nph]=size(t);

if strcmp(corte,'XY')
    E=t((Nth+1)/2,:);
    ang=[0:Nph-1]*360/Nph;
elseif strcmp(corte,'ZX')
    E=flipud([t(:,(Nph/2+1)) ; t(2:Nth,1)]);
    ang=linspace(-180,180,2*Nth-1)';
elseif strcmp(corte,'ZY')
    E=flipud([t(:,(Nph/2+Nph/4+1)) ; t(2:Nth,Nph/4+1)]);
    ang=linspace(-180,180,2*Nth-1)';
end    