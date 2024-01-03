%% 4

sys = tf(1,1)+ tf(1,[0 40])+ tf([0 4],[1 0.8])

plot(step(sys))