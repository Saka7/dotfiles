function ssh_agent_start {
    if [ -n "${SSH_AGENT_PID}" ]; then
      ssh-agent -k > /dev/null
    fi

    keychain --quiet ~/.ssh/google_compute_engine
    keychain --quiet ~/.ssh/github_id_rsa

    source ~/.keychain/`uname -n`-sh
}

