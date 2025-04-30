function shapleyvalue
Traininginput=[];
Testinput=[];
Trainingoutput=[];
Testoutput=[];
global modelstruct gp
load DatasetinMatrix.mat
load SymbolicRegressionResult.mat
location=[1:3 5 6 8:14 16:22 27];
Input=Traininginput(:,location);
f=@(Input) PreOutput(Input);
ShapSR=shapley(f,Input,'UseParallel',true);
for i=1:size(Traininginput,1)
q=Traininginput(i,:);
explainer=fit(ShapSR,q);
Sh=explainer.ShapleyValues.ShapleyValue';
SHAPValue(i,:)=Sh;
end

save SHAP_SymbolicRegression.mat SHAPValue
    function y=PreOutput(Input)
   PreFunction=gpmodel2func(gp,modelstruct);
    %y=PreFunction(x1,x2);%ModelsetI
    y=PreFunction(Input(:,1),Input(:,2),Input(:,3),...
        Input(:,4),Input(:,5),Input(:,6),Input(:,7),Input(:,8),...
        Input(:,9),Input(:,10),Input(:,11),Input(:,12),Input(:,13),...
        Input(:,14),Input(:,15),Input(:,16),Input(:,17),Input(:,18),Input(:,19),Input(:,20));%ModelsetII
   %y=PreFunction(x1,x3,x5,x8,x9,x10,x12,x13,x14,x17,x19,x20,x21,x23,x26,x27);  %Modelset III
    end
end