install:
	sudo cp -f conf/clamd.conf /etc/clamav/
	sudo cp -f conf/prevent.conf /etc/clamav/
#sudo cp -f conf/detected.sh /etc/clamav/virusevent.d/
	curl `curl  https://api.github.com/repos/susumushi/clam-desktop-notifier/releases/latest | jq -r .assets[].browser_download_url` -L -o /etc/clamav/virusevent.d/clamnotify
	chown root:clamav /etc/clamav/virusevent.d/clamnotify
	chmod 4755 /etc/clamav/virusevent.d/clamnotify
	sudo cp -f conf/clamonacc-prevent.service /etc/systemd/system/
	sudo cp -f conf/clamonacc-notifyonly.service /etc/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl enable clamav-daemon
	sudo systemctl enable clamonacc-prevent
	sudo systemctl enable clamonacc-notifyonly
	sudo systemctl restart clamav-daemon
	sudo systemctl restart clamonacc-prevent
	sudo systemctl restart clamonacc-notifyonly
