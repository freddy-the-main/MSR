load("stellgroessensprung.mat")

figure(5),clf,legend show,grid on,hold on

t = stellgroessen.time;
x = stellgroessen.stellgroesse;
y = stellgroessen.regelgroesse;
yF = smoothdata(y,'gaussian',5000);

plot(t,x,'b-','DisplayName','Stellgroesse')
plot(t,yF,'r-','DisplayName','RegelgroesseGefiltert')
plot(t,y,'y-','DisplayName','Regelgroesse')

KpY = max(yF);
yline(KpY);

ableitungY = diff(yF)/0.002; %Ableitung bilden für wendepunkt
[steigungTY ,IndexWendepunkt] = max(ableitungY); %max der ableitung ist Wendepunkt X
wendepunkt_t = t(IndexWendepunkt);
wendepunkt_y = y(IndexWendepunkt);
steigungTY = ableitungY(IndexWendepunkt); % Hoehe der Ableitung am Wendepunkt X entspricht Wendetangentesteigung  
bTangenteY = wendepunkt_y-steigungTY*wendepunkt_t; % Y-achsenschnitt der Tangente

tangenteY = steigungTY*t+bTangenteY; % Geradengleichung der Tangente


Te = t(find(tangenteY > 0,01));
TePTb = t(find(tangenteY > KpY,1));
Tb = TePTb-Te;

T1pT2 = TePTb-wendepunkt_t;

plot(t,tangenteY,'g-','DisplayName','Wendetangente')
plot(wendepunkt_t,wendepunkt_y,'k*','MarkerSize',10,'DisplayName','Wendepunkt')
plot(Te,0,'k*','MarkerSize',5,'DisplayName','Te')
plot(TePTb,KpY,'k*','MarkerSize',5,'DisplayName','Te + Tb')
plot(t(2:end),ableitungY,'DisplayName','AbleitungY');


%% Rechnung
for c = 0.5:0.1:1 %Uebertragungsfunktionen für jedes verhältnis aus T1 und T2 

    T1 = T1pT2*c;
    T2 = T1pT2*(1-c);

    [T1 T2];

Le = tf([KpY],[T1 1]); %linker Teil der Uebertragungsfunktion
Ri = tf([1],[T2 1]); %rechter Teil der Uebertragungsfunktion

GpYStr = Le*Ri; %zusammensetzen
GpYStrRes = step(GpYStr,t); %Sprungantwort
plot(t,GpYStrRes,'-','DisplayName',"[T1 ="+T1+"; T2="+T2+"]" )

end


T1 = T1pT2/2;
T2 = T1pT2-T1;

Le = tf([KpY],[T1 1]);

Ri = tf([1],[T2 1]);

GpYStrFinal = Le*Ri;

GpYStrFinalRes = step(GpYStrFinal,t); %Sprungantwort
plot(t,GpYStrFinalRes,'-','DisplayName',"[T1 ="+T1+"; T2="+T2+"] Final" )



