clc
clear all
Rl=input("enter the real part of Zl ")
Xl=input("enter the imaginary part of Zl ")
Zl=complex(Rl,Xl)
disp(Zl)
f0=input("enter the frequency: ")
disp(f0,'f0')
Z0=input("enter characteristic impedance ")
disp(Z0,'Z0')
Y0=1/Z0
disp(Y0,'Y0')
if Rl==Z0 
    t1=-Xl/(2*Z0)
    t2=t1
else 
    t1=((Xl+(sqrt(Rl*(((Z0-Rl)^2)+(Xl^2))/Z0)))/(Rl-Z0))
    t2=((Xl-(sqrt(Rl*(((Z0-Rl)^2)+(Xl^2))/Z0)))/(Rl-Z0))
end
disp(t1,'t1')
disp(t2,'t2')

if t1>=0 
    d1=(1/(2*%pi))*(atan(t1))
else
    d1=(1/(2*%pi))*(%pi+atan(t1))
end
disp(d1,'d1')

if t2>=0 
    d2=(1/(2*%pi))*(atan(t2))
else
    d2=(1/(2*%pi))*(%pi+atan(t2))
end
disp(d2,'d2')

B1=(((Rl^2)*t1)-((Z0-(Xl*t1))*(Xl+(Z0*t1))))/(Z0*((Rl^2)+((Xl+(Z0*t1))^2)))
B2=(((Rl^2)*t2)-((Z0-(Xl*t2))*(Xl+(Z0*t2))))/(Z0*((Rl^2)+((Xl+(Z0*t2))^2)))
disp(B1,'B1')
disp(B2,'B2')

BS1=-B1
BS2=-B2

disp(BS1,'BS1')
disp(BS2,'BS2')

a = input("Enter 1 for Open Circuit and 2 for Short Circuit: ")
if a==1
   disp('for open ckt')
   l1=(1/(2*%pi))*(atan(BS1/Y0))
   if l1< 0
     l1=l1+0.5
   end
   l2=((1/(2*%pi))*(atan(BS2/Y0)))
   if l2 < 0
    l2=l2+0.5
   end
disp(l1,'l1')
disp(l2,'l2')
else
   disp('for short ckt')
   l1=(-1/(2*%pi))*(atan(Y0/BS1))
   if l1< 0
    l1=l1+0.5
   end
  l2=(-1/(2*%pi))*(atan(Y0/BS2))
  if l2 < 0
    l2=l2+0.5
  end
disp(l1,'l1')
disp(l2,'l2')
end

f=linspace(1*10^9,3*10^9,1000)
Bd1=((2*%pi*f*d1)*(1/f0))
Bd2=((2*%pi*f*d2)*(1/f0))
z01=Z0*tan(Bd1)
z02=Z0*tan(Bd2)
zl1=Zl*tan(Bd1)
zl2=Zl*tan(Bd2)
Zin1=(Z0)*((Zl+imult(z01))./(Z0+imult(zl1)))
Zin2=(Z0)*((Zl+imult(z02))./(Z0+imult(zl2)))
bls1=(2*%pi*f*l1)*(1/f0);
bls2=(2*%pi*f*l2)*(1/f0);
if a==1
  Zoc1 = -imult(Z0.*cotg(bls1))
  Zoc2 = -imult(Z0.*cotg(bls2))
  zp1=((1 ./Zin1)+(1 ./Zoc1)).^-1;
  zp2=((1 ./Zin2)+(1 ./Zoc2)).^-1;
else
  Zsc1=imult(Z0*tan(bls1));
  Zsc2=imult(Z0*tan(bls2));
  zp1=((1 ./Zin1)+(1 ./Zsc1)).^-1;
  zp2=((1 ./Zin2)+(1 ./Zsc2)).^-1;
end
gamin1=(zp1-Z0)./(zp1+Z0);
gamin1=abs(gamin1)
gamin2=(zp2-Z0)./(zp2+Z0);
gamin2=abs(gamin2)
plot(f,gamin1)
plot(f,gamin2)
xlabel("Frequency")
ylabel("Magnitude of Reflection Coefficient");
