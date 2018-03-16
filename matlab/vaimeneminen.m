papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');

f  = 1000; % perustaajuus
Fs = 2^18; % naytteenottotaajuus (fft nopea kahden potensseille)
Ts = 1/Fs; t = 0:Ts:1-Ts; % aikavektori
N = max(size(t)); 

%% Saha-aalto
saha = zeros(1,N);
for k = 1:100
    saha = saha + sin(2*pi*k*f.*t)/k; 
end
sahasarja = -2/pi*saha;
Xf = 2*abs(fft(sahasarja));
Xf = 20*log10(Xf./(max(Xf))); 
f0 = Fs/N; tf = 0:f0:(N-1)*f0;

figure('Position',[0, screen(4)-500, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([-3000 104000 -90 10]);
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[1000 20000 40000 60000 80000 100000])
set(gca,'XTickLabel',{'1' '20' '40' '60' '80' '100'},'Layer','Top')
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha100','-dpdf','-painters');

%% Kolmio-aalto
kolmio = zeros(1,N);
for k = 1:100
    kolmio = kolmio + abs(sinc(k/2))/k*cos(2*pi*k*f.*t);
end
kolmiosarja = kolmio*(-4)/pi;
Xf = 2*abs(fft(kolmiosarja));
Xf = 20*log10(Xf./(max(Xf))); 
f0 = Fs/N; tf = 0:f0:(N-1)*f0;

figure('Position',[0, 0, 800, 500]);
plot(tf, Xf,'LineWidth',0.6); grid on; axis([-3000 104000 -90 10]);
ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
set(gca,'XTick',[1000 20000 40000 60000 80000 100000])
set(gca,'XTickLabel',{'1' '20' '40' '60' '80' '100'},'Layer','Top')
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\kolmio100','-dpdf','-painters');
%%
close all;