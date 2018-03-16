papersize = [16 9]./1.6; paperpos  = [0 0 papersize]; screen = get(0,'screensize');
dot = 2.5;

%% Simulointi
ptaajuudet = [523 1047 2093 4186]; % perustaajuudet C5 C6 C7 C8
Fs = 44100; % naytteenottotaajuus
for i = 1:4
    % puhdas Fourier-sarja
    f0 = ptaajuudet(i); T0 = f0/Fs; P0 = Fs/f0; Ts = 1/Fs; 
    t = 0:Ts:1-Ts;          % aikavektori 1s
    n = 0:1:max(size(t))-1; % naytevektori
    N = max(size(t));       % naytteiden maara
    sahasarja = zeros(1,N);
    for k = 1:floor(22050/f0)
        sahasarja = sahasarja + sin(2*pi*k*f0.*t)/k; 
    end
    sahasarja = -2/pi*sahasarja;
    Xf = 2*abs(fft(sahasarja));         % yksipuoleinen spektri
    Xfsaha = 20*log10(Xf./(max(Xf)));   % skaalataan perustaajuus 0 dB:seen 
    f = Fs/N; tfsaha = 0:f:(N-1)*f;     % taajuusvektori
    
    % puhtaat samplet
    %figure('Position',[0, screen(4)-500, 800, 500]);
    %stem(n,sahasarja,'filled','lineWidth',0.7,'MarkerSize',dot); grid on; 
    %axis([ceil(P0) ceil(3*P0) -1.1 1.1]); xlabel('Sample (n)');
    
    % DPW
    dpw = DPW4(T0,P0,Fs); % neljannen asteen DPW
    figure('Position',[0, screen(4)/2-250, 800, 500]);
    stem(n,dpw,'filled','lineWidth',0.6,'MarkerSize',dot); grid on; 
    axis([ceil(P0) ceil(3*P0) -1.25 1.25]); xlabel('Sample (n)');
    set(gcf,'PaperUnits','centimeters',...
            'PaperSize',papersize,'PaperPosition',paperpos);
    print(gcf,strcat('.\figures\dpw_',int2str(f0),'Hz_stem'),'-dpdf','-painters');
    
    Xf = 2*abs(fft(dpw));           % yksipuoleinen spektri
    Xf = 20*log10(Xf./(max(Xf)));   % skaalataan perustaajuus 0 dB:seen 
    f = Fs/N; tf = 0:f:(N-1)*f;     % taajuusvektori
    figure('Position',[0, 0, 800, 500]);
    plot(tf, Xf,'LineWidth',0.6); grid on; axis([0 22000 -90 10]); hold on; 
    ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
    set(gca,'XTick', 0:2000:22000,'Layer','Top');
    set(gca,'XTickLabel',{0 2 4 6 8 10 12 14 16 18 20 22})
    plot(tfsaha, Xfsaha,'x','MarkerSize',4); hold off; % puhtaat komponentit
    set(gcf,'PaperUnits','centimeters',...
            'PaperSize',papersize,'PaperPosition',paperpos);
    print(gcf,strcat('.\figures\dpw_',int2str(f0),'Hz'),'-dpdf','-painters');
    close all;
end