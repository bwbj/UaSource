function [UserVar,F,GF]=GetGeometryAndDensities(UserVar,CtrlVar,MUA,F,FieldsToBeDefined)

%
% Wrapper around DefineGeometry.m
%
% Calls DefineGeometry and does some error checks on the returned values.
%
% Only updates on s, b, B and S fields if these variables
% are contained in the string FieldsToBeDefined.
%
% Otherwise returns input fields.
%
%


nOut=nargout;
if nOut~=3
    error('Ua:GetGeometry','Need 3 output arguments')
end


if nargin<5 || isempty(FieldsToBeDefined)
    FieldsToBeDefined='sbSB';
end

if ~(FieldsToBeDefined=="")
    
    [UserVar,sTemp,bTemp,STemp,BTemp,F.alpha]=DefineGeometry(UserVar,CtrlVar,MUA,CtrlVar.time,FieldsToBeDefined);
    
    % some error checks
    errorStruct.identifier = 'GetGeometry:NaNinInput';
    
    if contains(FieldsToBeDefined,'s')
        if any(isnan(sTemp))
            errorStruct.message = 'nan in s';
            error(errorStruct)
        end
        F.s=sTemp;
    end
    
    if contains(FieldsToBeDefined,'b')
        if any(isnan(bTemp))
            errorStruct.message = 'nan in b';
            error(errorStruct)
        end
        F.b=bTemp;
    end
    
    if contains(FieldsToBeDefined,'S')
        if any(isnan(STemp))
            errorStruct.message = 'nan in S';
            error(errorStruct)
        end
        F.S=STemp;
    end
    
    if contains(FieldsToBeDefined,'B')
        if any(isnan(BTemp))
            errorStruct.message = 'nan in B';
            error(errorStruct)
        end
        F.B=BTemp;
    end
    
    if contains(FieldsToBeDefined,'s')|| contains(FieldsToBeDefined,'b')
        F.h=F.s-F.b;
    end
    
end



[UserVar,F]=GetDensities(UserVar,CtrlVar,MUA,F);
[F.b,F.s,F.h,GF]=Calc_bs_From_hBS(CtrlVar,MUA,F.h,F.S,F.B,F.rho,F.rhow);


end