clc;
clear all;
RL=200;
XL=-100;
ZL=complex(RL,XL);
FO=500*10^6;
ZO=100;

if (RL>ZO)
    B1=(XL+(sqrt(RL/ZO)*(sqrt(RL^2+XL^2-ZO*RL))))/(RL^2+XL^2)
    B2=(XL-(sqrt(RL/ZO)*(sqrt(RL^2+XL^2-ZO*RL))))/(RL^2+XL^2)
    X1=(1/B1)+((XL*ZO)/RL)-(ZO/(B1*RL))
    X2=(1/B2)+((XL*ZO)/RL)-(ZO/(B2*RL))
else
    B1=(sqrt((ZO-RL)/RL))/ZO
    B2=-(sqrt((ZO-RL)/RL))/ZO
    X1=sqrt(RL*(ZO-RL))-XL
    X2=-(sqrt(RL*(ZO-RL))-XL)
end
disp(B1,'B1=')
disp(B2,'B2=')
disp(X1,'X1=')
disp(X2,'X2=')

if  (B1<0 & X1<0)
    L1=-1/(2*%pi*FO*B1)
    C1=-1/(2*%pi*FO*X1)
    disp('B1 acts as an inductor')
    disp('X1 acts as a capacitor')
    disp('C1=')
    disp(C1)
    disp('L1=')
    disp(L1)
else
    C1=B1/(2*%pi*FO)
    L1=X1/(2*%pi*FO)
    disp('B1 acts as a capacitor')
    disp('X1 acts as an inductor')
    disp('C1=')
    disp(C1)
    disp('L1=')
    disp(L1)
end

if  (B2<0 & X2<0)
    L2=-1/(2*%pi*FO*B2)
    C2=-1/(2*%pi*FO*X2)
    disp('B2 acts as an inductor')
    disp('X2 acts as a capacitor')
    disp(C2,'C2=')
    disp(L2,'L2=')
else
    C2=B2/(2*%pi*FO)
    L2=X2/(2*%pi*FO)
    disp('B2 acts as a capacitor')
    disp('X2 acts as an inductor')
    disp(C2,'C2=')
    disp(L2,'L2=')
end

f=linspace(1*10^9,1*10^6,1001)
w=2*%pi*f
C=-1/(XL*2*%pi*FO)
disp(C,'C=')

Zin1=(((RL+(1 ./(%i*w*C))) .*(1 ./(%i*w*C1))) ./(RL+(1 ./(%i*w*C))+(1 ./(%i*w*C1))))+(%i*w*L1)
g1=(Zin1-ZO) ./(Zin1+ZO)
plot(f,abs(g1))

Zin2=(((RL+(1 ./(%i*w*C))) .*(%i*w*L2)) ./(RL+(1 ./(%i*w*C))+(%i*w*L2)))+(1 ./(%i*w*C2))
g2=(Zin2-ZO) ./(Zin2+ZO)
plot(f,abs(g2))
 
