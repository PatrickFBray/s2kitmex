% [Ylm] = Ylm(l,m,theta,phi)
%
% Spherical Surface Harmonic 
%
% 0<=theta<=pi is the polar angle, measured from the z-axis.
% 0<=phi<2*pi is the azimuthal angle from the x-axis
%
% These spherical coordinate conventions are the same as those used by
% the Mathematica SphericalHarmonicY[l,m,theta,phi] command.

% $Id: Ylm.m 4047 2011-04-01 17:32:56Z crodgers $

% Copyright: Chris Rodgers, Aug, 2005.
%
% This file is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This file is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this file; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% See the accompanying LICENSE file for details.

function Ylm=Ylm(l,m,theta,phi)

if l<0 || abs(m)>l || fix(m)~=m || fix(l)~=l || isempty(theta) || isempty(phi)
  Ylm=zeros(size(theta));
  return;
end

if min(theta(:))<0 || max(theta(:))>pi || ...
  min(phi(:))<0 || max(phi(:))>2*pi
  error('Spherical co-ordinates out of range!')
end

% Calculate the harmonic
tmp = legendre(l,cos(reshape(theta,1,[])));

absm=abs(m);
if m>=0
  Ylm = reshape(tmp(m+1,:),size(theta)).*exp(i*m*phi);
else
  Ylm = ((-1)^absm * factorial(l-absm)/factorial(l+absm)) * reshape(tmp(absm+1,:),size(theta)).*exp(i*m*phi);
end

Ylm = sqrt((2*l+1)*factorial(l-m)/(4*pi*factorial(l+m)))*Ylm;
