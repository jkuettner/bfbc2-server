FROM debian:bookworm

ENV DEBIAN_FRONTEND=NONINTERACTIVE

RUN dpkg --add-architecture i386 \
    && sed -i 's/^Components: main$/& contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && apt-get install --no-install-recommends -y \
        xvfb \
        wine32 \
        winetricks \
        libgl1-mesa-glx:i386 \
        ca-certificates \
        unrar \
        winbind \
        xauth \
        cabextract \
        wget \
    && apt-get clean \
    && useradd -m bfbc2

USER bfbc2

ENV WINEARCH=win32 \
    WINEPREFIX="/home/bfbc2/.wine32"

RUN mkdir -p /home/bfbc2/server/ \
    && xvfb-run -e /dev/stdout -a -s "-nolisten tcp -screen 0 1280x1024x24" wineboot \
    && xvfb-run -e /dev/stdout -a -s "-nolisten tcp -screen 0 1280x1024x24" winetricks -q \
        dinput8 \
        vcrun2005 \
        vcrun2008 \
        vcrun2010 \
    && wget -qO /tmp/Bc2emu_V09.rar "https://downloads.sourceforge.net/project/battlefieldbadcompany2mase/Bc2emu_V09.rar" \
    && unrar x /tmp/Bc2emu_V09.rar \
        -x'Bc2emu/!DOCS' \
        -x'Bc2emu/Crack - Copy to client root' \
        -x'Bc2emu/MasterServerEmu' \
        -x'Bc2emu/Source and Stuff' \
        -x'*.bat' \
        -x'*.log' \
        -x'*.txt' \
        /tmp \
    && mv /tmp/Bc2emu/* /home/bfbc2/server/ \
    && rm -rf /tmp/Bc2emu_V09.rar /tmp/Bc2emu \
    && for instance in $(find /home/bfbc2/server/ -name "Instance*"); do ln -fs /home/bfbc2/server/Startup.txt "${instance}/AdminScripts/Startup.txt"; done

ENV MASTER_SERVER="127.0.0.1" \
    SERVER_TYPE="rush" \
    SERVER_NAME="BFBC2 Server" \
    SERVER_PORT=19567 \
    SERVER_ADMIN_PORT=48888 \
    SERVER_ADMIN_PASSWORD="langaming" \
    SERVER_MAX_PLAYERS=16 \
    SERVER_HARDCORE="false" \
    SERVER_FF="false" \
    SERVER_TEAMBALANCE="true" \
    SERVER_KILLCAM="true" \
    SERVER_MINIMAP="true" \
    SERVER_CROSSHAIR="true" \
    SERVER_SPOTTING="true" \
    SERVER_MINIMAP_SPOTTING="true"

USER root

ADD bin/run.sh /home/bfbc2/server/run.sh
ADD maplists/ /home/bfbc2/server/maplists/

RUN chown bfbc2:bfbc2 -R /home/bfbc2 \
    && chmod +x /home/bfbc2/server/run.sh

USER bfbc2

WORKDIR /home/bfbc2/server

CMD ["./run.sh"]