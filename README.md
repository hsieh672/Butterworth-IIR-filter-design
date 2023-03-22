# Butterworth-IIR-filter-design
Design an IIR lowpass filter with the following parameters:  
1. 3-dB frequency at	omega_c = 0.2*pi  
2. edge of stopband	at omega_s = 0.24*pi  
# Returns	DEN	and	NUM	automatically	for	any	given	order	N
I used “my_filter” function to return the results of the filter automatically when I changed the parameter N in the main code
'''sh
    function [H,f] = my_filter(N,Omega_c,Td)

    angle = pi/2 + (0.5:1:N-0.5)*pi/N;
    s_p = Omega_c * exp(j*angle); % pole locations on s plane 

    z_p = (1+(Td/2)*s_p)./(1-(Td/2)*s_p);

    DEN = poly(z_p); % Denominator A(z)

    z_zero = -1*ones(1,N);
    NUM = poly(z_zero); % Numerator B(z)

    DCgain = 2^N/sum(DEN); % B(z)/A(z) evaluated at z = 1, i.e. @ omega = 0.
    NUM = NUM/ DCgain; % normalisation of DC gain to become unity

    [H,f] = freqz(NUM, DEN, 1024);

    end
'''
