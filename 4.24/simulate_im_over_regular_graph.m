function result = simulate_im_over_regular_graph(U, graph, alpha, iterate_time, N,k)
    function fit_result = fitness_calculate(index,k)
        fitness = (1-alpha);     %fit=(1-alpha)+alpha*U
        for q=1:k
            fitness=fitness+alpha*U(strategy_state(index),strategy_state(graph(index,q)));%fitness=1+alpha*U(i,j)
        end
        fit_result = fitness;
    end
    result=zeros(1,iterate_time);
    strategy_state = zeros(1,N);  %���������ΪN��0����1*N)
    z=[0.1,0.9];           %define the percentage of every strategy
    K=N*z;                        %K����Ϊ����Ҫ�ı�������
    starter_table=randperm(N);          %���ҵ�N����
    %S1=[];S2=[];S3=[];S4=[];   
    for i=1:N                           %define the strategy state 1,2,3,4
        if i<=K(1)
            strategy_state(starter_table(i))=1;
            %S1=[S1,starter_table(i)]
        else
            strategy_state(starter_table(i))=2;
        end
    end  
    %S=[S1;S2;S3;S4];    Si��ʾ��i�ֲ����˵ı�ż���
    x=zeros(1,iterate_time);
    time = 1;
    %Q=K';
    x(time)=K(1)/N;     %initial the start 
    %time = time + 1;
    for time=2:iterate_time      
        for p = 1:N          %ÿ�α���ȫ���㣬������IM����rule����
            i = randi([1,N]);    %%�����N������ѡһ��i
            friend_list=graph(i,:);               
            fit_self = fitness_calculate(i,k);    %����Լ���fitness
            fit=[0,0];
            b=strategy_state(i);
            if b==1
                for j=1:k
                    if friend_list(j)==1
                        fit(1)=fit(1)+fitness_calculate(friend_list(j),k);
                    else
                        fit(2)=fit(2)+fitness_calculate(friend_list(j),k);
                    end
                end
                judge=fit(2)/(fit(1)+fit(2)+fit_self);
                rn=rand;
                if rn<=judge
                    strategy_state(i)=2;
                    K(1)=K(1)-1;K(2)=K(2)+1;
                end
            else
                for j=1:k
                    if friend_list(j)==1
                        fit(1)=fit(1)+fitness_calculate(friend_list(j),k);
                    else
                        fit(2)=fit(2)+fitness_calculate(friend_list(j),k);
                    end
                end
                judge=fit(1)/(fit(1)+fit(2)+fit_self);
                rn=rand;
                if rn<=judge
                    strategy_state(i)=1;
                    K(1)=K(1)+1;K(2)=K(2)-1;
                end
            end
                
%               
%                         
%            %fit(strategy_state(friend_list(j)))=fit(strategy_state(friend_list(j)))+fitness_calculate(friend_list(j),k);
%             %fit(strategy_state(i))=fit(strategy_state(i))+fit_self;           
%             sigma=fit(1)+fit(2)+fit_self;
% %             judge1=fit(1)/sigma;
% %             judge2=fit(2)/sigma;
%             
%             if b==1   %foward
%                judge2=fit(2)/sigma;
%                rn=rand;
%                if rn<=judge2
%                    strategy_state(i)=2;
%                    K(1)=K(1)-1;
%                end
%             else         %not forward
%                 judge1=fit(1)/sigma;
%                 rn=rand;
%                 if rn<=judge1
%                     strategy_state(i)=1;
%                     K(1)=K(1)+1;
%                 end
%             end
            %judge2=fit(1)+fit(2)/sigma;
         %   judge3=1-fit(4)/sigma;
%             temp=strategy_state(i);
%             rn=rand;                    %%rnΪ[0,1]�������
%             if rn<=judge1                %%�������ޣ���fitness�����ĸ�����
%                 strategy_state(i)=1;
%             else
%                 strategy_state(i)=2;
%             end
%             if judge1<rn<=judge2
%                 strategy_state(i)=2;
%             end
%             if judge2<rn<=judge3
%                 strategy_state(i)=3;
%             end
%             if rn>judge3
%                 strategy_state(i)=4;
%             end

%             if temp==strategy_state(i)        %%�ж��Ƿ�ά��ԭ״
%                 %return;
%             else
%                 K(strategy_state(i))=K(strategy_state(i))+1;
%                 K(temp)=K(temp)-1;
%             end
        end
        %x(i,tim e)=K(i)/N
        %Q=K';
        x(time) = K(1)/N;
      %  time = time + 1;
    end
    result=x;
end  
    
    
    
