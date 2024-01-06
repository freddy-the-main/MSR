clear
clc
clf

addpath('Resourcen\VersuchB');
addpath('Resourcen\VersuchB\Gruppe1-1_Stellgrößensprung');
addpath('Resourcen\VersuchB\Gruppe1_1_(Stellgröße-)Störgröße');
addpath('Resourcen\VersuchB\StrejcY.m')

Auswertung

%% Tsumme

TsumVecPos = numel(GpYPaRes);
TsumVecNeg = numel(GpYPaRes);
SumPos = 0;
SumNeg = 0;
Tsum = 0;
TsumRT = 0;

for i = 1:1:numel(GpYPaRes)

    SumPos = SumPos + GpYPaRes(i);
    SumNeg = SumNeg + (KpY - GpYPaRes(numel(GpYPaRes) - i+1));

    TsumVecPos(i) = SumPos;
    TsumVecNeg(numel(GpYPaRes) - i+1) = SumNeg;

end

abs_diff = abs(TsumVecPos - TsumVecNeg);

[min_diff, min_index] = min(abs_diff);
Tsum = min_index;
TsumRT = Tsum*TintervalY

% PID Parameter:
KrTsum = 1/KpY
TiTsum = 0.7*TsumRT
TdTsum = 0.17*TsumRT
KiTsum = KrTsum/TiTsum
TaTsum = TdTsum/5
KdTsum = TdTsum*KrTsum

GpPIDTsum = KrTsum + tf(KiTsum,[1 0]) + tf([KdTsum 0],[TaTsum 1]);
GpPIDTsum

sys = step(GpPIDTsum,tY);




figure(11), hold on, grid on, legend show
plot(tY,TsumVecPos);
plot(tY,TsumVecNeg);
plot(tY,abs_diff);
figure(12), hold on, grid on, legend show
plot(tY,GpYPaRes);
plot(tY,sys);


%% Latzel n = 3

%aus der Tabelle
TiT = 2.47;
TdT = 0.66;
KpKr = 2.543;

TiL = 2.47 * tYSwa
TdL = 0.66 * tYSwa

KrL = KpKr/KpY

GpPIDLa = KrL + tf(KrL,[TiL 0]) + tf([KrL*TdL 0],[TdL/5 1]);
GpPIDLa
sys = step(GpPIDLa,tY);
plot(tY,sys);

%% Strejc

k = (str.T1+str.T2-str.Te)/str.Te

KrStr = 1/KpY + (k^2+1)/2*k 
TiStr = (((k^2+1)*(k+1))/(k^2+k+1))*str.Te

GpPIDStr = tf([KrStr KrStr/TiStr],[1 0])

sys = step(GpPIDStr,tY);
plot(tY,sys);

%% Kompensationsregler

%

%handschriftlich bestimmt
GpPIKom = tf([1.647 0.237 7.28e-3],[0.689 0.0307 0])

sys = step(GpPIKom,tY);
KrKom = sys(1)
TiKom = sys(500)/sys(1) 

plot(tY,step(GpPIKom,tY))



%% 8.

stepVec = 6 * ones(1,length(tY));
stepVec(1) = 4;

% Tsum


startValue = 4;
endValue = 6;
stepSize = endValue - startValue;

% Scale the step input from startValue to endValue
scaledStep = stepSize * (stepfun(tY, startValue) - stepfun(tY, endValue));


figure(13), hold on, grid on, legend show
plot(tY,step(GpYSwa*GpPIDTsum,tY));












