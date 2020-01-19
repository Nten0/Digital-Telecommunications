Lb = 100002;
input = randsrc(Lb,1,[0 1]);

figure (1) %BER
gray=0;
M=4;
mainB;
SNR=0:2:20;
semilogy(SNR,BER,'bo-'); xlabel('SNR'); ylabel('BER');
clearvars -except input;

gray=1;
M=8;
mainB;
SNR=0:2:20;
hold on
semilogy(SNR,BER,'r^-'); xlabel('SNR'); ylabel('BER');
hold off
legend('4PAM','8PAM-Gray');
clearvars -except input;

figure (2) %SER
gray=0;
M=4;
mainB;
SNR=0:2:20;
semilogy(SNR,SER,'go-'); xlabel('SNR'); ylabel('SER');
clearvars -except input;

gray=0;
M=8;
mainB;
SNR=0:2:20;
hold on
semilogy(SNR,SER,'m^-'); xlabel('SNR'); ylabel('SER');
hold off
legend('4PAM','8PAM');
clearvars -except input;