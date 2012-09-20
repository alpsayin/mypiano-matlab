function mypiano(n)
fs = 8192;
t = 0:1/fs:0.25;
base = 440;
note = 440/12;

c1 = 2*cos(2*pi*base*t).*exp(-t*10);
c2 = 0.5*sin(2*pi*base*t);

x = c1 + c2;

% sound(x)
% plot(x)

ft = fft(x, 2^nextpow2(fs));

firsthalf = ft(1:end/2);
secondhalf = ft(end/2+1:end);

firsthalf2 = firsthalf(1:end-round(note*n));
firsthalf2 = [zeros(1,length(firsthalf)-length(firsthalf2)) firsthalf2];


secondhalf2 = secondhalf(round(note*n)+1:end);
secondhalf2 = [secondhalf2 zeros(1,length(secondhalf)-length(secondhalf2))];

sft = [firsthalf2 secondhalf2];
sft(1) = ft(1);

% subplot(2,1,1)
% stem(ft)
% subplot(2,1,2)
% stem(sft)

y = ifft(sft, 2^nextpow2(fs));

% for k=0:12
%     y(k+1,:) = x.*cos(2*pi*note*k*t);
% end

% figure
% plot(abs(y))

sound(real(y))

