function [result, ismaxqclq] = Quick(G,X,candX,gamma,minsize)

    ismaxqclq=false;
    result={};
    knear=4;
    Cu_final=[];
    %Find cover vertex set
    if ~isempty(X)
        for i=1:length(candX)
            u=candX(i);
            
            %Find not neighbors of u
            notNu=setdiff((1:numnodes(G)),neighbors(G,u));

            %Find not neighbors of u in X
            notNuX=intersect(X,notNu);

            %Intersection of neighbors of not neighbors of u in X
            NnotNuX=[];
            if ~isempty(notNuX)
                NnotNuX=neighbors(G,notNuX(1));
                for j=2:length(notNuX)
                    NnotNuX=intersect(NnotNuX,neighbors(G,notNuX(j)));
                end
            end
            %Find the largest cover vertex set
            Cu_temp=intersect(candX,intersect(neighbors(G,u),NnotNuX));
            if length(Cu_temp)>length(Cu_final)
                Cu_final=Cu_temp;
            end
        end
    end
   % sprintf(['X=', num2str(X),'  CX=', num2str(Cu_final), '\n'])

    %Put Cu_final elements at the end of candX
    candX_nocover=setdiff(candX,Cu_final);
   % disp([size(candX_nocover),size(Cu_final)])
    
    %Vertical concat to put cover vertex set at the end of candX
    candX=[candX_nocover;Cu_final];

    %Look for quasi-cliques for every vertex in candX_nocover
    for i=1:length(candX_nocover)
        new_result={};
        %Check for minsize criteria
        if length(X)+length(candX)<minsize
            ismaxqclq=false;
            return
        end
        v=candX_nocover(i);
        %Look ahead technique-check if union(X,candX) is a quasi clique
        X_union_candX=union(X,candX);
        if checkqclq(X_union_candX,G,gamma)
            new_result={X_union_candX};
%             disp(['v' num2str(v)])
%                 disp('result')
%                 for k=1:length(new_result)
%                     disp(new_result{k})
%                end
            result(length(result)+1)=new_result;
            ismaxqclq=true;
            return
        end

        %Y is potential X for the next recursive step.
        Y=union(X,v);
        candX=setdiff(candX,v);
        candY=intersect(candX,nearest(G,v,knear));

        %myupdate updates lower bound and upper bound for candY
        if ~isempty(candY)
            myupdate
        else
            LY=0;UY=0;
        end
        Z=1;
        
        %Printing the lower bound and upper bound to see how many nodes got pruned from the candidate extension
        sprintf(['LY= ',num2str(LY),' UY= ',num2str(UY),'\n'])
        
        %Perform some iterative graph theory checks to see if the current set can be extended any longer
        while LY<=UY && ~isempty(candY) && ~isempty(Z)
            
            for j=1:length(Y)
                indeg=indeg_Y(j);
                exdeg=exdeg_Y(j);

                if (indeg+exdeg)==gamma*(length(Y)+LY-1)
                    addnow=intersect(candY,neighbors(G,Y(j)));
                    Y=union(Y,addnow);
                    candY=setdiff(candY,addnow);
                    if ~isempty(candY)
                         myupdate
                    else
                        LY=0;UY=0;
                    end
                    break
                end
            end

          

            Z=Y((indeg_Y+exdeg_Y<gamma*(length(Y)+exdeg_Y-1))|(indeg_Y+UY<gamma*(length(Y)+UY-1))|(indeg_Y+exdeg_Y<gamma*(length(Y)+LY-1)));
            if ~isempty(Z)
                candY=[];
             % sprintf('empty Z')              
            else
                Z=candY((indeg_candY+exdeg_candY<gamma*(length(Y)+exdeg_candY))|(indeg_candY+UY-1<gamma*(length(Y)+UY-1))|(indeg_candY+exdeg_candY<gamma*(length(Y)+LY-1)));
                candY=setdiff(candY,Z);
                sprintf(['Z= ' num2str(Z')]) 
            end
            
            if ~isempty(candY)
                myupdate
            else
                LY=0;UY=0;
            end
        end

        %Only if the following conditions satisfy there is a chance of potential extension of Y, hence we perform recursion.
        if LY<=UY && ~isempty(candY) && (length(Y)+length(candY))>minsize
            [new_result, issuperqclq]=Quick(G,Y,candY,gamma,minsize);

% Following code is to check at runtime the outputs at different parts of the execution.
%             disp(['v' num2str(v)])
%                 disp('new_result')
%                 for k=1:length(new_result)
%                     disp(new_result{k})
%                 end
            ismaxqclq=ismaxqclq | issuperqclq;
            if length(Y)>minsize && checkqclq(Y,G,gamma) && ~issuperqclq
                ismaxqclq=true;
% Following code is to check at runtime the outputs at different parts of the execution.
%                new_result={Y};
%                 disp(['v' num2str(v)])
%                 disp('new_result')
%                 for k=1:length(new_result)
%                     disp(new_result{k})
%                 end
            end
            
        end
        
% Following code is to check at runtime the outputs at different parts of the execution.
%         disp(['v' num2str(v)])
%         disp('result')
%                 for k=1:length(result)
%                     disp(result{k})
%                 end 
        
        
% Return current result to previous call            
            if ~isempty(new_result)
                result(length(result)+1:length(result)+length(new_result))=new_result;
% Following code is to check at runtime the outputs at different parts of the execution.
%                 disp(['v' num2str(v)])
%                 disp('result')
%                 for k=1:length(new_result)
%                     disp(new_result{k})
%                 end
                    
            end
        
    end
end
            
        
        
        
        
            
            
        
          
        



    
    



