papersize = [16 9]./1.6; paperpos  = [0 0 papersize]; screen = get(0,'screensize'); 

%% Kolmioaalto
x = 0:0.001:2*(2*pi); y = abs(4*(mod((x./(2*pi)-1/4),1))-2)-1;
figure('Position', [0, screen(4)-500, 800, 500]);
plot(x, y,'LineWidth',0.6); grid on; axis([0 4*pi -1.3 1.3]); xlabel('Jakso'); 
set(gca,'XTick',[0 1*pi 2*pi 3*pi 4*pi],'XTickLabel',{0 0.5 1 1.5 2}); 
set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\kolmioaalto','-dpdf','-painters');

%% suorakaideaalto
x = 0:0.001:2*(2*pi); 
y = sign(sin(x));
figure('Position', [0, screen(4)-500, 800, 500]);
plot(x, y,'LineWidth',0.6); grid on; axis([0 4*pi -1.3 1.3]); xlabel('Jakso'); 
set(gca,'XTick',[0 1*pi 2*pi 3*pi 4*pi],'XTickLabel',{0 0.5 1 1.5 2}); 
set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\suorakaideaalto','-dpdf','-painters');

%% Saha-aalto
x = 0:0.001:4; 
y = 2*((x+1)./2-floor((x+1)./2))-1;
figure('Position', [0, screen(4)-500, 800, 500]);
plot(x, y,'LineWidth',0.6); grid on; axis([0 4 -1.3 1.3]); xlabel('Jakso');
set(gca,'XTick',[0 1 2 3 4],'XTickLabel',{0 0.5 1 1.5 2}); 
set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha_aalto','-dpdf','-painters');

%% Kaanteinen sahalaita-aalto
x = 0:0.001:4; 
y = -2*((x+1)./2-floor((x+1)./2))+1;
figure('Position', [0, screen(4)-500, 800, 500]);
plot(x, y,'LineWidth',0.6); grid on; axis([0 4 -1.3 1.3]); xlabel('Jakso');
set(gca,'XTick',[0 1 2 3 4],'XTickLabel',{0 0.5 1 1.5 2}); 
set(gca,'Layer','Top');
set(gcf,'PaperUnits','centimeters',...
        'PaperSize',papersize,'PaperPosition',paperpos);
print(gcf,'.\figures\saha_aalto_kaan','-dpdf','-painters');
%%
close all;