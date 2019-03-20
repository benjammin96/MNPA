clear all

G=zeros(8,8);
C=zeros(8,8);
F=zeros(8,1);
R1 = 1; 
R2=2;
R3=10;
R4=0.1;
R0=1000;
c=0.25;
L=0.2;
a = 100;

G(1,1)=1/R1;
G(1,2)=-1/R1;
G(2,1)=-1/R1;
G(2,2)=1/R1 +1/R2;
G(3,3)=1/R3;
G(4,4)=1/R4; 
G(4,5)=-1/R4;
G(5,4)=1/R4;
G(5,5)=1/R4 +1/R0;
G(6,1)=1;
G(7,2)=1;
G(7,3)=-1;
G(8,3)=-a/R3;
G(8,4)=1;
G(1,6)=1;
G(2,7)=1;
G(3,7)=-1;
G(4,8)=1;

C(1,1)=c;
C(1,2)=-c;
C(2,2)=c;
C(2,1)=-c;
C(7,7)=-L;

vin=linspace(-10,10,100);
V0=zeros(length(vin),1);
V3=zeros(length(vin),1);

for i=1:length(vin)
    F(6)=vin(i);
    V=G\F;
    V3(i)=V(3);
    V0(i)= V(5);
end 
figure(1)
plot(V3)
title('V3 over Time');
xlabel('Time')
ylabel('Voltage')
figure(2)
plot(V0)
title('V0 over Time');
xlabel('Time')
ylabel('Voltage')

f= linspace(0,50,1000);
V0 = zeros(length(f),1);
gain=zeros(length(f),1);
for i=1:length(f)
    S=1i*2*pi*f(i);
    V=inv((G+S.*C))*F;
    V0(i)=abs(V(5));
    gain(i) = 20*log10(abs(V(5))/abs(V(1)));
end 

figure(3)
plot(2*pi*f,V0);
xlabel('Frequency')
ylabel('V0')
title('Voltage vs Freq')

figure(4)
semilogx(2*pi*f, gain);
xlabel('Frequency')
ylabel('Gain(dB)')
title('Gain vs Freq');

V0=zeros(length(f),1);
gain=zeros(length(f),1);
for i=1:length(V0)
    p = randn()*0.05;
    C(1,1)=c*p;
    C(2,2)=c*p;
    C(1,2)=-c*p;
    C(2,1)=-c*p;
    s=2*pi;
    V=inv((G+S.*C))*F;
    V0(i)=abs(V(5));
    gain(i) = 20*log10(abs(V(5))/abs(V(1)));
end
figure;
hist(gain,80);
xlabel('Gain')
ylabel('Count')
title('Histogram of Gain')
