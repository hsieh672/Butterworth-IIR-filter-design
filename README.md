# Butterworth-IIR-filter-design
Design an IIR lowpass filter with the following parameters:  
1. 3-dB frequency at	omega_c = 0.2*pi  
2. edge of stopband	at omega_s = 0.24*pi  
# Returns	DEN	and	NUM	automatically	for	any	given	order	N
I used “my_filter” function to return the results of the filter automatically when I changed the parameter N in the main code
```sh
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
```
### 1. When omega_c = [0,pi]
![N](https://github.com/hsieh672/Butterworth-IIR-filter-design/blob/main/imag/N.png)
### 2. When omega_c = 0.2*pi
![4_to_20](https://github.com/hsieh672/Butterworth-IIR-filter-design/blob/main/imag/4_to_20.png)

# Modify a function	to return the appropriate order N automatically	by the given omega_c
I used “my_butterworth” function to find N and then used “my_filter” function to get the results of the filter automatically

```sh
function [N,Omega_c,Td] = my_butterworth(wp,ws,stop_band)
    A = 1/stop_band;
    N = ceil(log10((A^2 -1)) / (2*log10(wp)));
    Omega_c = wp;

    Td = 2/Omega_c * tan(Omega_c/2);
    found = 0;

    while found~=1
        N = N + 1;    
        found = 1/(1+ (2/Td*tan(ws/2)/Omega_c)^(2*N)) < (stop_band)^2;
    end

end
```

![tolerance](https://github.com/hsieh672/Butterworth-IIR-filter-design/blob/main/imag/tolerance.png)

|              | FIR                    | IIR                                                   |
|--------------|------------------------|-------------------------------------------------------|
| Advantage    | Linear  phase  Stability  | Low implementation cost Low latency Analog equivalent |
| Disadvantage |                        |                                                       |
