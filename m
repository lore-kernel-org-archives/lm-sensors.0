From: tenchy@pacbell.net (John Jones)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors problem booting after install
Message-Id: <4044E51F.9050908@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My system is an AMD64 with Nforce3 and ite8712f-A chips.

I was hoping to get partial info from the ite chip.

after placing the following in the /etc/modules.conf

> alias eth1 tulip
> alias char-major-195 nvidia
> # I2C module options
> alias char-major-89 i2c-dev
> options it87 ignore=-1,0x290
> # I2C adapter drivers
> #modprobe i2c-isa
> # I2C chip drivers
> #modprobe it87
> # sleep 2 # optional
> #/usr/local/bin/sensors -s # recommended

when modprobe it87 activates it shuts down all my internal fans.

anyway commenting out the last 2 modprobes, sensors -s and removing the 
lm_sensors file from the /etc/rc.d/init.d allows me to reboot.

Also when I rebooted the first time there were massive failures from 
other devices such as mouse iptables ect...

Thanks in advanced john
