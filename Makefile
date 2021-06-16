#makefile for ax25systemd
.PHONY prerequisites:
prerequisites:
	@apt -y install ax25-tools ax25-apps

.PHONY install:
install: prerequisites
	@/bin/cp -f "ax25.service" "/etc/systemd/system/"
	@/bin/cp -f "axup" "/usr/local/sbin/"
	@/bin/chmod +x "/usr/local/sbin/axup"
	@/bin/cp -f "axdown" "/usr/local/sbin"
	@/bin/chmod +x "/usr/local/sbin/axdown"
	@/bin/cp "ax25.default" "/etc/default/ax25"
	@/bin/cp "45-tnc.rules" "/etc/udev/rules.d/"
	@/bin/mkdir -p "/usr/local/share/kissinit"
	@/bin/cp "kissinit/nordlink_1k2" "/usr/local/share/kissinit/"
	@/bin/chmod +x "/usr/local/share/kissinit/nordlink_1k2"
	@/bin/cp "kissinit/ej50u" "/usr/local/share/kissinit/"
	@/bin/chmod +x "/usr/local/share/kissinit/ej50u"
	@#
	@systemctl daemon-reload
	@udevadm control --reload-rules
	@udevadm trigger
	@echo " "
	@echo "Installed. Edit /etc/default/ax25 and /etc/ax25/axports if needed. When done editing those files, run \"service ax25 start\" to start the service"

.PHONY uninstall:
uninstall:
	@/bin/rm "/etc/udev/rules.d/45-tnc.rules"
	@udevadm control --reload-rules
	@udevadm trigger
	@service ax25 stop
	@systemctl daemon-reload
	@/bin/rm "/etc/systemd/system/ax25.service"
	@/bin/rm "/usr/local/sbin/axup"
	@/bin/rm "/usr/local/sbin/axdown"
	@/bin/rm "/etc/default/ax25"
	@/bin/rm -rf "/usr/local/share/kissinit/"
	@echo " "
	@echo "Uninstalled !"
