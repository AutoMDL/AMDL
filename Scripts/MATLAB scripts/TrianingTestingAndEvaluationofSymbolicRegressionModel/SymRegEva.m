Traininginput=[];
Testinput=[];
Trainingoutput=[];
Testoutput=[];
load DatasetinMatrix.mat
load SymbolicRegressionResult.mat
Pre_Train=PreOutput(Traininginput,modelstruct,gp);
Pre_Test=PreOutput(Testinput,modelstruct,gp);
[COR_Train,MAE_Train,RMSE_Train,COR_Test,MAE_Test,RMSE_Test]=MdlEvaluation(Pre_Train,Trainingoutput,Pre_Test,Testoutput);
save SymRegMdlEva.mat Pre_Test Pre_Train Trainingoutput Testoutput COR_Train MAE_Train RMSE_Train COR_Test MAE_Test RMSE_Test
    function y=PreOutput(Input,SymFunction,gp)
    x1=Input(:,1);
    x2=Input(:,2);
    x3=Input(:,3);
    x4=Input(:,4);
    x5=Input(:,5);
    x6=Input(:,6);
    x7=Input(:,7);
    x8=Input(:,8);
    x9=Input(:,9);
    x10=Input(:,10);
    x11=Input(:,11);
    x12=Input(:,12);
    x13=Input(:,13);
    x14=Input(:,14);
    x15=Input(:,15);
    x16=Input(:,16);
    x17=Input(:,17);
    x18=Input(:,18);
    x19=Input(:,19);
    x20=Input(:,20);
    x21=Input(:,21);
    x22=Input(:,22);
    x23=Input(:,23);
   x24=Input(:,24);
    x25=Input(:,25);
    x26=Input(:,26);
    x27=Input(:,27);
    
    PreFunction=gpmodel2func(gp,SymFunction);
    %y=PreFunction(x1,x2);
    %ModelsetII y=PreFunction(x1,x2,x3,x5,x6,x8,x9,x10,x11,x12,x13,x14,x16,x17,x18,x19,x20,x21,x22,x27);
    y=PreFunction(x1,x3,x5,x8,x9,x10,x12,x13,x14,x17,x19,x20,x21,x23,x26,x27);
    end