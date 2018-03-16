papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');
%% Askelfunktio
Fs = 44100;
t  = -12/Fs:1/(100*Fs):12/Fs;
y  = heaviside(t);
figure('Position', [0, screen(4)/2-500, 800, 500]);
plot(t,y,'LineWidth',0.6); grid on;
axis([-12/Fs 12/Fs -0.35 1.35]); xlabel('Aika (Ts)');
set(gca,'XTick',[-12/Fs -8/Fs -4/Fs 0 4/Fs 8/Fs 12/Fs]);
set(gca,'XTickLabel',{-12 -8 -4 0 4 8 12}); set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\askelfunktio','-dpdf','-painters');

%% Ideaalinen BLEP
Fs    = 44100; 
t     = -16/Fs:1/(100*Fs):16/Fs;
iblep = 1/2 + 1/pi*sinint(pi*1*Fs*t); 
istep = heaviside(t);
figure('Position', [0, screen(4)/2-500, 800, 500]);
plot(t, istep,'--','LineWidth',0.6); grid on; hold on; 
plot(t, iblep,'LineWidth',0.6); hold off;
axis([-12/Fs 12/Fs -0.35 1.35]); xlabel('Aika (Ts)');
set(gca,'XTick',[-12/Fs -8/Fs -4/Fs 0 4/Fs 8/Fs 12/Fs]);
set(gca,'XTickLabel',{-12 -8 -4 0 4 8 12}); set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\blep','-dpdf','-painters');

%% BLEP residuaali
figure('Position', [0, screen(4)/2-500, 800, 500]);
plot(t, iblep-istep,'LineWidth',0.6); grid on; 
axis([-12/Fs 12/Fs -0.625 0.625]); xlabel('Aika (Ts)');
set(gca,'YTick',-0.5:0.25:0.5);
set(gca,'XTick',[-12/Fs -8/Fs -4/Fs 0 4/Fs 8/Fs 12/Fs]);
set(gca,'XTickLabel',{-12 -8 -4 0 4 8 12}); set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\blepres','-dpdf','-painters');

%% minBLEP
load('minblep.mat','minblep'); % minBLEP funktio taulukoituna
% http://www.musicdsp.org/archive.php?classid=1#112
x  = linspace(-2000,2000,2*2048);
x2 = linspace(-182,2048-182, 2048); % sovitetaan 0-kohdat
figure('Position', [0, screen(4)/2-500, 800, 500]);
plot(x,heaviside(x),'--','LineWidth',0.6); grid on; hold on;
plot(x2, minblep,'LineWidth',0.6); hold off;
axis([-1000 1000 -0.35 1.35]); xlabel('Sample (n)'); set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\minblep','-dpdf','-painters');
%%
close all;