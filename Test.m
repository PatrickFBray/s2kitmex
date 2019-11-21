 % Short script to test FST_semi_fly_mex against a direct computation of the
% spherical harmonics.

% $Id: Test.m 5 2008-07-24 21:10:13Z crodgers $

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
% along with S2kit; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% See the accompanying LICENSE file for details.

disp('Testing the spherical Fourier transform code')
disp('Try all individual spherical harmonics from j=0 .. 2*bandwidth')
disp('Watch for aliasing once j>bandwidth')
disp('Press any key to start')
pause

bandwidth=5

[th,ph]=MakeFSTGrid(bandwidth);

for j=0:(bandwidth*2)
  for m=-j:j
    fprintf('\n\n\n****************\nTesting with j=%g, m=%g:\n',j,m)
    SphHRep=FSTRep2SphHRep(FST_semi_fly_mex(Ylm(j,m,th,ph)));
    [nonzeroelements]=find(abs(SphHRep)>1e-14);
    if numel(nonzeroelements)>0
      for idx=1:numel(nonzeroelements)
        [foundj,foundm]=idx2jm(nonzeroelements(idx));
        fprintf('Found: j=%g, m=%g. amplitude=%g\n',foundj,foundm, ...
                SphHRep(nonzeroelements(idx)))
      end
    else
      fprintf('All coefficients are negligible!\n')
    end
    fprintf('----------------------\n');
    pause
  end
end
