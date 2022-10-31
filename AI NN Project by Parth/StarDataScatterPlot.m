%Parth Joshi 1126914 COMP 4475 AI Project

rows = height(dataset);
brown = [150 75 0]/256;
orange = [255 165 0]/256;
grey = [126 126 126]/256;
for x = 1:rows
    if dataset(x,:).StarType==0 
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, [], brown, "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    elseif dataset(x,:).StarType==1
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, "red", "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    elseif dataset(x,:).StarType==2 
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, [], grey, "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    elseif dataset(x,:).StarType==3 
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, "green", "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    elseif dataset(x,:).StarType==4 
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, [], orange, "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    elseif dataset(x,:).StarType==5 
        scatter(dataset(x,:).TemperatureK, dataset(x,:).AbsoluteMagnitudeMv, "yellow", "filled", "MarkerEdgeColor", "k", "LineWidth", 0.5);
    end
    hold on
end
hold off
set(gca, "YDir", "reverse");
set(gca, "Xdir", "reverse");
xlabel('Temperature(K)');
ylabel('Magnitude');
set(gca, "YGrid", 'on');
set(gca, "XGrid", 'on');