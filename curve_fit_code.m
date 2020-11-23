RGB = imread('im.png');
I = rgb2gray(RGB);
I = imcomplement(I);
imshow(I)
BW = im2bw(I, 0.4);


imtool(BW);
[row, col] = find(BW==0);
st = sqrt((row(1)-row(2))^2 + (col(1)-col(2))^2 );
rowbc = zeros(size(row,1),1);
colbc = zeros(size(row,1),1);


for i = 2:(size(row,1)-2)
    lun1 = sqrt((row(i)-row(i+1))^2 + (col(i+1)-col(i))^2 );
    lun2 = lun1 = sqrt((row(i)-row(i+2))^2 + (col(i+2)-col(i))^2 );
    if (lun1 < 1*st)
        rowbc(i) = 1;
        colbc(i) = 1;
        i = i+1;
    end
end
row = row(~rowbc);
col = col(~colbc);



row = -1*row;
y = row;
x = col;

i = 1;
errorfinal = 100;

while ((errorfinal > 30) && (i <= 5))
    
    
    [p,S,mu] = polyfit(x,y,i);
    [v,delta] = polyval(p, x, S, mu);

    i = i+1;
    

    err = delta.^2;
    err_mean = mean(err);
    errorfinal = sqrt(err_mean);
end

p = polyfit(x,y,i-1);
v = polyval(p, x);

plot(x,y,'o',x,v);

fprintf("The Degree of the Equation Fitted is %d\n", i-1)
fprintf("The Confidence of the fit is is %0.3f%\n", errorfinal)

grid on


fprintf(['Equation of the curve is:\ny = ' repmat('%0.8fx + ',1,numel(p))] , p )



