
function WriteForwardRunRestartFile(UserVar,CtrlVar,MUA,BCs,F,GF,l,RunInfo)
RestartFile=CtrlVar.NameOfRestartFiletoWrite;
fprintf(CtrlVar.fidlog,' \n ################## %s %s ################### \n Writing restart file %s  at t=%-g \n %s \n ',CtrlVar.Experiment,datestr(now),RestartFile,CtrlVar.time);

CtrlVarInRestartFile=CtrlVar;
UserVarInRestartFile=UserVar;
nStep=CtrlVar.CurrentRunStepNumber;  % later get rid of nStep from all restart files
Itime=CtrlVar.CurrentRunStepNumber;  % later get rid of Itime from all restart files
time=CtrlVar.time;
dt=CtrlVar.dt;

try
    save(RestartFile,'CtrlVarInRestartFile','UserVarInRestartFile','MUA','BCs','time','dt','F','GF','l','RunInfo','-v7.3');
    
    fprintf(CtrlVar.fidlog,' Writing restart file was successful. \n');
    
catch exception
    fprintf(CtrlVar.fidlog,' Could not save restart file %s \n ',RestartFile);
    fprintf(CtrlVar.fidlog,'%s \n',exception.message);
end


end
