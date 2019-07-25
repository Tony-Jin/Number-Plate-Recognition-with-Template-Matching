function I = radon_trans(image)

edge_image=edge(image,'canny');
theta = 1:180;
[R,xp] = radon(edge_image,theta);
[I_temp,J] = find(R>=max(max(R))); %J record the angle
angle=90-J;
I = imrotate(image,angle,'bilinear');% turn back

end
