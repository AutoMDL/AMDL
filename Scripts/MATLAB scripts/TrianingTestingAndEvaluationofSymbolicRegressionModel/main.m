function main
clc;
close all;
gp=rungp(@SymRegConfig);
popbrowser(gp,'train');
runtree(gp,'best');
gppretty(gp,'best');
modelstruct=gpmodel2struct(gp,'best');

save SymbolicRegressionResult.mat
end