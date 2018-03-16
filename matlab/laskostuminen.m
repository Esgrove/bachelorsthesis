papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');

%% Triviaali saha-aalto
f = 1000; % taajuus (Hz)
Fs = 44100; % naytteenottotaajuus
Ts = 1/Fs; t = 0:Ts:2-Ts; N = max(size(t));
saha = sawtooth(2*pi*f*t); % sahafunktio
Xf = 2*abs(fft(saha)); % yksipuoleinen spektri
Xf = 20*log10(Xf./(max(Xf))); % skaalataan perustaajuus 0 dB:seen 
f0 = Fs/N; tf = 0:f0:(N-1)*f0; % taajuusvektori

figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([500 5500 -56.25 6.25]); 
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[1000 2000 3000 4000 5000])
set(gca,'XTickLabel',{1 2 3 4 5},'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha5lask','-dpdf','-painters');

figure('Position',[0, 0, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([0 20000 -56.25 6.25]);
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[0 5000 10000 15000 20000]); 
set(gca,'XTickLabel',{0 5 10 15 20}); set(gca, 'Layer', 'Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha20lask','-dpdf','-painters');

%% Laskostumattomat komponentit
% Fourier sarja, komponentteja vain 20 kHz asti
summa = zeros(1,N);
for k = 1:20
    summa = summa + sin(2*pi*k*f.*t)/k; 
end
sahasarja = -2/pi*summa;
Xf = 2*abs(fft(sahasarja)); % yksipuoleinen spektri
Xf = 20*log10(Xf./(max(Xf))); % skaalataan perustaajuus 0 dB:seen 
f0 = Fs/N; tf = 0:f0:(N-1)*f0; % taajuusvektori

figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([500 5500 -56.25 6.25]); 
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[1000 2000 3000 4000 5000])
set(gca,'XTickLabel',{1 2 3 4 5},'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha5','-dpdf','-painters');

figure('Position',[0, 0, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([0 20000 -56.25 6.25]);
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[0 5000 10000 15000 20000]); 
set(gca,'XTickLabel',{0 5 10 15 20},'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha20','-dpdf','-painters');
%%
close all;