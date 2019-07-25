liccode = char(['0':'9' 'A':'Z']);
%len_starts2 = len_start_hor;
for k = 1:len_start_hor
    sam = imresize(plate_sep_black{k},[57 36]);
    if (k == 3| k == 4)
     for k2 = 1:10
         fname = strcat('D:\study\year4 autumn\final year project\matlab\database1\',liccode(k2),'.bmp');
         model = imread(fname);
         for i = 1 : 57
             for j = 1 : 36
                sub(i,j) = sam(i,j) - model(i,j);
             end
         end
         d = 0;% the number of difference with model
         for k1 = 1 : 57
             for m = 1 : 36
                 if (sub(k1,m) < 0|sub(k1,m) > 0)
                    d = d+1;
                 end
             end
         end
         error(k2) = d;
     end
     error1  = error(1:10);
     minerror = min(error1);
     p(k) = find(error1 == minerror);
    else
        for k2 = 11:36
         fname = strcat('D:\study\year4 autumn\final year project\matlab\database1\',liccode(k2),'.bmp');
         model = imread(fname);
         for i = 1 : 57
             for j = 1 : 36
                sub(i,j) = sam(i,j) - model(i,j);
             end
         end
         d = 0;% the number of difference with model
         for k1 = 1 : 57
             for m = 1 : 36
                 if (sub(k1,m) < 0|sub(k1,m) > 0)
                    d = d+1;
                 end
             end
         end
         error(k2) = d;
     end
     error1  = error(11:36);
     minerror = min(error1);
     findc = find(error1 == minerror);
     p(k) = findc +10;
    end
end

for k = 1 : len_start_hor
    character(k) = liccode(p(k));
    %disp(character);
end

fid = fopen('plate.txt', 'wt');     % This portion of code writes the number plate
fprintf(fid,'%s\n',character);      % to the text file, if executed a notepad file with the
fclose(fid);                        % name noPlate.txt will be open with the number plate written.
winopen('plate.txt');
        
        