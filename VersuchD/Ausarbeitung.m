clear
clc

addpath('Resourcen\VersuchB');
addpath('Resourcen\VersuchB\Gruppe1-1_Stellgrößensprung');
addpath('Resourcen\VersuchB\Gruppe1_1_(Stellgröße-)Störgröße');
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
KrTsum = 1/KpY;
TiTsum = 0.7*TsumRT;
TdTsum = 0.17*TsumRT;
KiTsum = KrTsum/TiTsum;
TaTsum = TdTsum/5;
KdTsum = TdTsum*KrTsum;

GpPIDTsum = KrTsum + tf(KiTsum,[1 TaTsum]) + tf([0 KdTsum],[1 TaTsum]);
disp(GpPIDTsum)
sys = step(GpPIDTsum*GpYPa,tY);




figure(11), hold on, grid on, legend show
plot(tY,TsumVecPos);
plot(tY,TsumVecNeg);
plot(tY,abs_diff);
figure(12), hold on, grid on, legend show
plot(tY,GpYPaRes);
plot(tY,sys);




