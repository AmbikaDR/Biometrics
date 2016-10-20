clear all;
close all;
clc;

cd('sub2_session2');
    str=strcat('sub2_session2_frame',int2str(t),'.png');   
    eval('J=imread(str);');

imgrgb =rgb2gray(imresize(J,[512,512]));
I = (imcrop(imgrgb,[1,1,512,204]));
val = max(max(I));
for i=1:204
    for j=512
        if I(i,j)> (val-50) || I(i,j)< (val+50)
            I(i,j)=0;
        end
    end
end

Iedge = edge(I,'canny',0.3);
% Iedge = edge(histeq(I),'prewitt',0.2,'horizontal');% for 128x128
% Iedge = edge(histeq(I),'prewitt',0.03,'horizontal');
Iedge2 = bwareaopen(Iedge,10);
se = strel('line',5,0);
Iedge3 = imclose(Iedge2,se);
Iedge4 = bwareaopen(Iedge3,20);
se = strel('line',10,0);
Irefine = imclose(Iedge4,se);
Irefine = bwareaopen(Irefine,20);
C = corner(Irefine,'Harris',4);
figure();imshow(Irefine);
hold on
plot(C(:,1), C(:,2), 'r*');
% figure();imshow(I);
% hold on
% plot(C(:,1), C(:,2), 'r*');

% % % Good one: Eye corner detection using canny edge for t=1 i.e.,
% % % sub1_session2_frame1
% % imgrgb =rgb2gray(imresize(J,[256,256]));
% % I = histeq(imcrop(imgrgb,[1,1,256,102]));
% % Iedge = edge(I,'canny',0.45);
% % C = corner(Iedge,'Harris',4);
% % figure();imshow(Iedge);
% % hold on
% % plot(C(:,1), C(:,2), 'r*');
% % figure();imshow(I);
% % hold on
% % plot(C(:,1), C(:,2), 'r*');

% % % Eye corner detection using harris
% % % I = histeq(imcrop(imgrgb,[1,1,256,102]));
% % % val = mean(mean(I));
% % % for i =1:102
% % %     for j=1:256
% % %         if I(i,j)<77 || I(i,j)>250
% % %             I(i,j) = val;
% % %         end
% % %     end
% % % end
% % % corners = detectHarrisFeatures(I,'MinQuality',0.1,'ROI', [1,1,256,102] );
% % % imshow(I,[]); hold on;
% % % plot(corners.selectStrongest(10));
% % % 


% % % %%% to detect eyebrows and eyes for casia 3d images
% % % % corners = detectHarrisFeatures(I,'MinQuality',0.01,'ROI', [1,1,128,51] );
% % % I = histeq(imcrop(I,[1,1,256,102]));
% % % for i =1:102
% % %     for j=1:256
% % %         if I(i,j)>55
% % %             I(i,j) = 100;
% % %         end
% % %     end
% % % end
% % % corners = detectHarrisFeatures(I,'MinQuality',0.4,'ROI', [1,1,256,102] );
% % % imshow(I,[]); hold on;
% % % plot(corners.selectStrongest(4));

