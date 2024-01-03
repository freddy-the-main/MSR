
clc;

%% Zusammenfügen von einzelnen Tabellen als Zeilenvektor
load Gruppe1_1_(Stellgröße-)Störgröße\Gruppe1_2_6.mat;
A1 = A;
B1 = B;
C1 = C;
load Gruppe1_1_(Stellgröße-)Störgröße\Gruppe1_2_7.mat;
A2 = A;
B2 = B;
C2 = C;

B = [B1;B2];
A = [A1;A2];
C = [C1;C2];
% seite1 = load 'grupeX\tabelle1\tabelle1_1.mat';
% seite2 = load 'grupeX\tabelle1\tabelle1_2.mat';
time = [Tinterval:Tinterval:length(B)*Tinterval];
%figure(3)
% clf
% hold on;
% legend show
%plot(time,C,'DisplayName',"Stoergroesse");
%plot(time,B,'DisplayName',"Regelgroesse");
%% Figur 2 für Standardisierung
%figure(4),clf
C=(C-C(1))/3; % Durch 3 Teilen, weil Sprung 3 entspricht
Sp=find(C>0.1,1); % Sprung ausfindig machen; Näherung mit größer 0,1
B=(B-B(1))/3;
% 
C=C(Sp:end); % Abschneiden der Funktion von Anfang bis Sprung
B=B(Sp:end);
time = [Tinterval:Tinterval:length(B)*Tinterval]; % Zeitintervall anpassen

% hold on
% legend show
% plot(time,C,'DisplayName',"Stoergroesse");
% plot(time,B,'DisplayName',"Regelgroesse");
KpZ=min(smoothdata(B,"gaussian",1000)) % Kennwert Kp
% plot([0,time(end)],[KpZ,KpZ],'DisplayName','KpZ') % Als Gerade ploten

x10Z=0.10*KpZ; % Kennwert x25 und anschließende Zeit ausfindig machen
t10Z=time(find(B<=x10Z,1));
% plot(t10Z,x10Z,'k*','MarkerSize',3,'DisplayName','t10Z')

x25Z=0.25*KpZ; % Kennwert x25 und anschließende Zeit ausfindig machen
t25Z=time(find(B<=x25Z,1));
%plot(t25Z,x25Z,'k*','MarkerSize',6,'DisplayName','t25Z')

x50Z=0.50*KpZ; % Kennwert x25 und anschließende Zeit ausfindig machen
t50Z=time(find(B<=x50Z,1));
% plot(t50Z,x50Z,'k*','MarkerSize',9,'DisplayName','t50Z')

x75Z=0.75*KpZ; % Kennwert x25 und anschließende Zeit ausfindig machen
t75Z=time(find(B<=x75Z,1));
% plot(t75Z,x75Z,'k*','MarkerSize',12,'DisplayName','t75Z')

x90Z=0.90*KpZ; % Kennwert x25 und anschließende Zeit ausfindig machen
t90Z=time(find(B<=x90Z,1));
% plot(t90Z,x90Z,'k*','MarkerSize',15,'DisplayName','t90Z')

stoergroessen.time = time;
stoergroessen.stoergroesse = C;
stoergroessen.regelgroesse = B;

tZ= time;
save('stoergroessensprung.mat','stoergroessen')

clear A A1 A2 B B1 B2 C C1 C2 D ExtraSamples Length RequestedLength Sp time Tinterval Tstart Version
clc



