function [Frq,phi]=FDD(Input,Fs)
close all
Acc=xlsread("FDD_UCC_G_floor.xlsx");
display('FDD is in progress, please wait ...')
% -------------------------------------------------------------------------
% Compute Power Spectral Density (PSD) matrix.
% CPSD function, with default settings, is used to compute the cross power
% spectral density matrix. More sophisticated methods can also be
% applied for more accuracy.
for I=1:size(Acc,2)
    for J=1:size(Acc,2)
        [PSD(I,J,:),F(I,J,:)]=cpsd(Acc(:,I),Acc(:,J),[],[],[],150.015);
    end
end
Frequencies(:,1)=F(1,1,:); 

[Frq,phi,Fp,s1] = Identifier(PSD,Frequencies);
% Save results
save('IdResults.mat','phi','Fp','s1','Frequencies')
% -------------------------------------------------------------------------
% Print results
display('-----------------------------------------------------')
display('               Identification Results                ')
display('-----------------------------------------------------')
% Print frequencies
display('Identified frequencies')
for I=1:size(Frq,1)
    fprintf('Mode: %d; Modal Frequency: %6.4g (Hz)\n',I,Frq(I))
end
% Print Mode shapes
display('Related mode shapes')
for I=1:size(Frq,1)
    fprintf('Mode shape # %d:\n\n',I)
    disp(phi(:,I))
end
end

function [Frq,phi,Fp,s1] = Identifier(PSD,F)
% Compute SVD of the PSD at each frequency
for I=1:size(PSD,3)
    [u,s,~] = svd(PSD(:,:,I));
    s1(I) = s(1);                                                          % First eigen values
    s2(I) = s(2,2);                                                        % Second eigen values
    ms(:,I)=u(:,1);                                                        % Mode shape
end
% Plot first singular values of the PSD matrix
figure
hold on
plot(F,mag2db(s1), color = 'blue')
xlabel('Frequency (Hz)')
ylabel('1st Singular values of the PSD matrix (db)')
end