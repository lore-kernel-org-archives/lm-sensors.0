From: paulwagner429@hotmail.com (Paul Wagner)
Date: Sat, 13 May 2006 12:54:21 +0000
Subject: [lm-sensors] Newbie help
Message-Id: <BAY113-W7FF2DFDEDE7A866B1CE20F0AD0@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am not new to linux but I am new to lm-sensors
The sensors.conf file has me completely lost
 
I have Fedora Core 5 running on a Abit IS7-E w/ Intel 82865PE (MCH) + 82801EB (ICH5) chipset 
I installed using "make user" and "make user_install"
added library path to ld.so.conf and ran ldconfig
ran sensor -detect w/the following results
 
#----cut here----# I2C module optionsalias char-major-89 i2c-dev#----cut here----
To load everything that is needed, add this to some /etc/rc* file:
#----cut here----# I2C adapter driversmodprobe i2c-i801modprobe i2c-isa# I2C chip driversmodprobe eeprommodprobe w83627hf# sleep 2 # optional/usr/local/bin/sensors -s # recommended#----cut here----
 
I am lost from here as I do not understand the conf file
also along the line it told me to Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
 
but there is no /prog dir
 
help please
Paul
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060513/a23a441d/attachment.html
