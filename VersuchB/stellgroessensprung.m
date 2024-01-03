
clc;

%% Zusammenfügen von einzelnen Tabellen als Zeilenvektor
load 'Gruppe1-1_Stellgrößensprung\Gruppe1-1_Stellgrößensprung_1.mat';
A1 = A;
B1 = B;
C1 = C;
load 'Gruppe1-1_Stellgrößensprung\Gruppe1-1_Stellgrößensprung_2.mat';
A2 = A;
B2 = B;
C2 = C;
load 'Gruppe1-1_Stellgrößensprung\Gruppe1-1_Stellgrößensprung_3.mat';
A3 = A;
B3 = B;
C3 = C;
load 'Gruppe1-1_Stellgrößensprung\Gruppe1-1_Stellgrößensprung_4.mat';
A4 = A;
B4 = B;
C4 = C;

B = [B2;B3];
A = [A2;A3];
C = [C2;C3];

time = [Tinterval:Tinterval:length(B)*Tinterval]; %Zeitvektor bauen

figure(1)
clf
hold on;
legend show
plot(time,A,'DisplayName',"Stellgroesse");
plot(time,B,'DisplayName',"Regelgroesse"); %plotten von Regel und Stellgroesse

%% Figur 2 für Standardisierung

figure(2)
clf,legend show,grid on,hold on
A=(A-A(1))/2; % Durch 2 Teilen, weil Sprung 2 entspricht
Sp=find(A>0.1,1); % Sprung ausfindig machen; Näherung mit größer 0,1
B=(B-B(1))/2;

A=A(Sp:end); % Abschneiden der Funktion von Anfang bis Sprung
B=B(Sp:end);
time = [Tinterval:Tinterval:length(B)*Tinterval]; % Zeitintervall anpassen

stairs(time,A,'r','DisplayName',"Stellgroesse")
stairs(time,B,'y','DisplayName',"Regelgroesse")

KpY=max(smoothdata(B,"gaussian",1000)); % Kennwert Kp

yline(KpY,'b-','DisplayName','KpY') %KpY als gerade plotten

x10Y=0.10*KpY; % Kennwert x25 und anschließende Zeit ausfindig machen
t10Y=time(find(B>=x10Y,1));
plot(t10Y,x10Y,'k*','MarkerSize',3,'DisplayName','t10Y')

x25Y=0.25*KpY; % Kennwert x25 und anschließende Zeit ausfindig machen
t25Y=time(find(B>=x25Y,1));
plot(t25Y,x25Y,'k*','MarkerSize',6,'DisplayName','t25Y')

x50Y=0.50*KpY; % Kennwert x25 und anschließende Zeit ausfindig machen
t50Y=time(find(B>=x50Y,1));
plot(t50Y,x50Y,'k*','MarkerSize',9,'DisplayName','t50Y')

x75Y=0.75*KpY; % Kennwert x25 und anschließende Zeit ausfindig machen
t75Y=time(find(B>=x75Y,1));
plot(t75Y,x75Y,'k*','MarkerSize',12,'DisplayName','t75Y')

x90Y=0.90*KpY; % Kennwert x25 und anschließende Zeit ausfindig machen
t90Y=time(find(B>=x90Y,1));
plot(t90Y,x90Y,'k*','MarkerSize',15,'DisplayName','t90Y')

stellgroessen.time = time;    %struct erstellen zum übertragen ins Strejc script
stellgroessen.stellgroesse = A;
stellgroessen.regelgroesse = B;

tY = time;
save('stellgroessensprung.mat','stellgroessen') %struct speichern
%alle unnötigen variablen löschen
clear stellgroessen A A1 A2 A3 A4 B B1 B2 B3 B4 C C1 C2 C3 C4 D ExtraSamples Length RequestedLength Sp time Tinterval Tstart Version;

clc


