% [FSTRep] = SphHRep2FSTRep(SphHRep)
%
% Convert a list of spherical harmonic coefficients between my SphHRep
% format and the S2Kit library format.

function [FSTRep] = SphHRep2FSTRep(SphHRep)
  
FSTRep=zeros(size(SphHRep));

maxj=idx2jm(numel(FSTRep));

idx=1;
for m=[0:maxj -maxj:-1]
  for j=abs(m):maxj
    FSTRep(idx)=SphHRep(jm2idx(j,m));
    idx=idx+1;
  end
end
