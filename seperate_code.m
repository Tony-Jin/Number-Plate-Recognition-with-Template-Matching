%the main aim of these program is to seperate the characters and plates
%delete the background
[m1 n1] = size(preprocess_result);
sm1 = sum(preprocess_result,2); %get them in the horizental direction
cut_start1 = 1; cut_end1 = m1;
for k = 1:m1-1
    if sm1(k) < 30 && sm1(k+1) >= 30
        cut_start1 = k+1;
    end
end
for k = 1:m1-1
    if sm1(k) >= 30 && sm1(k+1) < 30
        cut_end1 = k;
    end
end
%diff_background = cut_end1 - cut_start1; 
plate_image = preprocess_result(cut_start1:cut_end1,:);
figure(11), imshow(plate_image);

%inverse binary image
[m2,n2]=size(plate_image);       
black_plate=ones(m2,n2)-plate_image;
figure(12),imshow(black_plate);

%resize_image = imresize(black_plate,[400 NaN]);

%seperate the image
[m_sep,n_sep] = size(black_plate);
%cut in the vertical direction
sm_col = sum(black_plate);
start_col = []; end_col = [];
for k = 1:n_sep-1
    if sm_col(1,k) < 10 && sm_col(1,k+1) >= 10
        start_col = [start_col k];
    else
      if sm_col(1,k) >= 10 && sm_col(1,k+1) < 10 && k > 10
          end_col = [end_col k];
      end
    end
end

if sm_col(1,1) >= (m_sep-20)
    start_col = [1 start_col];
end

if sm_col(1,n_sep) >= (m_sep-20)
    end_col = [end_col n_sep];
end

len_start_col = length(start_col);
%diff_col = end_col - start_col;
%diff_col_max = max(diff_col);
for k = 1:len_start_col
    %add zero
    %left = floor((diff_col_max - diff_col(k))/2);
    %right = ceil((diff_col_max - diff_col(k))/2);
    %le = zeros(m_sep,left);
    %ri = zeros(m_sep,right);
    
    seperate1{k} = black_plate(:,start_col(1,k):end_col(1,k));
    %seperate1{k} = [le seperate_temp{k} ri];
    
end
%cut in horzental direction
start_hor = [];
end_hor = [];

for k = 1:len_start_col
    sm_hor = sum(seperate1{k},2);
    start_temp = 1;
    end_temp = m_sep
    for k2 = 1:m_sep-1
      if sm_hor(k2) < 10 && sm_hor(k2+1) >= 10
          start_temp = k2;
          %start_hor = [start_hor k2];
          break;
      end
    end
    for k2 = 1:m_sep-1
      if sm_hor(k2) >= 10 && sm_hor(k2+1) < 10
          end_temp = k2
          %end_hor = [end_hor k2];
      end
    end
    start_hor = [start_hor start_temp];
    end_hor = [end_hor end_temp];
end


diff_hor = end_hor - start_hor;
compare = diff_hor(1) - diff_hor(2);
compare2 = diff_hor(len_start_col) - diff_hor(len_start_col-1);
judge = 0;
if compare >= 10
    diff_hor(1) = [];
    start_hor(1) = [];
    end_hor(1) = [];
    start_col(1) = [];
    end_col(1) = [];
    judge = 1;
end

if (compare2 >= 10)&&(judge == 1)
    diff_hor(len_start_col-1) = [];
    start_hor(len_start_col-1) = [];
    end_hor(len_start_col-1) = [];
    start_col(len_start_col-1) = [];
    end_col(len_start_col-1) = [];
end
    
if (compare2 >= 20)&&(judge == 0)
    diff_hor(len_start_col) = [];
    start_hor(len_start_col) = [];
    end_hor(len_start_col) = [];
    start_col(len_start_col) = [];
    end_col(len_start_col) = [];
end

len_start_hor = length(start_hor);
diff_hor_max = max(diff_hor);
max_number = find(diff_hor == diff_hor_max);
start_hor_st = start_hor(max_number);
end_hor_st = end_hor(max_number);
diff_col = end_col - start_col;
diff_col_max = max(diff_col);
for k = 1:len_start_hor
    seperate_hor{k} = seperate1{k+judge}(start_hor_st:end_hor_st,:);
    %add zero
    left = floor((diff_col_max - diff_col(k))/2);
    right = ceil((diff_col_max - diff_col(k))/2);
    le = zeros(diff_hor_max+1,left);
    ri = zeros(diff_hor_max+1,right);
    seperate_final{k} = [le seperate_hor{k} ri];
    
end
%display
figure(13)
for k = 1:len_start_hor
    subplot(1,len_start_hor,k);
    imshow(seperate_final{k});
    axis off;
end

for k = 1 : len_start_hor
    [m,n]=size(seperate_final{k});       %inverse binary image
    plate_sep_black{k} = ones(m,n)-seperate_final{k};
end

figure(14)
for k = 1:len_start_hor
    subplot(1,len_start_hor,k);
    imshow(plate_sep_black{k});
    axis off;
end

