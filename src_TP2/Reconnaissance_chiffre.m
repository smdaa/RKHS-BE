% Ce programme est le script principal permettant d'illustrer
% un algorithme de reconnaissance de chiffres.

% Nettoyage de l'espace de travail
clear all; close all; clc;

% Repertories contenant les donnees et leurs lectures
addpath('Data');
addpath('Utils')

rng('shuffle')

% Bruit
sig0       = 0.02;
Precapprox = 1;

%tableau des csores de classification
% intialisation aléatoire pour affichage
r  = rand(6,5);
r2 = rand(6,5);

for k = 1:5
% Definition des donnees
file=['D' num2str(k)];

% Recuperation des donnees
disp('Generation de la base de donnees');
sD = load(file);
D  = sD.(file);

% Bruitage des données
Db= D + sig0 * rand(size(D));

%%%%%%%%%%%%%%%%%%%%%%%
% Analyse des donnees 
%%%%%%%%%%%%%%%%%%%%%%%
disp('PCA : calcul du sous-espace');
[~, U1, j1] = acp(Db, Precapprox);

disp('kernel PCA : calcul du sous-espace');
K = kernel(Db, 'linear');
[U2, D2] = eig(K);
[D2, indices_tri] = sort(diag(D2), 'descend');
U2 = U2(:,indices_tri);
j2 = 1;
while (sqrt(D2(j2) / D2(1)) > 1 - Precapprox) && (j2 < length(D2))
    j2 = j2 + 1;
end

alpha = (ones(size(D2)) ./ sqrt((D2))) .* U2;
Y = alpha' * K;

%%%%%%%%%%%%%%%%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%%
disp('TO DO')
%%%%%%%%%%%%%%%%%%%%%%%%% FIN TO DO %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconnaissance de chiffres
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 % Lecture des chiffres à reconnaitre
 disp('test des chiffres :');
 tes(:,1) = importerIm('test1.jpg',1,1,16,16);
 tes(:,2) = importerIm('test2.jpg',1,1,16,16);
 tes(:,3) = importerIm('test3.jpg',1,1,16,16);
 tes(:,4) = importerIm('test4.jpg',1,1,16,16);
 tes(:,5) = importerIm('test5.jpg',1,1,16,16);
 tes(:,6) = importerIm('test9.jpg',1,1,16,16);


 for tests = 1:6
    % Bruitage
    tes(:,tests) = tes(:,tests) +sig0 * rand(length(tes(:, tests)), 1);
    
    % Classification depuis ACP
     disp('PCA : classification');
     d1 = distance(tes(:,tests), U1(:, 1:j1));
     r(tests, k) = d1;
     
%      if(tests == k)
%        figure(100 + k)
%        subplot(1, 2, 1); 
%        imshow(reshape(tes(:, tests), [16, 16]));
%        subplot(1,2,2);
%      end  
  
   % Classification depuis kernel ACP
     %%%%%%%%%%%%%%%%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%%
     disp('kernel PCA : classification');
     d2 = distance(tes(:,tests), Y(:, 1:j2));
     
     disp('TO DO');
    %%%%%%%%%%%%%%%%%%%%%%%%% FIN TO DO %%%%%%%%%%%%%%%%%%    
 end
 
end


% Affichage du résultat de l'analyse par PCA
couleur = hsv(6);

figure(11)
for tests=1:6
     hold on
     plot(1:5, r(tests,:),  '+', 'Color', couleur(tests,:));
     hold off
 
     for i = 1:4
        hold on
         plot(i:0.1:(i+1),r(tests,i):(r(tests,i+1)-r(tests,i))/10:r(tests,i+1), 'Color', couleur(tests,:),'LineWidth',2)
         hold off
     end
     hold on
     if(tests==6)
       testa=9;
     else
       testa=tests;  
     end
     text(5,r(tests,5),num2str(testa));
     hold off
 end

% Affichage du résultat de l'analyse par kernel PCA
% figure(12)
% for tests=1:6
%      hold on
%      plot(1:5, r2(tests,:),  '+', 'Color', couleur(tests,:));
%      hold off
%  
%      for i = 1:4
%         hold on
%          plot(i:0.1:(i+1),r2(tests,i):(r2(tests,i+1)-r2(tests,i))/10:r2(tests,i+1), 'Color', couleur(tests,:),'LineWidth',2)
%          hold off
%      end
%      hold on
%      if(tests==6)
%        testa=9;
%      else
%        testa=tests;  
%      end
%      text(5,r2(tests,5),num2str(testa));
%      hold off
%  end
