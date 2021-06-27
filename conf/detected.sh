#!/bin/bash
PATH=/usr/bin

alert="Signature detected: $CLAM_VIRUSEVENT_VIRUSNAME in $CLAM_VIRUSEVENT_FILENAME"

# Send the alert to systemd logger if exist, othewise to /var/log
if [[ -z $(command -v systemd-cat) ]]; then
	echo "$(date) - $alert" >> /var/log/clamav/infected.log
else
	# as "emerg", this could cause your DE to show a visual alert. Happen in Plasma. but the next visual alert is much nicer
	echo "$alert" | /usr/bin/systemd-cat -t clamav -p emerg
fi

# suidを聞かないし別の仕組みが必要ないので、GUIへの通知はコメントアウト
##send an alrt to all graphical user
#XUSERS=($(who|awk '{print $1$NF}'|sort -u))
#
#for XUSER in $XUSERS; do
#    NAME=(${XUSER/(/ })
#    DISPLAY=${NAME[1]/)/}
#    DBUS_ADDRESS=unix:path=/run/user/$(id -u ${NAME[0]})/bus
#    # ルートユーザで実行しないと動かない。課題あり。
#    RESP=$(/usr/bin/sudo -u ${NAME[0]} DISPLAY=${DISPLAY} \
#                       DBUS_SESSION_BUS_ADDRESS=${DBUS_ADDRESS} \
#                       PATH=${PATH} \
#                       /usr/bin/notify-send -i dialog-warning "clamAV" "$alert")
#    echo "run $NAME - $DISPLAY - $DBUS_ADDRESS - $RESP - $? - ${PATH}" >> /tmp/testlog 
#    env >> /tmp/testlog
#    id >> /tmp/testlog
#    echo "run $NAME - $DISPLAY - $DBUS_ADDRESS - $RESP - $? - ${PATH}"
#    id
#    env
#done