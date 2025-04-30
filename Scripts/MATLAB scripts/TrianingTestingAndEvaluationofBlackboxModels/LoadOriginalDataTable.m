function LoadOriginalDataTable
filename='path/to/Excel/file';
DataTable=readtable(filename);
save OriginalData.mat DataTable
end