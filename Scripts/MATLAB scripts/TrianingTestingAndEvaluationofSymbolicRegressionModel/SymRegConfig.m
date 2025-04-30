function gp=SymRegConfig(gp)
gp.runcontrol.pop_size=100;
gp.runcontrol.runs=10;
gp.runcontrol.parallel.auto=true;
%selection
gp.selection.tournament.size=10;
gp.selection.tournament.p_pareto=0.8;
gp.selection.elite_fraction=0.4;

%genes
gp.genes.max_genes=30;

load Dataset.mat
for i=1:size(TrainingInput,2)
Traininginput(:,i)=TrainingInput{:,i};
Testinput(:,i)=TestInput{:,i};
end
Trainingoutput(:,1)=TrainingOutput{:,1};
Testoutput(:,1)=TestOutput{:,1};

gp.userdata.ytrain=Trainingoutput;
gp.userdata.xtrain=Traininginput;
gp.userdata.ytest=Testoutput;
gp.userdata.xtest=Testinput;
gp.nodes.functions.name = {'times', 'minus', 'plus','rdivide','square',...
    'sin','cos','exp','mult3','add3','sqrt','cube','power','negexp',...
    'neg','abs','log'};
