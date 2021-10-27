install:
	sudo cp -f conf/clamd.conf /etc/clamav/
	sudo cp -f conf/prevent.conf /etc/clamav/
#sudo cp -f conf/detected.sh /etc/clamav/virusevent.d/
	sudo bash -c "curl `curl  https://api.github.com/repos/susumushi/clam-desktop-notifier/releases/latest | jq -r .assets[].browser_download_url` -L -o /etc/clamav/virusevent.d/clamnotify"
	sudo chown root:clamav /etc/clamav/virusevent.d/clamnotify
	sudo chmod 4755 /etc/clamav/virusevent.d/clamnotify
	sudo cp -f conf/clamonacc-prevent.service /etc/systemd/system/
	sudo cp -f conf/clamonacc-notifyonly.service /etc/systemd/system/
	sudo cp -f conf/usr.sbin.clamd /etc/apparmor.d/local/usr.sbin.clamd 
	sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.clamd
	sudo systemctl daemon-reload
	sudo systemctl enable clamav-daemon
	sudo systemctl enable clamonacc-prevent
	sudo systemctl enable clamonacc-notifyonly
	sudo systemctl restart clamav-daemon
	sudo systemctl restart clamonacc-prevent
	sudo systemctl restart clamonacc-notifyonly

install-fangfrisch:
	-sudo rm -rf /var/lib/fangfrisch
	-sudo bash -c "(crontab -l 2>/dev/null | grep -v fangfrisch) | crontab - "
	sudo mkdir -m 0770 -p /var/lib/fangfrisch
	sudo chgrp clamav /var/lib/fangfrisch
	sudo bash -c "cd /var/lib/fangfrisch && python3 -m venv venv && source venv/bin/activate && pip install fangfrisch"
	sudo cp -f conf/fangfrisch.conf /etc/fangfrisch.conf
	sudo -u clamav -- /var/lib/fangfrisch/venv/bin/fangfrisch --conf /etc/fangfrisch.conf initdb
	sudo bash -c "(crontab -l 2>/dev/null; echo '*/15 * * * * clamav /var/lib/fangfrisch/venv/bin/fangfrisch --conf /etc/fangfrisch.conf refresh') | crontab - "

# hostsに入れたフィッシングサイトを127.0.0.1にする設定がご検知されるため無視する　
update-allow-list:
	-sudo rm -f /var/lib/clamav/false-positives.sfp
	sudo bash -c "sigtool --sha256 /etc/hosts >> /var/lib/clamav/false-positives.sfp"
