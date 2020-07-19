


% *************************** %
% **    Assignment 2       ** %
% **    AS2016467          ** %
% **    W.B.M.Perera       ** %
% *************************** %






function [f,X] = DE
% f - optimal fitness
% X - optimal solution
% CONTROL PARAMETERS %

clc;
clear;

D = 2; % dimension of problem
NP = 10; % size of population
F = 0.9; % differentiation constant
CR = 0.5; % crossover constant
GEN = 100; % number of generations
L = -10; % low boundary constraint
H = 10; % high boundary constraint



% *************************** %
% ** ALGORITHM’S VARIABLES ** %
% *************************** %

error=zeros(100,1);
time=zeros(20,1);
Error=zeros(20,1);
best=zeros(100,1);
Best=zeros(20,1);
r = zeros(3,1); % randomly selected indices
iBest=1;


% initialize random number generator
function[Pop]=initialization()
   rand('state',sum(100*clock));
    for j = 1:NP % initialize each individual
    Pop(:,j) = L + (H-L)*rand(D,1); % within b.constraints
   
    end
end

% objective function----booth function

function f = fnc(k)
% fitness function

x1 = k(1);
x2 = k(2);

term1 = (x1 + 2*x2 - 7)^2;
term2 = (2*x1 + x2 - 5)^2;
f = term1 + term2;
end


%fitness of the population values
function[Fit]=fitness(Pop)
    for j = 1:NP
    Fit(j) = fnc(Pop(:,j)); % and evaluate fitness
    end
end 

% for 20 runs
for runs=1:20
    tic
    Pop=initialization();                                                    %step 1---> Initialize the population
    Fit=fitness(Pop);                                                        % step 2----> Determinr the fitnes value

    for g = 1:GEN % for each generation
      for j = 1:NP % for each individual
        [Donor_Vector]=doMutation(Pop);                                      %step 3-----> mutation
        [trial_Vector]=docrossOver(Donor_Vector);                            %step 4--->cross over
        doSelection(trial_Vector);                                           %step 5---->selection

      end % end of popoulation
      
      f = Fit(iBest); %best fitness value
      X = Pop(:,iBest); % indices of best fitness value
      error(g)=abs(f); %error since global optimum=0 error=abs(f)
      best(g)=f;
      
     

    end %end of generations
    time(runs)=toc
     
    %figure 1-----> error against the number of generation for a particular run
     x=1:GEN
     y=error
     figure(1)
     plot(x,y,'-o')
     xlabel('runs')
     ylabel('error')
     title('error against the number of generations for a paticular run')
     grid on
    
     %figure 4-----> function value against number of generations for a  particular run
     x=1:GEN
     y=best
     figure(4)
     plot(x,y,'-o')
     xlabel('runs')
     ylabel('f(x)')
     title('function value against the number of generations for a paticular run')
     grid on
     
  
      f = Fit(iBest); % best fitness value of the last generation in a particular run
      X = Pop(:,iBest); % indices of it
      Error(runs)=abs(f); % error of it
      Best(runs)=f; % best fitnesss value
     
  
end % end of runs
   %figure 3---->run time against runs
     x=1:20
     y=time
     figure(3)
     plot(x,y,'-o')
     xlabel('runs')
     ylabel('runtime')
     title('run time against runs')
     grid on
     
 %figure 2---->error against runs
 y=Error
 figure(2)
 plot(x,y,'-o')
 xlabel('runs')
 ylabel('error')
 title('error against runs')
 grid on

 %figure 5---->function value against runs
 x=1:20
y=Best
figure(5)
 plot(x,y,'-o')
 xlabel('runs')
 ylabel('f(x)')
 title('function value against runs')
 grid on

function [Donor_Vector]=doMutation(Pop) % function for mutation
    
r(1) = floor(rand()* NP) + 1;
while r(1)==j
r(1) = floor(rand()* NP) + 1;
end
r(2) = floor(rand()* NP) + 1;
while (r(2)==r(1))||(r(2)==j)
r(2) = floor(rand()* NP) + 1;
end
r(3) = floor(rand()* NP) + 1;
while (r(3)==r(2))||(r(3)==r(1))||(r(3)==j)
r(3) = floor(rand()* NP) + 1;
end

for i=1:D
Donor_Vector(i)= Pop(i,r(3)) + F * (Pop(i,r(1)) - Pop(i,r(2)));
end


end



function[trial_Vector]=docrossOver(Donor_Vector) % function for crossover
        
  Rnd = floor(rand()*D) + 1;
  for i = 1:D
  if ( rand()<CR ) || ( Rnd==i )
     trial_Vector= Donor_Vector;
  else
  trial_Vector= Pop(:,j);
  end
  end
end  




    

function doSelection(trial_Vector) %function for selection
    f = fnc(trial_Vector);
    % if trial is better or equal than current
    if f <= Fit(j)
    Pop(:,j) = trial_Vector; % replace current by trial
    Fit(j) = f ;
    % if trial is better than the best
    if f <= Fit(iBest)
    iBest = j;  
    
    end
    end  
    
    
end



end