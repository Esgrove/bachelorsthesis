papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize'); 
dot = 4;

%% Ylinaytteistaminen
ptaajuudet = [523 1047 2093 4186]; % perustaajuudet C5 C6 C7 C8
%% Kolmio-aalto
ntaajuudet = [44100 88200]; % naytteenottotaajuudet
for a = 1:4
    f = ptaajuudet(a);
    for b = 1:2
        Fs = ntaajuudet(b); Ts = 1/Fs; t  = 0:Ts:2-Ts; 
        N  = max(size(t));  f0 = Fs/N; tf = 0:f0:(N-1)*f0;
        % triviaali kolmioaalto
        kolmio = 1-2*abs(sawtooth(2*pi*f*t)); 
        Xf = 2*abs(fft(kolmio)); Xf = 20*log10(Xf./(max(Xf)));
        
        % puhdaat komponentit
        kolmiop = zeros(1,N);
        for k = 1:floor(Fs/2/f)
            kolmiop = kolmiop + abs(sinc(k/2))/k*cos(2*pi*k*f.*t); 
        end
        kolmiosarja = kolmiop*(-4)/pi;
        Xfp = 2*abs(fft(kolmiosarja)); Xfp = 20*log10(Xfp./(max(Xfp))); 
        
        figure('Position',[0, screen(4)-500, 800, 500]);
        plot(tf, Xf,'LineWidth',0.6); grid on; hold on;
        plot(tf, Xfp,'x','MarkerSize',dot); hold off;
        axis([0 22000 -90 10]);
        xlabel('Taajuus (kHz)'); ylabel('Magnitudi (dB)');
        set(gca,'XTick', 0:2000:22000,'Layer','Top');
        set(gca,'XTickLabel',{0 2 4 6 8 10 12 14 16 18 20 22})
        nimi = strcat('.\figures\kolmio_',int2str(f),'hz_fs_',int2str(Fs));
        set(gcf,'PaperUnits','centimeters',...
            'PaperSize',papersize,'PaperPosition',paperpos);
        print(gcf,nimi,'-dpdf','-painters'); close;
    end
end

%% Saha-aalto
ntaajuudet = zeros(1,6); ntaajuudet(1) = 2*88200;
aste = zeros(1,6); aste(1) = ntaajuudet(1)/44100;
% naytteenottotaajuudet
for k = 2:6
    ntaajuudet(k) = 2*ntaajuudet(k-1);
    aste(k) = ntaajuudet(k)/44100;
end
for a = 1:4
    f = ptaajuudet(a);
    for b = 1:6
        Fs = ntaajuudet(b); Ts = 1/Fs; t = 0:Ts:2-Ts; N = max(size(t));
        f0 = Fs/N; tf = 0:f0:(N-1)*f0;
        % triviaali saha-aalto
        saha = sawtooth(2*pi*f*t); 
        Xf = 2*abs(fft(saha)); Xf = 20*log10(Xf./(max(Xf)));
        
        % puhdaat komponentit
        sahap = zeros(1,N);
        for k = 1:floor(44100/f)
            sahap = sahap + sin(2*pi*k*f.*t)/k; 
        end
        sahasarja = -2/pi*sahap;
        Xfp = 2*abs(fft(sahasarja)); Xfp = 20*log10(Xfp./(max(Xfp))); 
        
        figure('Position',[0, 0, 800, 500]);
        plot(tf(1,1:52000), Xf(1,1:52000),'LineWidth',0.6); grid on; hold on;
        plot(tf(1,1:52000), Xfp(1,1:52000),'x','MarkerSize',dot); hold off;
        axis([0 22000 -90 10]);
        ylabel('Magnitudi (dB)'); xlabel('Taajuus (kHz)');
        set(gca,'XTick',0:2000:22000,'Layer','Top')
        set(gca,'XTickLabel',{0 2 4 6 8 10 12 14 16 18 20 22})
        set(gcf,'PaperUnits','centimeters',...
            'PaperSize',papersize,'PaperPosition',paperpos);
        print(gcf,strcat('.\figures\saha_',int2str(f),'hz_fs_',int2str(b)),...
                         '-dpdf','-painters'); close;
    end
end