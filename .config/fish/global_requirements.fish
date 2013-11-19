function __vfext_global_requirements --on-event virtualenv_did_create
    if test -f $VIRTUALFISH_HOME/global_requirements.txt
        pip install -r $VIRTUALFISH_HOME/global_requirements.txt
    end
end

function __vf_requirements --description "Edit the global requirements file for all virtualenvs"
    eval $EDITOR $VIRTUALFISH_HOME/global_requirements.txt
    pushd $VIRTUALFISH_HOME
    for i in */bin/pip
        eval $i install -r $VIRTUALFISH_HOME/global_requirements.txt
    end
end
