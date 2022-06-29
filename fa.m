D=2;
lb=[-5 -5];
ub=[5 5];
N=20;
alpha=1.0;
beta0=1.0;
gamma=0.01;
theta=0.97;
iter_max=100;

objfcn = @objective;

for i=1:N
    for j=1:D
        pop(i,j)=lb(:,j)+rand.*(ub(:,j)-lb(:,j));
    end
end

fun=objfcn(pop);
alpha = alpha*theta;
scale=abs(ub-lb);

for iter=1:iter_max
    for i=1:N
        for j=1:N
            fun(i)=objfcn(pop(i,:));
            if fun(i)<fun(j)
                pop(i,:)=pop(i,:);
            elseif fun(i)>fun(j)
                Xi = pop(i,:);
                Xj = pop(j,:);
                r=sqrt(sum(Xj-Xi).^2);
                beta=beta0*exp(-gamma*r.^2);
                steps=alpha.*(rand(1,D)-0.5).*scale;
                Xnew=Xi+beta*(Xj-Xi)+steps;
            end
        end
    end
for k=1:size(Xnew,2)
    if Xnew(k)>ub(k)
        Xnew(k)=ub(k);
    elseif Xnew(k)<lb(k)
        Xnew(k)=lb(k);
    end
end
fnew=objfcn(Xnew);
if fnew<fun(i)
    fun(i)=fnew;
    pop(i,:)=Xnew;
end

[Optval,optind]=min(fun);
bestfun(iter)=Optval;
bestf(iter,:)=pop(optind,:);
disp(['Iteration and Best cost is : (', num2str(iter), ',', num2str(bestfun(iter)), ')']);

 plot(bestfun,'linewidth',2);
 xlabel('Iteration Number');
 ylabel("Fitness Value");
 grid on
end


 

