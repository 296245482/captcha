function [ netV,netW,netR,netA] = BPNNTrain(traindata,trainlabel,eta,maxIte,targetE)
%BPNN bpnn training
%   netV -- The weight from input layer to hidden layer after training
%   netW -- The weight from hidden layer to output layer after training
%   netR -- The bias of hidden layer after training
%   netA -- The bias of output layer after training
%   traindata -- training data
%   trainlabel -- the label of training data
%   eta -- The learning rate
%   maxIte -- The maximum number of iterations
%   targetE -- Stop iterating when error less than minE 

    [m,n] = size(traindata);
    y = zeros(m,33);
    for i =1 :m
        label =trainlabel(i);
        if label<='9'
            y(i,label-'1') = 1;
        elseif label<'I'
            y(i,label-'1'-7) = 1;
        else
            y(i,label-'1'-8) = 1;
        end
    end
    
    %Number of neurons
    inputLayer=n;
    hiddenLayer=2*inputLayer+1;
    outputLayer=33;

    %initialization
    v=rand(inputLayer,hiddenLayer);
    w=rand(hiddenLayer,outputLayer);
    r=rand(1,hiddenLayer)+30;
    a=rand(1,outputLayer);
    [ netV,netW,netR,netA]=BPNeuralNet(traindata,y,v,w,r,a,eta,maxIte,targetE);
end

