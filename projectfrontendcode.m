%Goal: Determine phase of Estrous cycle based on hypothetical slides
%In the case of these slides blue represents leukocytes
% red represents cornified epithelial cells and
% green represents nucleated epithelial cells
% Based on predetemined thresholds (for convenience any one color being
% >33% will be the determine cycle)
% The code will read back what stage of the estrous cycle the image is in

clear;
clc;
Range=5 %Value for determining the average y distance on the slide being read



%An initial for loop to read through the images we wish to analyze.
%For the purpose of this project we are reading through 10 hypothetical
%estrous slides

%For this program to fun properly one must click 4 times. This is the set
%the bounds of what we are reading. To do this correctly click and the left
%most bound of the image (x1) and then the right most bound (x2). Hit enter. To set
%the y-bounds click in the exact same locations again. Hit enter again.
%Repeat this for each slide

for i=1:2 %for loop to iterate through our 10 hypothetical slides
    A=sprintf('ES_%04d.tif', i);
    image=imread(A);
    RED=image(:,:,1); %These RGB commands allow us to differentiate RGB on each slide
    GREEN=image(:,:,2);
    BLUE=image(:,:,3);
    figure
    imshow(image, [], 'InitialMagnification', 'fit');
    hold on;
    [x,y,P]=impixel(image); 
  
    [x_coord, y_coord, intensities]=impixel(image);
    
    My_index=1; %A counting tool so we properly iterate through our images
   for j=x_coord(1,1):x_coord(2,1); %An inital for loop to establish the x-bounds of our image. You will have to click on the left and right most bound of the image and hit enter
         fluorescence_sum=[0,0,0];
         my_average_y=mean(y_coord(1:2,1));
       for k=(my_average_y-Range):(my_average_y+Range); %A for loop to establish the y-bounds of our image. Click in the same locations as you clicked for the x-bounds and hit enter again
           [x, y, P]=impixel(image,j,k);
           fluorescence_sumB=BLUE; %This produces the relative fluorescent of R, G, or B on the slides
           B=sum(fluorescence_sumB, "all"); %saving all of our fluoresence of the entire slide to a variable
           fluorescence_sumR=RED;
           R=sum(fluorescence_sumR,"all");
           fluorescence_sumG=GREEN;
           G=sum(fluorescence_sumG,"all");
            
        end
         My_index=My_index+1;
    end 
    E_state=E_cycle(R,G,B) %Calling our function to determine what stage of the estrous cycle we are in based on RGB fluorescent levels
    x=categorical(["Red" "Green" "Blue"])
    y_plot(i,:)=[R,G,B]       
end

%following this code the stage of the estrous cycle will be printed in the
%command window



for i=1:2 %Code for plotting the relative fluorescence of each slide
    ylabel('Total Fluorescence on Slide')
    subplot(1,10,i) 
    bar(x,y_plot(i,:)) 
end







