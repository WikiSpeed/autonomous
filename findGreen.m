% remeber to set up webcam 

% cam = webcam
yellow = uint8([255 255 0]); % [R G B]; class of yellow must match class of I
ss
shapeInserter = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',yellow);

circles = int32([]); %  [x1 y1 radius1;x2 y2 radius2]




img = snapshot(cam);
r = img(:, :, 1);
g = img(:, :, 2);
b = img(:, :, 3);
Green = g - r/2 - b/2;
justGreen=Green>40;
greenPlus=zeros(size(justGreen));
for x = 1:size(justGreen,1)
    sum=0;
    for y = 1:size(justGreen,2)
       sum=justGreen(x,y)+sum;
       if isequal(sum,30)
           greenPlus(x,y)=1;
           break;
       end
    end
end 

sum=1;
for x = 1:size(greenPlus,1)
    for y = 1:size(greenPlus,2)
    if(isequal(greenPlus(x,y),1))
    sum=sum+1;
    circles(sum,:)=[y,x,70];
    end
    end
end

% replace bad circles with [0,0,0]
delete=[];
for i = 1:size(circles,1)
    if isequal(circles(i,:),[0,0,0])
        continue
    end 
    for j = 1:size(circles,1)
        distance=norm(double(circles(j,1:2))-double(circles(i,1:2)));
        if (distance<140)&&(distance>0)
        delete=[delete,j];
        end
        
    end
   
    for x = 1:size(delete,2)
        circles(delete(x),:)=[0,0,0];
    end 
    delete=[];
end 

J = step(shapeInserter, img, circles);

imshow(J)

