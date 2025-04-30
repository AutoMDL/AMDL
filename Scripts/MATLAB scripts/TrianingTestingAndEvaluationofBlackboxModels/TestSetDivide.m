function TestSetDivide
load OriginalData.mat
DataAmount=size(DataTable,1);
testnum1=0.2*size(DataTable,1);
testnum=ceil(testnum1);
TestDatalocation1=unidrnd(DataAmount,testnum,1);
TestDataLocation1=unique(TestDatalocation1);
TestDatalocation2=unidrnd(DataAmount,testnum,1);
TestDataLocation2=unique(TestDatalocation2);
TestDatalocation3=[TestDataLocation1;TestDataLocation2];
TestDataLocation3=unique(TestDatalocation3);
TestDataLocation=TestDataLocation3(1:testnum);

TestInput=DataTable(TestDataLocation,1:end-1);
TrainingInput=DataTable(:,1:end-1);
TrainingInput(TestDataLocation,:)=[];

TestOutput=DataTable(TestDataLocation,end);
TrainingOutput=DataTable(:,end);
TrainingOutput(TestDataLocation,:)=[];

save Dataset.mat TestInput TrainingInput TestOutput TrainingOutput
save TestLocationInformation.mat testnum TestDatalocation1 TestDataLocation1 TestDatalocation2 TestDataLocation2 TestDatalocation3 TestDataLocation3 TestDataLocation

end