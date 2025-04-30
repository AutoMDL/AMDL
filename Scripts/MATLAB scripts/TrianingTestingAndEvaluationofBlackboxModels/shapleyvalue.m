function shapleyvalue
load Model_SVM.mat
load Model_NN.mat
load Model_tree.mat
load Model_ensemble.mat
load Model_GP.mat
load Dataset.mat
S_SVM=shapley(Mdl_SVM,TrainingInput);
for i=1:size(TrainingInput,1)
q_SVM=TrainingInput(i,:);
explainer_SVM=fit(S_SVM,q_SVM);
Sh_SVM=explainer_SVM.ShapleyValues.ShapleyValue';
SHAPValue_SVM(i,:)=Sh_SVM;
end

S_ensemble=shapley(Mdl_ensemble,TrainingInput);
for i=1:size(TrainingInput,1)
q_ensemble=TrainingInput(i,:);
explainer_ensemble=fit(S_ensemble,q_ensemble);
Sh_ensemble=explainer_ensemble.ShapleyValues.ShapleyValue';
SHAPValue_ensemble(i,:)=Sh_ensemble;
end

S_GP=shapley(Mdl_GP,TrainingInput);
for i=1:size(TrainingInput,1)
q_GP=TrainingInput(i,:);
explainer_GP=fit(S_GP,q_GP);
Sh_GP=explainer_GP.ShapleyValues.ShapleyValue';
SHAPValue_GP(i,:)=Sh_GP;
end

S_NN=shapley(Mdl_NN,TrainingInput);
for i=1:size(TrainingInput,1)
q_NN=TrainingInput(i,:);
explainer_NN=fit(S_NN,q_NN);
Sh_NN=explainer_NN.ShapleyValues.ShapleyValue';
SHAPValue_NN(i,:)=Sh_NN;
end

S_tree=shapley(Mdl_tree,TrainingInput);
for i=1:size(TrainingInput,1)
q_tree=TrainingInput(i,:);
explainer_tree=fit(S_tree,q_tree);
Sh_tree=explainer_tree.ShapleyValues.ShapleyValue';
SHAPValue_tree(i,:)=Sh_tree;
end
save SHAP.mat SHAPValue_SVM SHAPValue_tree SHAPValue_NN SHAPValue_GP SHAPValue_ensemble
end