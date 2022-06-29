random_data=randi(1000,50,5); % Generating random data
variables=random_data(:,1:4);   % In this set 4 colunms are the ingredients of a material. 
output_value=random_data(:,5); % The fifth colum represents the result of mechanical test
modelfun = @(b,x)   b(1)*x(:,1)+ b(2)*x(:,2)+  b(3)*x(:,3)+  b(4)*x(:,4) ;
beta = [-5 -5 -5 -5];
mdl = fitnlm(variables,output_value,modelfun,beta);
