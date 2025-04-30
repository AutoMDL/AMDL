function DataTable2Matrix
load Dataset.mat
for i=1:size(TrainingInput,2)
Traininginput(:,i)=TrainingInput{:,i};
Testinput(:,i)=TestInput{:,i};
end
Trainingoutput(:,1)=TrainingOutput{:,1};
Testoutput(:,1)=TestOutput{:,1};
save DatasetinMatrix.mat Traininginput Testinput Trainingoutput Testoutput
end