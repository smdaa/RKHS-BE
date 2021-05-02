% Ce programme est le script principal permettant d'illustrer
% un algorithme de reconnaissance de chiffres.

% Nettoyage de l'espace de travail
clear all; close all; clc;

% Repertories contenant les donnees et leurs lectures
addpath('Data');
addpath('Utils')

rng('shuffle')

% Bruit
sig0       = 0.05;

% Précision souhaité
Precapprox = .9;

% choix du noyau
choix = 'gauss';
args = 5;

disp('---------------------------');
disp('---------------------------');
disp(['sig0 = ', num2str(sig0)]);
disp(['Précision souhaité = ', num2str(Precapprox)]);
disp(['choix du noyau = ', choix]);
if strcmp(choix, 'polynomial')
    disp(['d = ', num2str(args)]);
elseif strcmp(choix, 'gauss')
    disp(['sigma = ', num2str(args)]);
end
disp('---------------------------');
disp('---------------------------');

%tableau des csores de classification
% intialisation aléatoire pour affichage
r  = rand(6,5);
r2 = rand(6,5);

% pour calculer le temps d'execution
T_acp = 0;
T_kacp = 0;

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
    disp('-------------------------------------------------------------');
    disp(['PCA : calcul du sous-espace pour la donnée D', num2str(k)]);
    t = cputime;
    [~, V1, D1] = acp(Db, Precapprox);
    T_acp = T_acp + cputime - t;
    disp(['la dimenssion réduite = ', num2str(size(V1, 2))]);
    disp('-------------------------------------------------------------');
    
    disp('-------------------------------------------------------------');
    disp(['kernel PCA : calcul du sous-espace pour la donnée D', num2str(k)]);
    %calcul de la matrice du noyau sur les données Db
    t = cputime;
    K = kernel(Db, choix, args);
    [V2, alpha] = kacp(K, Precapprox);
    T_kacp = T_kacp + cputime - t;
    disp(['la dimenssion réduite = ', num2str(size(V2, 2))]);
    disp('-------------------------------------------------------------');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Reconnaissance de chiffres
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for tests = 1:6
        
        % Bruitage
        tes(:,tests) = tes(:,tests) +sig0 * rand(length(tes(:, tests)), 1);
        
        % Classification depuis ACP
        % on test sur des données centrées
        x   = tes(:,tests);
        r(tests, k) = distance(x - mean(x), V1);
        
        % Classification depuis kernel ACP
        K_x = kernel_new_image(Db, x, choix, args);
        n = size(K, 1);
        
        proj_m   = V2 * (alpha' * mean(K, 2));
        proj_phi = V2 * (alpha' * K_x);
        
        b = kernel(x, choix, args) - (2 / n) * sum(K_x) + (1 / n^2) * sum(K, 'all');
        a = norm(proj_m - proj_phi) ^ 2;
        
        r2(tests, k) = 1 - (a / b);
        
        % Reconstruction
        if(tests == k)
            
            figure(100 + k)
            subplot(1, 3, 1);
            imshow(reshape(tes(:, tests), [16, 16]));
            title('Image');
            
            subplot(1, 3, 2);
            re_acp = reconstruction_acp(tes(:,tests), Db, V1);
            imshow(reshape(re_acp, [16, 16]));
            title('ACP');
            
            if strcmp(choix, 'gauss')
                subplot(1, 3, 3);
                max_iter = 50;
                Y_x = K_x' * alpha;
                re_kacp = reconstruction_kacp_gauss(Y_x, Db, alpha, args, max_iter);
                imshow(reshape(re_kacp, [16, 16]));
                title('Kernel ACP (guass)');
            end
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
    title('Affichage du résultat de l analyse par PCA')
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
    title('Affichage du résultat de l analyse par kernel PCA')
end

disp(['le temps d execution total Acp ', num2str(T_acp)]);
disp(['le temps d execution total Kacp ', num2str(T_kacp)]);
