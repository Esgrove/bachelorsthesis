papersize = [16 9]./1.2; paperpos = [0 0 papersize]; screen = get(0,'screensize');

%% Moogin alipaastosuodattimen digitaalimallinnuksen taajuusvaste
Fs = 44100; % naytteenottotaajuus
Vt = 0.026; % Vt = 26 mV huoneenlammossa
k = 3.25; % takaisinkytkennan vahvistus
fc = 1200; % rajataajuus (ei vastaa todellista arvoa)
N = 44100; % naytteiden maara
i = zeros(N, 1); % Impulssivektori, pituus 1s
i(1) = 1; % ensimmainen arvo = 1
% Rajataajuden parametri
A = pi*(fc/Fs)*(1-(pi*(fc/Fs)))/(1+(pi*(fc/Fs))); 
yi = zeros(N, 1); % ulostulostaulukko
% alustetaan muuttujat
[yT, sPrev, yPrev, I1, I2, I3, I4, yS1, yS2, yS3, yS4] = deal(0);
% suodatus yksi nayte kerrallaan
for n = 1:N
    yT = i(n) + k * yPrev;
    yT = (-1)*tanh(1/(2*Vt)*yT);
    % S1
    sPrev = yS1;
    yS1 = (yT - sPrev)*(2*A*Fs);
    I1 = I1 + (yS1 + sPrev)/(2*Fs); 
    yS1 = tanh(I1);
    % S2
    sPrev = yS2;
    yS2 = (yS1 - sPrev)*(2*A*Fs);
    I2 = I2 + (yS2 + sPrev)/(2*Fs);
    yS2 = tanh(I2);
    % S3
    sPrev = yS3;
    yS3 = (yS2 - sPrev)*(2*A*Fs);
    I3 = I3 + (yS3 + sPrev)/(2*Fs); 
    yS3 = tanh(I3);
    % S4
    sPrev = tanh(yS4/(2*Vt));
    yS4 = (yS3 - sPrev)*(2*A*Fs);
    I4 = I4 + (yS4 + sPrev)/(2*Fs);
    yS4 = I4*(2*Vt);
    yi(n) = yS4;
    yPrev = yS4;
end
Xf = 2*abs(fft(yi));
Xf = 20*log10(Xf./(Xf(1))); % normalisoidaan 0 dB:seen
f0 = Fs/N; tf = 0:f0:(N-1)*f0; % taajuusvektori

figure('Position', [0, screen(4)-450, 800, 450]);
semilogx(tf, Xf,'LineWidth',0.8); grid on;
ylabel('Vahvistus (dB)'); xlabel('Taajuus (Hz)');
axis([20 16000 -55 25]);
set(gca,'XMinorGrid','off','Layer','Top',...
        'XTick',[30 60 125 250 500 1000 2000 4000 8000 16000])
set(gca,'XTickLabel',{30 60 125 250 500 '1k' '2k' '4k' '8k' '16k'})
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\moogalipaasto','-dpdf','-painters');
%%
close all;