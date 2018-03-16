function s = phi(T0,p0,Fs)
% vaihesignaali p(n)
% http://research.spa.aalto.fi/publications/papers/spl-ptr/
	s = zeros(1,Fs); p = p0;
    for n = 1:Fs
		s(n) = p;
		p = p + T0;
        if p > 1
            p = p - 1;
        end
    end
end