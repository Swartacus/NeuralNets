%housing_fcn.mat
%Author: Adam Swart
function y = housing_fcn(x)
%Accepts 13x1 inputs and returns the house value
    load housing_train.mat

    if size(x,1)~=r
        error('x incorrect size');
    end

    y=sim(housingnet,x);

end