%reading in all the data
data = dlmread('TrainingData.txt');
labels = dlmread('TrainingLabels.txt');
testdata = dlmread('TestingData.txt');
testlabels = dlmread('TestingLabels.txt');

%creating a generalized linear regression model 
coeffs = glmfit(data, labels, 'binomial', 'link', 'logit');

%variables needed
h = length(testdata);
result = double(40);
result2 = double(40);
prediction = double(40);
smoker = 0;
nonsmoker = 0;

%for loop to calculate the logistic function values
for i = 1:h
   x1 = i;
   x2 = 2;
   x3 = 3;
   x4 = 4;
   x5 = 5;
   %logistic function
   result(i,1)= (1/(1+exp(1)^-(coeffs(1)+coeffs(2)*testdata(x1,1)+coeffs(3)*testdata(x1,x2)+coeffs(4)*testdata(x1,x3)+coeffs(5)*testdata(x1,x4)+coeffs(6)*testdata(x1,x5))));
   result2(i,1)= 1-result(i);
   
   %write predictions according to logistic function results
   if result(i,1)> result2(i,1)
        prediction(i)= 1;
        smoker = smoker +1;
    else
        prediction(i,1) = 0;
        nonsmoker = nonsmoker +1;
    end
end

%gathering all the variables needed for formulas
tp =0;
tn = 0;
fp = 0;
fn = 0;
for i =1:h
    if testlabels(i,1) == 0 && prediction(i,1) == 0
        tn = tn+1;
    elseif testlabels(i,1) == 0 && prediction(i,1) == 1
        fp = fp+1;
    elseif testlabels(i,1) == 1 && prediction(i, 1) == 1
        tp = tp+1;
    elseif testlabels(i,1) == 1 && prediction(i,1) == 0
         fn = fn+1;
    end
end

%calculating all the formulas
recall = (tp/(tp+fn));
preciscion = (tp/(tp+fp));
accuracy = ((tp+tn)/(tp+tn+fp+fn));
f = 2*((preciscion*recall)/(preciscion+recall));
