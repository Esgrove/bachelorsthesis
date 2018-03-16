function y = DPW4(T0,P0,Fs)
% Neljannen asteen DPW algoritmi
% http://research.spa.aalto.fi/publications/papers/spl-ptr/
	[z0, z1, z2] = deal(0); % alustetaan muuttujat
	c = (P0*P0*P0)/192;     % skaalauskerroin    
	p = phi(T0,0.5,Fs);     % vaihesignaali
	y = zeros(1,Fs);        % ulostulotaulukko
    for n = 1:Fs            % prosessointi nayte kerrallaan
		s  = 2*p(n) - 1;    % triviaali saha
		s2 = s*s;			% toisen asteen paraboli
		s4 = s2*(s2 - 2);	% neljannen asteen paraboli
		y0 = s4 - z0;		% derivointi 1
		y1 = y0 - z1;		% derivointi 2
		y2 = y1 - z2;		% derivointi 3		
		y(n) = y2 * c;		% skaalaus
		z0 = s4;            % paivitetaan edelliset arvot
		z1 = y0;            %          derivointia varten
		z2 = y1;
    end
    y(1) = 0;   % asetetaan kolme ensimmaista naytetta nollaksi
    y(2) = 0;   %                 niihin syntyvan virheen takia
    y(3) = 0;
end