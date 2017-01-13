function [UserVar,s,b,S,B,alpha]=GetGeometry(UserVar,CtrlVar,MUA,time,FieldsToBeDefined)


nOut=nargout;
if nOut~=6
    error('Ua:GetGeometry','Need 6 output arguments')
end

N=nargout('DefineGeometry');


switch N
    
    case 5
        [s,b,S,B,alpha]=DefineGeometry(CtrlVar.Experiment,CtrlVar,MUA,time,FieldsToBeDefined);
    case 6
        [UserVar,s,b,S,B,alpha]=DefineGeometry(UserVar,CtrlVar,MUA,time,FieldsToBeDefined);
    otherwise
        error('Ua:GetGeometry','Define Geometry must return either 5 or 6 output arguments')
end


% some error checks
errorStruct.identifier = 'GetGeometry:NaNinInput';

if contains(FieldsToBeDefined,'s')
    if any(isnan(s))
        errorStruct.message = 'nan in s';
        error(errorStruct)
    end
end

if contains(FieldsToBeDefined,'b')
    if any(isnan(b))
        errorStruct.message = 'nan in b';
        error(errorStruct)
    end
end

if contains(FieldsToBeDefined,'S')
    if any(isnan(S))
        errorStruct.message = 'nan in S';
        error(errorStruct)
    end
end

if contains(FieldsToBeDefined,'B')
    if any(isnan(B))
        errorStruct.message = 'nan in B';
        error(errorStruct)
    end
end




end