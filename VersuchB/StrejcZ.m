load("stoergroessensprung.mat")

figure(6),clf
t = stoergroessen.time;
z = stoergroessen.stoergroesse;
y = stoergroessen.regelgroesse;
yF = smoothdata(y,'gaussian',5000);
hold on
plot(t,z,'b-','DisplayName','Stellgroesse'),legend show,grid on
plot(t,yF,'r-','DisplayName','RegelgroesseGefiltert')
plot(t,y,'y-','DisplayName','Regelgroesse')
KpZ = min(yF);
yline(KpZ);
ableitungZ = diff(yF)/0.002;
[steigungTZ ,IndexWendepunkt] = min(ableitungZ);
wendepunkt_t = t(IndexWendepunkt);
wendepunkt_y = y(IndexWendepunkt);
steigungTZ = ableitungZ(IndexWendepunkt);
bTangenteZ = wendepunkt_y-steigungTZ*wendepunkt_t;

tangenteZ = steigungTZ*t+bTangenteZ;


Te = t(find(tangenteZ < 0,1));
TePTb = t(find(tangenteZ < KpZ,1));
Tb = TePTb-Te;

T1pT2 = TePTb-wendepunkt_t;





plot(t,tangenteZ,'g-','DisplayName','Wendetangente')
plot(wendepunkt_t,wendepunkt_y,'k*','MarkerSize',10,'DisplayName','Wendepunkt')
plot(Te,0,'k*','MarkerSize',5,'DisplayName','Te')
plot(TePTb,KpZ,'k*','MarkerSize',5,'DisplayName','Te + Tb')
plot(t(2:end),ableitungZ,'DisplayName','AbleitungZ');




%% Rechnung
for c = 0.5:0.1:1

    T1 = T1pT2*c;
    T2 = T1pT2*(1-c);

    [T1 T2];

Le = tf([KpZ],[T1 1]);
Ri = tf([1],[T2 1]);

GpZStr = Le*Ri;
GpZStrRes = step(GpZStr,t);
plot(t,GpZStrRes,'-','DisplayName',"[T1 ="+T1+"; T2="+T2+"]" )

end

T1 = 21.4704;
T2 = 2.3865;

Le = tf([KpZ],[T1 1]);

Ri = tf([1],[T2 1]);

GpZStrFinal = Le*Ri;

GpZStrFinalRes = step(GpZStrFinal,t); %Sprungantwort
plot(t,GpZStrFinalRes,'-','DisplayName',"[T1 ="+T1+"; T2="+T2+"] Final" )



