function main
clc;
LoadOriginalDataTable;
disp("Original data loaded and saved!");
TestSetDivide;
disp("Traning set and testing set divided and saved!");
modletrain;
disp("Models training completed and saved!");
MdlEva;
disp("Models evaluation parameters calculated and saved!");
shapleyvalue;
disp("SHAP values calculated and saved!");
end