function   groupe_donnees_patient( nom_experiment )

addpath([pwd filesep 'utilities_func']);
addpath([pwd filesep 'readers_func']);

% Make a list of patients' folders
cd(['..' filesep 'data']);

%accessing each groupe of patients ( patient normal & patient sclerose)
statusFolds=getFolderNames();

% variable containing the number of patients in each group
patient_n=zeros(length(statusFolds),1);

for status=1:length(statusFolds)
    cd(statusFolds{status});

% accessing each patient in each groupe
patientFolds = getFolderNames();
patient_n(status)=length(patientFolds);

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
                s.label=status;
                cd ..                
            end
            
             if status==1
                eval([ 'patient_' num2str(patient) ' = s ;' ]); % renameles diff?rents signaux emg
            else
                eval([ 'patient_' num2str(patient+sum(patient_n(1:(status-1)))) ' = s;' ]);
             end
             
        else
            continue 
        end
        
        cd ..
    end
    
    cd ..\..
end

cd ..
   
end

save('emg_global_foot','patient_*'); % sauvegarder les diff?rentes signaux emg et la varable du label dans un le fichier emg_global.mat

end








