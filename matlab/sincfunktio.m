papersize = [16 9]./1.6; paperpos = [0 0 papersize]; screen = get(0,'screensize');

%% Sinc-funktio
t = -30:0.001:30; h = sinc(t);
figure('Position', [0, screen(4)/2-250, 800, 500]);
plot(t,h,'LineWidth',0.6); grid on; axis([-15 15 -0.35 1.35]); 
xlabel('aika (x)'); set(gca,'XTick',-15:5:15); 
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\sinc','-dpdf','-painters');

%% Suorakaidepulssi 
t = -2:0.001:2; y = rectpuls(t);
figure('Position', [0, 0, 800, 500]);
plot(t,y,'LineWidth',0.6); grid on; axis([-1.25 1.25 -0.35 1.35]);
xlabel('Normalisoitu taajuus'); set(gca,'XTick',[-1 -0.5 0 0.5 1]);
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\rect','-dpdf','-painters');