%the main aim of these program is to seperate the characters and plates
%delete the background
sm1 = sum(process_image,2); %get them in the horizental direction
[ver,hor] = size(process_image);
%start side
cut_start = [];
cut_end = [];
for k = 1:1:ver-6
    if sm1(k) < 500 && sm1(k+1) >= 500 && sm1(k+2) >= 500 && sm1(k+3) >= 500 && sm1(k+4) >= 500 && sm1(k+5) >= 500
        cut_start = [cut_start k+1];
    end
end

if isempty(cut_start)
    cut_start = 1;
end

%end side; 
for k = 1:1:ver-6
    if sm1(k) >= 500 && sm1(k+1) >= 500 && sm1(k+2) >= 500 && sm1(k+3) >= 500 && sm1(k+4) >= 500 && sm1(k+5) < 500
        cut_end = [cut_end k+4];
    end
end

if isempty(cut_end)
    cut_end = ver;
end

diff_hor = cut_end - cut_start;
[max_hor,n] = max(diff_hor);

plate_image = process_image(cut_start(n):cut_end(n),:);
figure(11), imshow(plate_image);

[m1,n1] = size(plate_image); %new size of image
%cut in the vertical direction
sm_col = sum(plate_image);
start_col = []; end_col = [];
for k = 1:n1-4
    if sm_col(1,k) < 40 && sm_col(1,k+1) >= 40 && sm_col(1,k+2) >= 40 && sm_col(1,k+3) >= 40 sm_col(1,k+4) >= 40
        start_col = [start_col k+1];
    end
end

for k = start_col(1):n1-4
      if sm_col(1,k) >= 40 && sm_col(1,k+1) >= 40 && sm_col(1,k+2) >= 40 && sm_col(1,k+3) >= 40 && sm_col(1,k+4) < 40 
          end_col = [end_col k+3];
      end
end


len_start_col = length(start_col);
len_end_col = length(end_col);

if (len_start_col > len_end_col)
    start_col(len_start_col) = [];
end

diff_col = end_col - start_col;
compare = diff_col(1) - diff_col(2);
EU_symbol = plate_image(:,start_col(1,1):end_col(1,1));
sm_c = sum(EU_symbol,2);
count = 0;

for i = 1:1:length(sm_c)
    if (sm_c(i) >130)
        count = count + 1;
    else
        count = 0;
    end
    
    if (count > 80)
        diff_col(1) = [];
        start_col(1) = [];
        end_col(1) = [];
        break;
    end
end

len_start_col_new = length(start_col);
len_end_col_new = length(end_col);
diff_col_new = end_col - start_col;

if (len_start_col_new > 7 && len_end_col_new > 7)
    for i = 8:1:len_start_col_new;
        diff_col(i) = [];
        start_col(i) = [];
        end_col(i) = [];
    end
end

number_of_char = length(end_col)
diff_col_max = max(diff_col);
for k = 1:number_of_char
    %add zero
    left = floor((diff_col_max - diff_col(k))/2);
    right = ceil((diff_col_max - diff_col(k))/2);
    le = zeros(m1,left);
    ri = zeros(m1,right);
    
    seperate_temp{k} = plate_image(:,start_col(1,k):end_col(1,k));
    seperate1{k} = [le seperate_temp{k} ri];
    
end

%display
figure(12)
for k = 1:number_of_char
    subplot(1,number_of_char,k);
    imshow(seperate1{k});
    axis off;
end

figure(13)
for k = 1:number_of_char
    subplot(1,number_of_char,k);
    plate_sep_black{k} = inverse(seperate1{k});
    imshow(plate_sep_black{k});
    axis off;
end

