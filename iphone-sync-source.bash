function iphone-music-update() {
    if [ "$1" == "-k" ]; then
        echo "-k passed: Killing Finder"
        killall Finder
    fi

    echo 'Trimming playlist'
    iphone-sync-once &
    bash -c "cd /Users/Dylan/Dropbox/Programming/GitHub/itunes-applescripts/ && npm run gulp -- be --no-dry-run -s remove-recent"
    iphone-sync
}

function iphone-sync() {
    echo 'Starting phone sync'

    for ((i=0;i<100;i++)) do
        iphone-sync-once
        if [ "$?" -eq 0 ]; then
            echo 'Sync started'
            break
        else
            echo 'Sync failed to start. Device not found'
            sleep 3
        fi
    done
}

function iphone-sync-once() {
    timeout 10 osascript /Users/Dylan/Dropbox/Programming/GitHub/iphone-sync-script/iphone-sync.applescript
}
