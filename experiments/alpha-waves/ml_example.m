%% MACHINE LEARNING: SIMPLE LINEAR REGRESSION

%%
clearvars; close all;
load carsmall
isdata = isfinite(MPG)&isfinite(Weight)&isfinite(Horsepower);
y = MPG(isdata);
x = Weight(isdata);
m = length(y);

%% Plot
% clf
% plot(x,y,'x')
% xlabel('weight [lb]')
% ylabel('MPG')

% Normalize
x = x/max(x);
y = y/max(y);

figure;
plot(x,y,'x')
xlabel('weight [lb]')
ylabel('MPG')
hold on;

%% 
w = (-1.5)*rand();
b = rand();
y_hat = w*x + b;

%% Plot initial y_hat
plot(x,y_hat)
xlabel('weight [lb]')
ylabel('MPG')
hold on

%% Calc loss 
alpha = 1;
num_iter = 10;
J_store = zeros(1,num_iter);

for iter = 1:num_iter
    
    J = 1/(2*m)*sum((y_hat-y).^2); 
    
    J_store(iter) = J;
    
    grad_J = 1/m*sum(times(y_hat-y, x));
    
    % Update w and y_hat
    w = w - alpha*grad_J;
    
    y_hat = w*x + b;
    
    plot(x,y_hat);
    drawnow;
    pause(0.5);
    
end
hold off

figure; plot(J_store);