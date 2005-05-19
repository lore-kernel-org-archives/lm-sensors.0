From: javi@gsmlandia.com (javi@gsmlandia.com)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Epox 8RDA+: Unknown EEPROM type (101)
Message-Id: <32819.192.168.0.4.1067821063.squirrel@www.gsmlandia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.
When runing the sensors binary I get the message:
# /usr/local/bin/sensors
eeprom-i2c-0-50
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (101)

I've downloaded and installed i2c and lm-sensors foloowing this steps:

# cd i2c-2.8.1
# make
# make install
# depmod -a

# cd lm_sensors-2.8.1
# make
# make install
# depmod -a

In the  /etc/ld.so.conf there is a line like:  /usr/local/lib

# ldconfig
# ./prog/mkdev/mkdev.sh
# ./prog/detect/sensors-detect (answer default for all questions)
With the results...
#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----


# cp /etc/sysconfig/lm_sensors /etc/conf.d/ (because Gentoo uses  /etc/conf.d/  not
/etc/sysconfig/ )
I've added into the modules autoload script (Gentoo uses
/etc/modules.autoload.d/kernel-2.4): i2c-nforce2
 i2c-isa
 eeprom
 w83781d

For testing without reboot:
# modprobe i2c-nforce2
# modprobe i2c-isa
# modprobe eeprom
# modprobe w83781d
# /usr/local/bin/sensors -s
# /usr/local/bin/sensors
eeprom-i2c-0-50
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (101)

Whay is the problem. Whay Can I do?

My SO is Linux Gentoo 1.4 and my motherboard is a Epox 8rda+ with nforce2 chipset.
I'm using lm_sensors and i2c version 2.8.1
Thanks in advice.

Javier.

