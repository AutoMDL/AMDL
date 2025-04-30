function HyperParametersRead
load Model_ensemble.mat
load Model_GP.mat
load Model_NN.mat
load Model_SVM.mat
load Model_tree.mat
Line=find(Mdl_SVM.HyperparameterOptimizationResults.Rank==1);
HyperPara_SVM=Mdl_SVM.HyperparameterOptimizationResults(Line,1:end-2);
Line=find(Mdl_GP.HyperparameterOptimizationResults.Rank==1);
HyperPara_GP=Mdl_GP.HyperparameterOptimizationResults(Line,1:end-2);
Line=find(Mdl_ensemble.HyperparameterOptimizationResults.Rank==1);
HyperPara_RTE=Mdl_ensemble.HyperparameterOptimizationResults(Line,1:end-2);
Line=find(Mdl_tree.HyperparameterOptimizationResults.Rank==1);
HyperPara_DTR=Mdl_tree.HyperparameterOptimizationResults(Line,1:end-2);
Line=find(Mdl_NN.HyperparameterOptimizationResults.Rank==1);
HyperPara_NN=Mdl_NN.HyperparameterOptimizationResults(Line,1:end-2);
disp('SVM超参数如下')
disp(HyperPara_SVM);
disp('GPR超参数如下')
disp(HyperPara_GP);
disp('DTR超参数如下')
disp(HyperPara_DTR);
disp('RTE超参数如下');
disp(HyperPara_RTE);
disp('NN超参数如下');
disp(HyperPara_NN);
end