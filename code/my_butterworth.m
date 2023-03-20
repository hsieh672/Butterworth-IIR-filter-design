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