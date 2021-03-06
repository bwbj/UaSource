function        [Cest,AGlenEst,JoptVector,ub,vb,ud,vd,lx,ly,gammaAdjoint]=ProjectedBFGS(...
    CtrlVar,MUA,JoptVector,...
    s,b,h,S,B,ub,vb,ud,vd,AGlen,n,C,m,rho,rhow,alpha,g,...
    sMeas,uMeas,vMeas,wMeas,bMeas,BMeas,...
    AGlen_prior,CAGlen,C_prior,CC,b_prior,Cd,...
    Luv,Luvrhs,lambdauv,LAdjoint,LAdjointrhs,lambdaAdjoint,...
    GF)


iA=strfind(CtrlVar.AdjointGrad,'A'); iC=strfind(CtrlVar.AdjointGrad,'C');
CtrlVar.isAgrad=~isempty(iA); CtrlVar.isCgrad=~isempty(iC);

[Cest,AGlenEst,JoptVector,ub,vb,ud,vd,lx,ly,gammaAdjoint]=GHGprojbfgsAdjoint(...
    CtrlVar,MUA,JoptVector,...
    s,b,h,S,B,ub,vb,ud,vd,AGlen,n,C,m,rho,rhow,alpha,g,...
    sMeas,uMeas,vMeas,wMeas,bMeas,BMeas,...
    AGlen_prior,CAGlen,C_prior,CC,b_prior,Cd,...
    Luv,Luvrhs,lambdauv,LAdjoint,LAdjointrhs,lambdaAdjoint,...
    GF);

%     [C,u,v,JoptVector] = GHGprojbfgsAdjoint(CtrlVar,...
%         s,S,B,h,u,v,uMeas,vMeas,wMeasInt,Cd,CC,CAGlen,C_prior,AGlen_prior,coordinates,connectivity,Boundary,nip,AGlen,C,...
%         Luv,Luvrhs,lambdauv,LAdjoint,LAdjointrhs,lambdaAdjoint,n,m,alpha,rho,rhow,g,GF,DTxy,TRIxy,JoptVector);
%
%



end


