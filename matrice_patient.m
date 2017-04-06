 patient_list={'1','2','3','4','5','6','7','8','9','10','11','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28'};
fband=[10 30 60 90];
fs=200;
thresh=0.002;
nb_segment=22;
long_segment=60;
nb_overlap=30;
gamma=0.1;
Mat_descrp=zeros(length(patient_list),208);
for ll=1:length(patient_list)
    patient_idx=patient_list{ll};
    v=eval(['patient_' patient_idx '.emg_sig']);
    nb_essai=length(v);
    
    fmed=zeros(nb_essai,24);
    dispr=zeros(nb_essai,24);
    energie=zeros(nb_essai,24);
    Mean_freq=zeros(nb_essai,24);
    ZC=zeros(8,nb_essai);
    WL=zeros(8,nb_essai);
    SSC=zeros(8,nb_essai);
    MAV=zeros(8,nb_essai);
    RMS=zeros(8,nb_essai);
    IEMG=zeros(8,nb_essai);
    VAR=zeros(8,nb_essai);
    WA=zeros(8,nb_essai);
    F1=zeros(8,nb_essai);
    F2=zeros(8,nb_essai);
    F3=zeros(8,nb_essai);
    F4=zeros(8,nb_essai);
    F5=zeros(8,nb_essai);
    F6=zeros(8,nb_essai);
    
    
    for j=1:nb_essai
        fm=Median_frequency_band(v{1,j},fband,fs);
        fmed(j,1:24)=reshape(fm',1,24);
       
        
        disp=dispersion_band(v{1,j},fband,fs);
        dispr(j,1:24)=reshape(disp',1,24);
        En=energie_band(v{1,j},fband,fs);
        energie(j,1:24)=reshape(En',1,24);
        Mfreq=mean_frequency_band(v{1,j},fband,fs);
        Mean_freq(j,1:24)=reshape(Mfreq',1,24);
        ZC(1:8,j)=mean(zero_crossing_wind(v{1,j},thresh,nb_segment,long_segment,nb_overlap),2);
        WL(1:8,j)=mean(waveform_length_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        SSC(1:8,j)=mean(slope_sign_change_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        MAV(1:8,j)=mean(mean_abs_value_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        RMS(1:8,j)=mean(root_mean_square_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        IEMG(1:8,j)=mean(integrated_emg_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        VAR(1:8,j)=mean(variance_wind(v{1,j},nb_segment,long_segment,nb_overlap),2);
        WA(1:8,j)=mean(Wilson_Amplitude_wind(v{1,j},thresh,nb_segment,long_segment,nb_overlap),2);
        F1(1:8,j)=mean(time_power_spectrum_1_band( v{1,j}, nb_segment,long_segment,nb_overlap,gamma),2);
        F2(1:8,j)=mean(time_power_spectrum_2_band( v{1,j}, nb_segment,long_segment,nb_overlap,gamma),2);
        F3(1:8,j)=mean(time_power_spectrum_3_band( v{1,j}, nb_segment,long_segment,nb_overlap,gamma),2);
        F4(1:8,j)=mean(time_power_spectrum_4_band( v{1,j}, nb_segment,long_segment,nb_overlap,gamma),2);
        F5(1:8,j)=mean(time_power_spectrum_5_band( v{1,j}, nb_segment,long_segment,nb_overlap,gamma),2);
        F6(1:8,j)=mean(time_power_spectrum_6_band( v{1,j}, nb_segment,long_segment,nb_overlap),2);
    end
    fmed_mean=mean(fmed,1);
    dispr_mean=mean(dispr,1);
    energie_mean=mean(energie,1);
    Mean_freq_mean=mean(Mean_freq,1);
    ZC_mean=mean(ZC,2);
    WL_mean=mean(WL,2);
    SSC_mean=mean(SSC,2);
    MAV_mean=mean(MAV,2);
    RMS_mean=mean(RMS,2);
    IEMG_mean=mean(IEMG,2);
    VAR_mean=mean(VAR,2);
    WA_mean=mean(WA,2);
    F1_mean=mean(F1,2);
    F2_mean=mean(F2,2);
    F3_mean=mean(F3,2);
    F4_mean=mean(F4,2);
    F5_mean=mean(F5,2);
    F6_mean=mean(F6,2);
    
    Mat_descrp(ll,:)=[fmed_mean dispr_mean energie_mean  Mean_freq_mean ZC_mean' WL_mean' SSC_mean' MAV_mean'  RMS_mean' IEMG_mean'  VAR_mean' WA_mean' F1_mean' F2_mean' F3_mean'  F4_mean'  F5_mean'  F6_mean']; 
    
        
end
%pca
[coeff,score]=pca(Mat_descrp);
figure(5);
subplot(2,2,1)
plot(score(:,1), score(:,2),'+');
subplot(2,2,2);
plot(score(:,1), score(:,3), '+');
subplot(2,2,3);
plot(score(:,2),score(:,3),'+');
%kmeans
[IDX1,c1]=kmeans(score(:,1:3),2);
figure(6);
plot(IDX1,'ro');
figure(7);
subplot(2,2,1);
plot(score(IDX1==1,1),score(IDX1==1,2),'bo');
hold on 
plot(score(IDX1==2,1),score(IDX1==2,2),'ro');
subplot(2,2,2);
plot(score(IDX1==1,1),score(IDX1==1,3),'bo');
hold on 
plot(score(IDX1==2,1),score(IDX1==2,3),'ro');
subplot(2,2,3);
plot(score(IDX1==1,2),score(IDX1==1,3),'bo');
hold on 
plot(score(IDX1==2,2),score(IDX1==2,3),'ro');