papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');
dot = 2.5;

%% DPW ja triviaali ero
f0 = 2400;                   % perustaajuus
Fs = 48000;                  % naytteenottotaajuus
T0 = f0/Fs;                  % normalisoitu taajuus
P0 = Fs/f0; N = Fs;          % naytemaara
saha = 2*phi(T0,0.5,Fs) - 1; % triviaali saha
dpw  = DPW4(T0,P0,Fs);       % dpw saha

figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(saha,'-o','LineWidth',0.6,'MarkerEdgeColor',[0 0.4470 0.7410],...
                               'MarkerFaceColor',[0 0.4470 0.7410],...
                               'MarkerSize',dot); grid on; hold on;
plot(dpw,'-s','LineWidth',0.6,'MarkerEdgeColor',[0.8500 0.3250 0.0980],...
                               'MarkerFaceColor',[0.8500 0.3250 0.0980],...
                               'MarkerSize',dot);
axis([ceil(P0) ceil(3.2*P0) -1.25 1.25]); xlabel('Sample (n)');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\ptrhuomio','-dpdf','-painters');

% erotus
figure('Position', [0, 0, 800, 500]);
stem(saha-dpw,'filled','lineWidth',0.6,'MarkerSize',dot); grid on; 
axis([ceil(P0) ceil(3.2*P0) -2.3125 0.8125]); xlabel('Sample (n)');
set(gca,'YTick',-2:0.5:0.5);
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\ptrero','-dpdf','-painters');