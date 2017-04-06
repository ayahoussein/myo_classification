function   groupe_donnees_patient( nom_experiment )
%addpath('C:\Users\Mhmd\Desktop\New folder')%path to said fonction

%save emg_sig_int in the global_emg.mat
cd '..\data'
d=dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

l=zeros(length(nameFolds),1) ;   %variable pour sauvegarder  length du chaque subfolders(patient_normal and patient_sclerose)

%acc�s aux Folders (patient_normal and patient_sclerose)
for i=1:(length(nameFolds))
cd(nameFolds{i})
    d=dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds1 = {d(isub).name}';
nameFolds1(ismember(nameFolds1,{'.','..'})) = [];
l(i)=length(nameFolds1);



%acc�s � chaque signal emg du patient_normal aand patient_sclerose
for j=1:length(nameFolds1)
    cd(nameFolds1{j})
   
  % recuperer les donn�es selon le nom d'experiment
   if( exist(nom_experiment,'dir')==7)  % si l'experiment exist
    switch nom_experiment
        case  'Finger tap'
            
            cd 'Finger tap'
        case 'Foot tap'
            cd 'Foot tap'
        case '25 footsteps'
            cd '25 footsteps'
    end
    d=dir;
isub = [d(:).isdir]; %# returns logical vector
nameFolds2 = {d(isub).name}';
nameFolds2(ismember(nameFolds2,{'.','..'})) = [];
s=struct;  % structure pour chaque patient dont les �lements sont les signaux emg de chaque essai et le label

% acc�s � chaque essai pour chaque patient 

for k=1:length(nameFolds2)
    cd(nameFolds2{k})
     EMG = dlmread('emg.txt');
emg_time_orig = EMG(:,1);
emg_sig_orig = EMG(:,2:9);
emg_time_orig = (emg_time_orig-emg_time_orig(1))/10^3; %From us to ms
[emg_time_int, emg_sig_int] = said_function(emg_time_orig, emg_sig_orig, 5);

s.emg_sig{k}=emg_sig_int; % premier element (diff�rents signaux emg) du structure patient 
s.emg_time{k}=emg_time_int;

s.label=i; % deuxi�me �l�ment du structure patient( le label)

cd .. 

end

if i==1
eval([ 'patient_' num2str(j) ' = s ;' ]);% renameles diff�rents signaux emg
else 
    eval([ 'patient_' num2str(j+l(i-1)) ' = s;' ]);
end

cd ..\.. % acc�s � une autre donn�e emg du meme folder ( ex. patient_normal)

   else 
       cd .. 

   end
end
cd ..  % acc�s au deuxi�me folder ( ex. patient_sclerose)
end

save('emg_global','patient_*'); % sauvegarder les diff�rentes signaux emg et la varable du label dans un le fichier emg_global.mat



end




