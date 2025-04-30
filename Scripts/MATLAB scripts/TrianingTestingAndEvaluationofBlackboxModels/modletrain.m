function modletrain
load Dataset.mat;%load dataset

%Train and save SVM model
Mdl_SVM=fitrsvm(TrainingInput,TrainingOutput,'OptimizeHyperparameters',"all",'HyperparameterOptimizationOptions',...
    struct('Optimizer','randomsearch','AcquisitionFunctionName','expected-improvement-plus','Kfold',10,'UseParallel',true));
save Model_SVM.mat Mdl_SVM
close all;

%Train and save GPR model
Mdl_GP=fitrgp(TrainingInput,TrainingOutput,'OptimizeHyperparameters',"all",'HyperparameterOptimizationOptions',struct('Optimizer','randomsearch','AcquisitionFunctionName','expected-improvement-plus','Kfold',10));
save Model_GP.mat Mdl_GP
close all;

%Train and save DTR model
Mdl_tree=fitrtree(TrainingInput,TrainingOutput,'OptimizeHyperparameters',"all",'HyperparameterOptimizationOptions',struct('Optimizer','randomsearch','AcquisitionFunctionName','expected-improvement-plus','Kfold',10));
save Model_tree.mat Mdl_tree
close all;

%Train and save RTE model
Mdl_ensemble=fitrensemble(TrainingInput,TrainingOutput,'OptimizeHyperparameters',"all",'HyperparameterOptimizationOptions',struct('Optimizer','randomsearch','AcquisitionFunctionName','expected-improvement-plus','Kfold',10));
save Model_ensemble.mat Mdl_ensemble
close all;

%Train and save NN model
Mdl_NN=fitrnet(TrainingInput,TrainingOutput,'OptimizeHyperparameters',"all",'HyperparameterOptimizationOptions',struct('Optimizer','randomsearch','AcquisitionFunctionName','expected-improvement-plus','Kfold',10));
save Model_NN.mat Mdl_NN
close all;

end

