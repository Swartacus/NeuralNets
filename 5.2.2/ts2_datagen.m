%tst2_datagen.m
%Author: Adam Swart
function x = ts2_datagen(u, v, w)
%Function that generates a sequence
x(1)=u;x(2)=v;x(3)=w;
n=100;
for i=4:n
    x(i)=.76*x(i-1)+.25*x(i-2)-.67*x(i-3);
end

end