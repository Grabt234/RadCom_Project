%% SIMULATING RAGNE DOPPLER

range_doppler = rand(1000,1000);

%% DEFINE TARGET

target_size_x = 11;
target_size_y = 51;

target_c_x = floor(target_size_x/2)+1;
target_c_y = floor(target_size_y/2)+1;

target_dis_x = floor(target_size_x/2);
target_dis_y = floor(target_size_y/2);

target_response = ones(target_size_y,target_size_x);

target_response(:,:) = 0.2;
target_response(9:43,2:10) = 0.4;
target_response(15:37,3:9) = 0.6;
target_response(21:31,4:8) = 0.8;
target_response(:,5:7) = 1;
target_response(26,6) = 1;

%target_pos_xs = [20 30 40 50 ];
target_pos_xs = [250 257];
target_pos_ys = [250 250];
target_rcss   = [1 1 0.5 ];

%how much energy would be received with rcs = 1
response_scaling = 5;

ref_dis_x = -target_dis_x:target_dis_x;
ref_dis_y = -target_dis_y:target_dis_y;

for i = 1:numel(target_pos_xs)
    
    target_pos_y = target_pos_ys(i);
    target_pos_x = target_pos_xs(i);
    rcs = target_rcss(i);
    
    for tg_x = 1:numel(ref_dis_x)
       
           for tg_y = 1:numel(ref_dis_y)
              
               xx = ref_dis_x (tg_x);
               yy = ref_dis_y (tg_y);
               range_doppler(target_pos_y+yy, target_pos_x+xx) = ...
                   range_doppler(target_pos_y+yy, target_pos_x+xx) + rcs*response_scaling*target_response(tg_y,tg_x);
           end
        
    end
    
    
end



%% DEFINE FILTER

filter_scale = 1;
dim_x = 1;
dim_y = 51;
filter_size = dim_x*dim_y;
filter = ones(dim_y,dim_x);
filter(:,:) = 0.2;
filter(9:43,:) = 0.4;
filter(15:37,:) = 0.6;
filter(21:31,:) = 0.8;
filter(25:27,:) = 0.9;
filter(26,:) = 1;

% % filter(:,:) = 0.2;
% % filter(9:43,2:10) = 0.4;
% % filter(15:37,3:9) = 0.6;
% % filter(21:31,4:8) = 0.8;
% % filter(25:27,5:7) = 0.9;
% % filter(26,6) = 1;

c_x = floor(dim_x/2)+1;
c_y = floor(dim_y/2)+1; 

dis_x = c_x-1;
dis_y = c_y-1;

%% APPLY FILTER

rd_2 = zeros(size(range_doppler));

%interating through range doppler positions
for y = 1+c_y:size(range_doppler,1) - c_y
   
    for x = 1 + c_x :size(range_doppler,2)- c_x
        
        %applying 2d filters
        range_dop_block = range_doppler( y - dis_y : y + dis_y , x - dis_x : x + dis_x );
        calc = range_dop_block.*filter/filter_size;
        rd_2(y,x) = sum(calc, "all");
        
    end
    
end

%% PLOTTING



range_doppler = 10*log10(range_doppler);
range_doppler_2 = 10*log10(rd_2(c_y+1:end-c_y,c_x+1:end-c_x));
% 
% % figure
% % histogram(range_doppler)
% % figure
% % histogram(range_doppler_2)
% 
figure
imagesc(range_doppler);
m = mean(range_doppler)
m = mean(m);
[ma,~] = max(range_doppler);
[ma,~] = max(ma);
dif = ma-m
figure
imagesc(range_doppler_2 );
m = mean(range_doppler_2);
m = mean(m);
[ma,~] = max(range_doppler_2);
[ma,~] = max(ma);
dif = ma-m
% 




