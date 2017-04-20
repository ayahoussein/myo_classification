function   groupe_donnees_patient( nom_experiment )

addpath([pwd filesep 'utilities_func']);
addpath([pwd filesep 'readers_func']);

% Make a list of patients' folders
cd(['..' filesep 'data']);
patientFolds = getFolderNames();

%Variable containing the number of subfolders (visit dates) for each patient
visits_n=zeros(length(patientFolds),1) ;

for patient = 1:(length(patientFolds))
    cd(patientFolds{patient});
    visitFolds = getFolderNames();
    visits_n(patient)=length(visitFolds);
    
    %Accessing each visit
    for visit = 1:length(visitFolds)
        cd(visitFolds{visit});
        
        % Accessing specified test
        if( exist(nom_experiment,'dir') )% If test folder exists
            cd(nom_experiment);
            trialFolds = getFolderNames();
            s=struct;  % structure pour chaque patient dont les ?lements sont les signaux emg de chaque essai et le label
            
            % Accessing all trials
            for trial = 1:length(trialFolds)
                cd(trialFolds{trial});
                [emg_sig_int, emg_time_int] = myo_emg_reader('emg.txt', false); %Second argument is true if interpolation to initial data is applied. For now, preferably set to 0. 
                
                s.emg_sig{trial}=emg_sig_int;
                s.emg_time{trial}=emg_time_int;
                cd .. 
            end
            
            cd ..
            % accessing label of patient, class.txt contain the label
            dir *.txt ;
            s.label=dlmread('class.txt'); 
            
             if patient==1
                eval([ 'patient_' num2str(visit) ' = s ;' ]); % renameles differents signaux emg
             else
                 eval([ 'patient_' num2str(visit+sum(visits_n(1:(patient-1)))) ' = s;' ]);
             end
             
     else
            cd ..
            continue 
        end
        
        cd ..
    end
    
    cd ..
end

cd ..
save('emg_global_finger','patient_*'); % sauvegarder les diff?rentes signaux emg et la varable du label dans un le fichier emg_global.mat

end










