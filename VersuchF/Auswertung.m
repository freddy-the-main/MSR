clear 
clc
clf

%% Messung A

load 'Messwerte\Gruppe1-1 PIDa.mat';

time = [Tinterval:Tinterval:length(A)*Tinterval];

Aa = A(1/Tinterval:end-60/Tinterval);
timea = [Tinterval:Tinterval:length(Aa)*Tinterval];

%% Messung B

load 'Messwerte\Gruppe1-1 PIDb.mat';

time = [Tinterval:Tinterval:length(A)*Tinterval];

Ab = A(40/Tinterval:end-100/Tinterval);

timeb = [Tinterval:Tinterval:length(Ab)*Tinterval];

Tintervalb = Tinterval; %Tinterval ist bei dieser Messung irgendwie anders. 

%% Messung C

load 'Messwerte\Gruppe1-1 PIDc.mat';

time = [Tinterval:Tinterval:length(A)*Tinterval];

Ac = A(1/Tinterval:40/Tinterval);
timec = [Tinterval:Tinterval:length(Ac)*Tinterval];

%% Messung D

load 'Messwerte\Gruppe1-1 PIDd.mat';

time = [Tinterval:Tinterval:length(A)*Tinterval];

Ad = A(1/Tinterval:40/Tinterval);
timed = [Tinterval:Tinterval:length(Ad)*Tinterval];

%% Aufgabe 1

AdMax = max(Ad);  % Zur Bestimmung von Ta benutzen wir hier die 63% methode. 
AdMaxT = find(Ad == AdMax,1); % Zeitpunkt (Arrayindex) an dem Ad maximal ist
AdMaxTRt = AdMaxT*Tinterval; % Arrayindex in echten Zeitpunkt umgerechnet

AdI = Ad(AdMaxTRt : end); % damit die suche nach dem wert von AdMax*0.63 nur ein ergebniss liefert wird es vorne abgeschnitten 

[~, index] = min(abs(AdI - (AdMax-1)*0.63)); %Index des nächsten wertes an AdMax*0.63 finden
Ad63 = AdI(index); %Wert vom Index speichern
Ad63T = find(Ad == Ad63 ,1); % Zeitpunkt (Arrayindex) an dem Ad maximal ist
Ad63TRt = Ad63T*Tinterval; % Arrayindex in echten Zeitpunkt umgerechnet

Tad = Ad63TRt - AdMaxTRt % Ta berechnen und in die Konsole Ausgeben
Tdd = Tad * 5 % mit 5 multiplizieren für Td und dieses dann ausgeben

AdSm= smoothdata(Ad,'gaussian',5000);
DrvtAd = diff(AdSm)/Tinterval; % Ableitung von Ad bilden

DrvtAd(end+1) = DrvtAd(end); % Eine Stelle dazu geben damit die Vektoren wieder die selbe Länge haben

Kid = mean(DrvtAd(25/Tinterval:35/Tinterval)) % Kid bestimmen und ausgeben

KrdYs = (AdSm(25/0.001)-Kid*25); % Die Tangente am ende von Ad bilden (das ist der Y-Achsenschnitt)

KrdG = Kid * timed + KrdYs; % Geradengleichung der Tangente Aufstellen

Krd = KrdG(AdMaxT)-1 % Krd bestimmen und ausgeben (Y0 muss abgezogen werden)

Krdplt = KrdG(AdMaxT); % Für das Plotten darf Y0 nicht abgezogen werden

figure(1)
hold on;
plot(timed,AdSm)
plot(timed,DrvtAd)

%% Aufagbe 2


AbMax = max(Ab);  % Selbe wie bei Aufgabe 1 nur das hier kein Kr und Ki bestimmt werden muss
AbMaxT = find(Ab == AbMax,1);
AbMaxTRt = AbMaxT*Tintervalb;

AbI = Ab(AbMaxTRt : end);

[~, index] = min(abs(AbI - (AbMax-1)*0.63));
Ab63 = AbI(index);
Ab63T = find(Ab == Ab63 ,1);
Ab63TRt = Ab63T*Tintervalb;

Tab = Ab63TRt - AbMaxTRt
Tdb = Tab * 5


%% Subplot

figure(99);
hold on;

subplot(2,2,1);
plot(timea, Aa);
title('Ti = unendl., Td = 0')

subplot(2,2,2);
plot(timeb, Ab);
title('Ti = unendl., Td = 4')

hold on;

subplot(2,2,2)
plot(AbMaxTRt,AbMax,'k*','MarkerSize',12,'DisplayName','Max')

subplot(2,2,2)
plot(Ab63TRt,Ab63,'k*','MarkerSize',12,'DisplayName','Max')


subplot(2,2,3)
plot(timec, Ac);
title('Ti = 0.025, Td = 0')

subplot(2,2,4)
hold on;

plot(timed, Ad);
title('Ti = 0.025, Td = 4')

subplot(2,2,4)
plot(AdMaxTRt,AdMax,'k*','MarkerSize',12,'DisplayName','Max')

subplot(2,2,4)
plot(Ad63TRt,Ad63,'k*','MarkerSize',12,'DisplayName','Max')

subplot(2,2,4)
plot(AdMaxTRt,Krdplt,'k*','MarkerSize',12,'DisplayName','Max')


subplot(2,2,4)
plot(timed,KrdG)


