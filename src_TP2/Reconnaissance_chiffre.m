% Ce programme est le script principal permettant d'illustrer
% un algorithme de reconnaissance de chiffres.

% Nettoyage de l'espace de travail
clear all; close all; clc;

% Repertories contenant les donnees et leurs lectures
addpath('Data');
addpath('Utils')

rng('shuffle')

% Bruit
sig0       = .5;

% Précision souhaité
Precapprox = .7;

%tableau des csores de classification
% intialisation aléatoire pour affichage
r  = rand(6,5);
r2 = rand(6,5);

% Lecture des chiffres à reconnaitre
tes(:,1) = importerIm('test1.jpg',1,1,16,16);
tes(:,2) = importerIm('test2.jpg',1,1,16,16);
tes(:,3) = importerIm('test3.jpg',1,1,16,16);
tes(:,4) = importerIm('test4.jpg',1,1,16,16);
tes(:,5) = importerIm('test5.jpg',1,1,16,16);
tes(:,6) = importerIm('test9.jpg',1,1,16,16);

for k = 1:5
    % Definition des donnees
    file=['D' num2str(k)];

    % Recuperation des donnees
    disp('Generation de la base de donnees');
    sD = load(file);
    D  = sD.(file);

    % Bruitage des données
    Db = D + sig0 * rand(size(D));

    %%%%%%%%%%%%%%%%%%%%%%%
    % Analyse des donnees 
    %%%%%%%%%%%%%%%%%%%%%%%
    disp('PCA : calcul du sous-espace');
    [C, V1, D1] = acp(Db, Precapprox);

    disp('kernel PCA : calcul du sous-espace');
    choix = 'linear';
    [Y, V2, D2, alpha] = kacp(Db, Precapprox, choix);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reconnaissance de chiffres
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('test des chiffres :');

    for tests = 1:6
        % Bruitage
        tes(:,tests) = tes(:,tests) +sig0 * rand(length(tes(:, tests)), 1);

        % Classification depuis ACP
         disp('PCA : classification');
         r(tests, k) = distance(tes(:,tests), V1);

       % Classification depuis kernel ACP
         disp('kernel PCA : classification');         
         %r2(tests, k) = ;
         
       % Reconstruction
         if(tests == k)
           figure(100 + k)
           subplot(1, 3, 1); 
           imshow(reshape(tes(:, tests), [16, 16]));
           title('Image');
           subplot(1, 3, 2);
           temp = reconstruction_acp(tes(:, tests), V1);
           imshow(reshape(temp, [16, 16]));
           title('Acp');
           subplot(1, 3, 3);
           max_iter = 100;
           temp = reconstruction_kacp_gauss(tes(:, tests), Y, alpha, max_iter);

         end  
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
figure(12)
for tests=1:6
     hold on
     plot(1:5, r2(tests,:),  '+', 'Color', couleur(tests,:));
     hold off
 
     for i = 1:4
        hold on
         plot(i:0.1:(i+1),r2(tests,i):(r2(tests,i+1)-r2(tests,i))/10:r2(tests,i+1), 'Color', couleur(tests,:),'LineWidth',2)
         hold off
     end
     hold on
     if(tests==6)
       testa=9;
     else
       testa=tests;  
     end
     text(5,r2(tests,5),num2str(testa));
     hold off
 end
