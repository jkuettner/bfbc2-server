#!/bin/bash

export GAMEMODEID="BC2"
if [[ "${SERVER_TYPE}" == viet* ]]; then
  GAMEMODEID="VIETNAM"
fi

function write_config() {
    local CONFIG_PATH="${1}"

cat <<EOF >bfbc2.ini
[info]
host=${MASTER_SERVER}
connect_to_retail=0
executable_type=auto
show_console=1

[client]
reroute_http=0

[server]
ranking_min_players=1
deserting_allowed=0
instant_spawn=0
unlimited_ammo=0
health_mode=0
EOF

cat <<EOF >${CONFIG_PATH}ServerOptions.ini
[Options] 
Name=${SERVER_NAME}
Port=${SERVER_PORT}
RemoteAdminPort=${SERVER_ADMIN_PORT}
RemoteAdminPassword=${SERVER_ADMIN_PASSWORD}
PunkBuster=false
Ranked=true
NumGameClientSlots=${SERVER_MAX_PLAYERS}

RevisionLevel=8
RevisionKey=7C0A303E-F4D2-985E-763D-E7C41B1E06A3
GameModID=${GAMEMODEID}
EOF

cat <<EOF >./Startup.txt
vars.hardCore ${SERVER_HARDCORE}
vars.friendlyFire ${SERVER_FF}
vars.teamBalance ${SERVER_TEAMBALANCE}
vars.killCam ${SERVER_KILLCAM}
vars.miniMap ${SERVER_MINIMAP}
vars.crossHair ${SERVER_CROSSHAIR}
vars.3dSpotting ${SERVER_SPOTTING}
vars.miniMapSpotting ${SERVER_MINIMAP_SPOTTING}
EOF
}

function start_bfbc2_server() {
    local SERVER_PATH="${1}"
    local SERVER_MODE="${2}"
    local MAPLIST_PATH="${3}"

    write_config "${SERVER_PATH}"

    echo "Starting ${SERVER_MODE} server ..."
    rm -f "${SERVER_PATH}maplist.txt"
    ln -s "/home/bfbc2/server/maplists/${MAPLIST_PATH}" "${SERVER_PATH}maplist.txt"

    xvfb-run -e /dev/stdout -a -s "-nolisten tcp -screen 0 1280x1024x24" wine "Frost.Game.Main_Win32_Final.exe" \
        -serverInstancePath "${SERVER_PATH}" \
        -mapPack2Enabled 1 \
        -timeStampLogNames \
        -region OC \
        -heartBeatInterval 20000
}

shopt -s nocasematch

case "${SERVER_TYPE}" in
"rush")
    start_bfbc2_server "Instance/" "Rush" "rush.txt"
    ;;
"conq")
    start_bfbc2_server "Instance_conq/" "Conquest" "conquest.txt"
    ;;
"sqdm")
    start_bfbc2_server "Instance_sqdm/" "Squad Deathmatch" "sqdm.txt"
    ;;
"sqrush")
    start_bfbc2_server "Instance_sqrush/" "Squad Rush" "sqrush.txt"
    ;;
"vietconq")
    start_bfbc2_server "Instance_viet_conq/" "Vietnam Conquest" "viet_conquest.txt"
    ;;
"vietrush")
    start_bfbc2_server "Instance_viet_rush/" "Vietnam Rush" "viet_rush.txt"
    ;;
"vietsqrush")
    start_bfbc2_server "Instance_viet_sqrush/" "Vietnam Squad Rush" "viet_sqrush.txt"
    ;;
"vietsqdm")
    start_bfbc2_server "Instance_viet_sqdm/" "Vietnam Squad Deathmatch" "viet_sqdm.txt"
    ;;
*)
    echo "SERVER_TYPE have to be one of 'rush', 'conq', 'sqdm', 'sqrush', 'vietconq', 'vietrush', 'vietsqrush' or 'vietsqdm'"
    exit 1
    ;;
esac
