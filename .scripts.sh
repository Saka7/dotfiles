#!/usr/bin/zsh

# Jira
function jral {
    jira issue list -q "sprint in openSprints() AND assignee was currentUser()"
}

# GCP
function gclogs {
    gcloud logging read 'resource.type = "cloud_run_revision" resource.labels.service_name = "$1" resource.labels.location = "europe-west2"' --format list 
}

# Other
function screcord {
    ffmpeg \
        -video_size 1920x1080 \
        -r 60 \
        -f x11grab \
        -i :0.0+1920,0 \
        -f pulse -ac 2 -ar 48000 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor \
        -f pulse -ac 1 -ar 44100 -i alsa_input.usb-AKM_AK5370-00-AK5370.analog-mono \
        $HOME/Videos/Screencast-$(date --iso-8601=seconds).mp4
}

