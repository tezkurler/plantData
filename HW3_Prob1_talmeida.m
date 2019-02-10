% This program intakes a text file which includes numbers on 
% plant ID, status, height, and concentration.  It then cerates a new organized 
% .txt file and then outputs the highest or lowest concentration of specified 
% plants.
%---------------------------------------------------
%  Inputs
%---------------------------------------------------
clc 
clear all
% import data
whole = importdata('plant_treatment_data.txt', ' ', 1);
Data = struct2cell(whole);

% sort rows based on column 1
pd = Data{1,1};
sor = sortrows(pd,1);

% make each rown an array
id = sor(1:end,1); % plantID
stat = sor(1:end,2); % plant status
height0 = sor(1:end,3); % initial height
height = sor(1:end,4); % final height
conc = sor(1:end,5); % conentration of treatment

grow = [height - height0]; % plant growth
newd = [id, stat, grow, conc]; % new array with growth

% transpose data 
A = transpose(new);

% open a new txt file and writ in data
fileID = fopen('sorted_treatment_data.txt','w');
fprintf(fileID,['%-8s %-8s %-8s'...
  ' %-13s\n'],'PlantId','Status','Growth','Concentration');
fprintf(fileID,'\n');
fprintf(fileID,'%-8d %-8d %-8.2f %-8.2f\r\n', A);
fclose(fileID);
% new array with only status and concentration
mini = [stat, conc];
concDead = []; % concentration of plants that died, status 0
concLive = []; % concentration of plants that plant survived the treatment yet did contract the disease, status 1
concDis = []; % concentration of plant that survived the treatment and did not contract the disease, status 2
x = 1;
w = 1;
q = 1;
p = 1; 

% organize data based on status into arrays
while (mini(x,1) == 0)  && (x <= rows(mini))
  concDead(p) = mini(x,2);
  p++;
  x++;
  endwhile
while (mini(x,1) == 1) && (x <= rows(mini))
  concLive(w) = mini(x,2);
  w++;
  x++;
  endwhile
while (x <= rows(mini)) && (mini(x,1) == 2) 
  concDis(q) = mini(x,2);
  q++;
  x++;
  endwhile

% sort arrays based on required output 
zero = sort(concDead);
one = sort(concLive, 'descend');
two = sort(concDis);
%---------------------------------------------------
% Outputs
%--------------------------------------------------- 
fprintf('The lowest concentration for a plant that died: %.2f g/L\n', zero(1));
fprintf(['\nThe lowest concentration for a plant that survived and '...
  'did not contract the disease: %.2f g/L\n'], two(1));
fprintf(['\nThe highest concentration for a plant that survived '...
  'but contracted the disease: %.2f g/L \n'], one(1));

