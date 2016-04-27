function Iele=FindElementsToDeactivate(CtrlVar,MUA_Background,hBackground)

% First check if there are nodes where the thickness is zero, but where the surface mass balance is positive
% this could for example happen if the ELA is going down, then I must allow new glaciers to form that are
% othewise isolated from the other ice masses
%
%
% I need to know the surface mass balance at ice free reagions where s=b=B
[~,~,S,B]=DefineGeometry(CtrlVar.Experiment,CtrlVar,MUA_Background,CtrlVar.time,'SB');
[as,ab]=GetMassBalance(CtrlVar.Experiment,CtrlVar,MUA_Background,CtrlVar.time,B,B,hBackground,S,B,[],[],[]);
I=find(as >= CtrlVar.MinSurfAccRequiredToReactivateNodes & hBackground<=CtrlVar.ThickMinDeactivateElements);
hBackground(I)=CtrlVar.ThickMinDeactivateElements+0.001; % the simplest way of ensuring that the elements with these nodes are not eliminated is to reset the thickness

if numel(find(I))>0
    fprintf('FindElementsToDeactivate: Found %-i nodes where ice thickness is less or equal to CtrlVar.ThickMinDeactivateElements, \n',numel(find(I)))
    fprintf('                          but where surface accumulation is larger than CtrlVar.MinSurfAccRequiredToReactivateNodes\n')
end


switch CtrlVar.SelectElementsToDeactivateAlgorithm
    
    case 1
        %   An elements is deactivated if and only if:
        %   None of the nodes of the element belong to an element
        %   with nodal thicknesses greater than CtrlVar.ThickMinDeactivateElements
        %
        %   hence: it is not enough for the nodes of the elements all to have thickness < CtrlVar.ThickMinDeactivateElements
        %          all nodes of all adjacent elements must also have thickness < CtrlVar.ThickMinDeactivateElements
        %
        Inod=true(MUA_Background.Nnodes,1); % as if all nodes fulfill the deactivation criterion
        Iele=sum(hBackground(MUA_Background.connectivity)>CtrlVar.ThickMinDeactivateElements,2)>=1;  % True for elements where at least one nodal thicknesses is greater that ThickMin
        PosThickNodes=MUA_Background.connectivity(Iele,:); PosThickNodes=sort(unique(PosThickNodes(:))); % list of all nodes belonging to elements in list I
        Inod(PosThickNodes)=0;  %
        Iele=sum(Inod(MUA_Background.connectivity),2)==MUA_Background.nod;  % Elements where all nodes should be eliminted
        
    case 2
        
        % If all nodes of an element have thickness less than CtrlVar.ThickMinDeactivateElements
        % the element is selected for elimination
        Iele=sum(hBackground(MUA_Background.connectivity)<=CtrlVar.ThickMinDeactivateElements,2)==MUA_Background.nod;
        
end


end
