
clear all
RGB=imread('/Users/jacksonrudd/Downloads/road.jpg');
grey = rgb2gray(RGB); % Convert RGB to intensity
I=edge(grey);

I(1:size(I,2)/3,5:end-5)=0;
% RGB=imread('/Users/jacksonrudd/Downloads/road.jpg');

% Select the lower portion of input video (confine field of view)
% Imlow  = RGB(100+1:end, :,1 :end-1);
% Edge detection and Hough transform

[H, T, R] = hough(I);
P = houghpeaks(H,10,'threshold',ceil(0.01*max(H(:))));
numOfLines=size(P,1);

j=1:numOfLines;
theta=degtorad(T(P(j,2)));
rho=R(P(j,1));
figure, imshow(RGB), hold on






j=1:numOfLines;    
xAxis=((rho(j)./sin(theta(j))) - size(I,1))./cot(theta(j))-(size(I,2)/2);
minLeftDist=-10000;
minRightDist=10000;
minRightLine=1;
minLeftLine=1;

for i=1:numOfLines
if (xAxis(i)>0)&&(xAxis(i)<minRightDist)
    minRightDist=xAxis(i);
    minRightLine=i;
end 
if (xAxis(i)<0)&&(xAxis(i)>minLeftDist)
    minLeftDist=xAxis(i);
    minLeftLine=i;
end 
end 



i = minLeftLine;
x=0:600;
y=-(x*cot(theta(i))-(rho(i)./sin(theta(i))));

plot(x,y,'g--o')

i = minRightLine;
x=0:600;
y=-(x*cot(theta(i))-(rho(i)./sin(theta(i))));
plot(x,y,'b--o')

