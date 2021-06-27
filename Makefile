install:
	sudo cp -f conf/clamd.conf /etc/clamav/
	sudo cp -f conf/prevent.conf /etc/clamav/
	sudo cp -f conf/detected.sh /etc/clamav/virusevent.d/
	sudo cp -f conf/clamonacc-prevent.service /etc/systemd/system/
	sudo cp -f conf/clamonacc-notifyonly.service /etc/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl enable clamav-daemon
	sudo systemctl enable clamonacc-prevent
	sudo systemctl enable clamonacc-notifyonly
	sudo systemctl restart clamav-daemon
	sudo systemctl restart clamonacc-prevent
	sudo systemctl restart clamonacc-notifyonly
