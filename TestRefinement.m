 % If we want to refine our mesh (increasing the bandwidth), how can we do
% this whilst retaining the existing points?

bandwidth=3;

[th,ph]=MakeFSTGrid(bandwidth);

clf
mesh(th,ph,ones(size(th)))
hold on

for idx=1:10
  disp(idx)
  [th2,ph2]=MakeFSTGrid(bandwidth*idx);
  h=plot3(th2(:),ph2(:),ones(size(th2(:))),'r.');
  pause
  delete(h)
end
