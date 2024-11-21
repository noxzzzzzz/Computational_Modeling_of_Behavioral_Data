clear
 
defImage = pow2(get(0,'DefaultImageCData'),47);
imgCell = repmat({zeros(size(defImage))},8,7);
for shift = 0:52
    imgCell{shift+1} = bitshift(defImage,shift);
end;
allImages = cell2mat(imgCell.');
imshow(allImages,[min(allImages(:)) max(allImages(:))]);
 
figure(1); clf
for i = 1:52
    i
    imagesc(imgCell{i})
    title(num2str(i))
    pause(1)
end

% Is this real!!?