function [COR_Train,MAE_Train,RMSE_Train,COR_Test,MAE_Test,RMSE_Test]=MdlEvaluation(Pre_Train,TrainingOutput,Pre_Test,TestOutput)
clc;
[r,p]=corrcoef(Pre_Train,TrainingOutput);
COR_Train=r(1,2);
MAE_Train=mean(abs(TrainingOutput-Pre_Train));
RMSE_Train=sqrt(mean((TrainingOutput-Pre_Train).^2));
[r,p]=corrcoef(Pre_Test,TestOutput);
COR_Test=r(1,2);
MAE_Test=mean(abs(TestOutput-Pre_Test));
RMSE_Test=sqrt(mean((TestOutput-Pre_Test).^2));
end