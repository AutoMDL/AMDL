function Optimization
%本脚本基于模型集III中回归树集成（Regression Tree Ensemble）模型进行智能算法优化，得到能达到目标扩散系数的c轴长度
clc;
clear;
%显式定义变量，加载模型集与数据集
TrainingInput=[];
TestInput=[];
TrainingOutput=[];
TestOutput=[];
Mdl_ensemble=[];
load ("E:\A1 项目\9.Battery-GPT\过程产生文件\B_Machine learning\20240515训练结果\模型集III-两输入变量-c长度+循环圈数\Dataset.mat")
load ("E:\A1 项目\9.Battery-GPT\过程产生文件\B_Machine learning\20240515训练结果\模型集III-两输入变量-c长度+循环圈数\Model_ensemble.mat")
%定义并赋值目标函数中使用的全局变量（模型及优化目标值）
global Model Target_logD
Model=Mdl_ensemble;
Target_logD=-11;
rng default %确保可重复性
%确定优化上下限,bound开头的数组中，第一个元素为下限，第二个元素为上限%
bound_Cycles=[0,0];
bound_cLength=[min(min(TrainingInput(:,2)),min(TestInput(:,2))),max(max(TrainingInput(:,2)),max(TestInput(:,2)))];
lb=[bound_Cycles(1);bound_cLength(1)];
ub=[bound_Cycles(2);bound_cLength(2)];

%设定粒子群算法优化选项并进行优化
options_PSO=optimoptions('particleswarm','display','iter','HybridFcn',@fmincon,'SwarmSize',500,'UseParallel',true);
[x_PSO,fval_PSO,exitflag_PSO]=particleswarm(@TargetFunction,2,lb,ub,options_PSO);
PSOResult_OptimizedLogD=Target_logD/fval_PSO;%优化后的最优扩散系数
PSOResult_PredictLogD=predict(Mdl_ensemble,x_PSO);
Result_PSO=struct('InputVariables',x_PSO,'ExpectLogD',PSOResult_OptimizedLogD,'PredictLogDUsingInputAfterOptimization',PSOResult_PredictLogD,'ExitFlag',exitflag_PSO);
clc;

%设定遗传算法优化选项并进行优化%
options_GA=optimoptions('ga','display','iter','HybridFcn',@fmincon,'PopulationType','doubleVector','PopulationSize',500,'MigrationFraction',0.1,'MaxGenerations',5000,'MigrationDirection','both','UseParallel',true);
[x_GA,fval_GA,exitflag_GA]=ga(@TargetFunction,2,[],[],[],[],lb,ub,[],options_GA);
GAResult_OptimizedLogD=Target_logD/fval_GA;%优化后的最优扩散系数
GAResult_PredictLogD=predict(Mdl_ensemble,x_GA);
Result_GA=struct('InputVariables',x_GA,'ExpectLogD',GAResult_OptimizedLogD,'PredictLogDUsingInputAfterOptimization',GAResult_PredictLogD,'ExitFlag',exitflag_GA);
clc;
%{
%设定代理优化选项并进行优化%由于ceil(lb(2))=15>floor(ub(2))=14，代理优化不能使用
options_SO=optimoptions('surrogateopt','display','iter','UseParallel',true);
[x_SO,fval_SO,exitflag_SO]=surrogateopt(@TargetFunction,lb,ub,2,[],[],[],[],options_SO);
SOResult_OptimizedLogD=Target_logD/fval_SO;%优化后的最优扩散系数
SOResult_PredictLogD=predict(Mdl_ensemble,x_SO);
Result_SO=struct('InputVariables',x_SO,'ExpectLogD',SOResult_OptimizedLogD,'PredictLogDUsingInputAfterOptimization',SOResult_PredictLogD,'ExitFlag',exitflag_SO);
clc;
%}

%设定模拟退火算法优化选项并进行优化%
options_SAA=optimoptions('simulannealbnd','display','iter','HybridFcn',@fmincon);
x0=[0 14.2853];
[x_SAA,fval_SAA,exitflag_SAA]=simulannealbnd(@TargetFunction,x0,lb,ub,options_SAA);
SAAResult_OptimizedLogD=Target_logD/fval_SAA;%优化后的最优扩散系数
SAAResult_PredictLogD=predict(Mdl_ensemble,x_SAA);
Result_SAA=struct('InputVariables',x_SAA,'ExpectLogD',SAAResult_OptimizedLogD,'PredictLogDUsingInputAfterOptimization',SAAResult_PredictLogD,'ExitFlag',exitflag_SAA);
clc;

%保存优化结果
save OptimizationResult.mat Result_PSO Result_GA Result_SAA

%优化目标函数%
    function y=TargetFunction(Input)
    Pre_logD=predict(Model,Input);
    y=Pre_logD/Target_logD;
   end
end