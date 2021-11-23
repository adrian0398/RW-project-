clc
clear variables

%Inercia referidas al eje de ref marco teorico
Isat= [0.0421379 0.0000186 -0.0000310;0.0000186 0.0421882 0.0000684; -0.0000310 0.0000684 0.0055279];
r1=[-34.7530 0.8246 0.1663]';
r2=[0.5598 -34.4882 0.1663]';
r3=[0.5598 0.8246 -35.4791]';
r4=[17.8839 18.1487 17.1578]';
G=[r1/norm(r1) r2/norm(r2) r3/norm(r3) r4/norm(r4)];


%Isat=[0.04215 0 0;0 0.04215 0; 0  0 0.04215];
%G=[1,0,0,1/sqrt(3);0,1,0,1/sqrt(3);0,0,1,1/sqrt(3)];

L=[0;-0.0001;0];
Iw=[0.000012 0 0;0 0.000007 0;0 0 0.000007];
inversaI=inv(Isat);

gradient=1270;
rpm= 6925.72;
OMEGA= rpm*(2*pi)/60;
torque=rpm/gradient * 10^(-3);
us=[0;torque;0;0];

h=0.005; % step's size
N=500; % number of steps
omega=[0;0;0];
omega_total=[];

omega_total=[omega_total omega];

t = linspace(0,N,N+1);
for n=1:N
    hs=[Iw(1,1)*(omega(1,1)+OMEGA);Iw(1,1)*(omega(1,1)+OMEGA) ;Iw(1,1)*(omega(1,1)+OMEGA) ;Iw(1,1)*(omega(1,1)+OMEGA)];
    omega_n= omega+h*inversaI*(-cross(omega,Isat*omega)-cross(omega,G*hs)-G*us +L);
    
    omega=omega_n;
    omega_total=[omega_total omega_n];
   
end

figure
plot(t,omega_total(2,:))
xlabel('pasos')
ylabel('velocidad angular (rad/s)')


figure
plot(t,omega_total(1,:))
xlabel('pasos')
ylabel('velocidad angular (rad/s)')


figure
plot(t,omega_total(3,:))
xlabel('pasos')
ylabel('velocidad angular (rad/s)')





