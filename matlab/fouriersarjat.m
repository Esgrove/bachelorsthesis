papersize = [16 9]./1.6; paperpos  = [0 0 papersize]; screen = get(0,'screensize');

f  = 100;               % perustaajuus
Fs = 44100;             % naytteenottotaajuus
Ts = 1/Fs; t = 0:Ts:2;  % aikavektori
N  = max(size(t));      % naytteiden maara

%% Kolmio
kolmio = zeros(1,N); % alustetaan taulukko
for k = 1:20 % lasketaan sarjaa
    kolmio = kolmio + abs(sinc(k/2))/k*cos(2*pi*k*f.*t); 
end
kolmiosarja = kolmio*(-4)/pi;

% aaltomuoto
figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(t, kolmiosarja,'LineWidth',0.6); grid on; axis([0 3/f -1.4 1.4]); 
xlabel('Aika (ms)'); set(gca,'XtickLabel',0:5:30,'Layer','Top'); 
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\kolmiosarja','-dpdf','-painters');

% taajuuspektri
Xf = 2*abs(fft(kolmiosarja)); % yksipuoleinen spektri
Xf = 20*log10(Xf./(max(Xf))); % skaalataan perustaajuus 0 dB:seen 
f0 = Fs/N; tf = 0:f0:(N-1)*f0; % taajuusvektori
figure('Position',[0, 0, 800, 500]);
semilogx(tf, Xf,'LineWidth',0.6); grid on;
ylabel('Magnitudi (dB)'); xlabel('Taajuus (Hz)'); axis([80 5000 -67.5 7.5]);
set(gca,'XMinorGrid','off','Layer','Top',...
        'XTick',     [100 200 500 1000 2000 4000],...
        'XTickLabel',{100 200 500 '1k' '2k' '4k'});
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\kolmiospektri','-dpdf','-painters');

%% Suorakaide
kantti = zeros(1,N);
for k = 1:20
    kantti = kantti + sin(2*pi*(2*k-1)*f.*t)/(2*k-1); 
end
kanttisarja = kantti*4/pi;

% aaltomuoto
figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(t, kanttisarja,'LineWidth',0.6); grid on; axis([0 3/f -1.4 1.4]);
xlabel('Aika (ms)'); set(gca,'XtickLabel',0:5:30,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\suorakaidesarja','-dpdf','-painters');

% taajuuspektri
Xf = 2*abs(fft(kanttisarja));
Xf = 20*log10(Xf./(max(Xf))); 
f0 = Fs/N; tf = 0:f0:(N-1)*f0;
figure('Position',[0, 0, 800, 500]);
semilogx(tf, Xf,'LineWidth',0.6); grid on; % Spektri
ylabel('Magnitudi (dB)'); xlabel('Taajuus (Hz)'); axis([80 5000 -67.5 7.5]); 
set(gca,'XMinorGrid','off','Layer','Top',...
        'XTick',     [100 200 500 1000 2000 4000],...
        'XTickLabel',{100 200 500 '1k' '2k' '4k'});
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\suorakaidespektri','-dpdf','-painters');

%% Saha
saha = zeros(1,N);
for k = 1:20
    saha = saha + sin(2*pi*k*f.*t)/k; 
end
sahasarja = -2/pi*saha;

% aaltomuoto
figure('Position',[0, screen(4)/2-250, 800, 500]);
plot(t, sahasarja,'LineWidth',0.6); grid on; axis([0 3/f -1.4 1.4]);
xlabel('Aika (ms)'); set(gca,'XtickLabel',0:5:30,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\sahasarja','-dpdf','-painters');

% taajuuspektri
Xf = 2*abs(fft(sahasarja));
Xf = 20*log10(Xf./(max(Xf))); 
f0 = Fs/N; tf = 0:f0:(N-1)*f0;
figure('Position',[0, 0, 800, 500]);
semilogx(tf, Xf,'LineWidth',0.6); grid on; % Spektri
ylabel('Magnitudi (dB)'); xlabel('Taajuus (Hz)'); axis([80 5000 -67.5 7.5]); 
set(gca,'XMinorGrid','off','Layer','Top',...
        'XTick',     [100 200 500 1000 2000 4000],...
        'XTickLabel',{100 200 500 '1k' '2k' '4k'});
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\sahaspektri','-dpdf','-painters');
%% 
close all;