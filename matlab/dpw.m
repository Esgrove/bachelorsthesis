papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');
dot = 2.5;

%% DPW
% saha-aalto ja parabolinen aaltomuoto 
t = linspace(-1,1,31);  % suora -1...1
p = 1/2*t.^2;           % integraali
n = 0:1:max(size(t))-1;
figure('Position', [0, screen(4)/2-250, 800, 500]);
stem(n,t,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;
axis([-2 32 -1.25 1.25]); grid on; xlabel('Sample (n)');
set(gca,'Xtick',0:5:30,'YTick',-1:0.5:1,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\sahastem','-dpdf','-painters');

figure('Position', [0, 0, 800, 500]);
stem(n,p,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;  
axis([-2 32 -0.0625 0.5625]); xlabel('Sample (n)'); 
set(gca,'Xtick',0:5:30,'YTick',0:0.1:0.5,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\parastem','-dpdf','-painters');

%% Kaksisuuntainen jakojaannoslaskuri
Fs = 48000;
f0 = 2400;  % perustaajuus
T0 = f0/Fs; % normalisoitu taajuus
P0 = Fs/f0; 
mc = phi(T0,0,Fs);      % vaihesignaali
bmc = 2*phi(T0,0,Fs)-1; % kaksisuuntainen
figure('Position', [0, screen(4)/2-250, 800, 500]);
stem(mc,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;
axis([0 ceil(2*P0) -0.125 1.125]); xlabel('Sample (n)');
set(gca,'YTick',0:0.25:1);
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\phi','-dpdf','-painters');

figure('Position', [0, 0, 800, 500]); 
stem(bmc,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;
axis([0 ceil(2*P0) -1.25 1.25]); xlabel('Sample (n)');
set(gca,'YTick',-1:0.5:1,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\bmc','-dpdf','-painters');

%% Kokoaaltotasasuunnattu saha-aalto
frs = 1-abs(2*phi(T0,0,Fs)-1);
figure('Position', [0, screen(4)/2-250, 800, 500]);
stem(frs,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;
axis([0 ceil(2*P0) -0.125 1.125]); xlabel('Sample (n)');
set(gca,'YTick',0:0.25:1,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\frs','-dpdf','-painters');

%% Kaksisuuntainen parabolinen aaltomuoto
bp = (2*phi(T0,0,Fs)-1).*(1-abs(2*phi(T0,0,Fs)-1));
figure('Position', [0, 0, 800, 500]);
stem(bp,'filled','lineWidth',0.6,'MarkerSize',dot); grid on;
axis([0 ceil(2*P0) -0.375 0.375]); xlabel('Sample (n)');
set(gca,'YTick',-0.3:0.15:0.3,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\bp','-dpdf','-painters');
%%
close all;