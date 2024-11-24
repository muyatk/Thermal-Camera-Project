clf

sensor = "3078";
folder = "data/";
file = "2021_06_28_16_30_17-1.txt";
fileName = append(folder,file);

%% Configure heatmap
frame = jsondecode('[]');

h = heatmap(frame, 'FontSize', 6);
h.Title = "Thermal array color map";        
%h.ColorLimits = [10 70]; % Comment out if need for automatic color limits
h.Colormap = parula;    % Options: parula, cool, summer
h.GridVisible = 'off';  % Options: on, off
h.ColorbarVisible = 'off';   % Options: on, off
h.FontColor='none';
%h.ColorMethod = 'none';


%% Process frames
i = 0;
cmin = 5;
cmax = 10;
fid = fopen(fileName);

while ~feof(fid)
  disp(i);
  line = fgetl(fid);
  frame = jsondecode(line);
  
  cmin = min(min(frame.data));
  cmax = max(max(frame.data));
  h.ColorLimits = [cmin cmax];
  h.ColorData = frame.data;
  i = i + 1;
  
  % Save heatmap to image
  ha=get(gcf,'children');
  set(ha);
  
  saveas(h, sprintf('images/fig_%s_%s_%04d_%d_%d.png',"20210628_1630", sensor, i, round(cmin), round(cmax)));
end
fclose(fid);
