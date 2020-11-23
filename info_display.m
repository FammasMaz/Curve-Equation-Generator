% Visualizing the fit


foldername = '/Users/fammas.maz/Downloads/matlab_image/images/';
frame = 16; %This is the frame of the video which you want to find the info about

fprintf("\n\nFrame %d Info: \n\n", frame)
fprintf("The Degree of the Equation Fitted is %d\n", i-1)
fprintf("The Confidence of the fit in Frame %0.3f\n", errorfinal{frame})
       
u =length(p{frame});


fprintf(['Equation of the curve is:\ny = ' repmat('%0.16fx + ',1,numel(p{frame}))] , p{frame} ) %Displays the equation


plot(x{frame},y{frame},'o',x{frame},v{frame}); %Shows the data points and the curve fit in a matlab window
