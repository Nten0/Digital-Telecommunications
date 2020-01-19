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
M=4;
mainB;
SNR=0:2:20;
hold on
semilogy(SNR,BER,'ro-'); xlabel('SNR'); ylabel('BER');
hold off
clearvars -except input;

gray=0;
M=8;
mainB;
SNR=0:2:20;
hold on
semilogy(SNR,BER,'b^-'); xlabel('SNR'); ylabel('BER');
hold off
clearvars -except input;

gray=1;
M=8;
mainB;
SNR=0:2:20;
hold on
semilogy(SNR,BER,'r^-'); xlabel('SNR'); ylabel('BER');
hold off
legend('4PAM','4PAM-Gray','8PAM','8PAM-Gray');
clearvars -except input;
