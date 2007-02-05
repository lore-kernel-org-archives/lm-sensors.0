From: nick.upson@gmail.com (Nick Upson)
Date: Mon, 05 Feb 2007 12:09:35 +0000
Subject: [lm-sensors] Can't access procfs/sysfsfile
Message-Id: <36ba31bd0702050409t7f65f11emf2f9e7a31b5089ae@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I just started trying to use lm_sensors and run into this message. I'm
using fedora core 5 and lm_sensors-2.10.2-46.fc5.at.i386.rpm2


lm_sensors builds and installs fine, and sensors-detect runs and detects:


To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-sis96x
modprobe i2c-isa
# Chip drivers
modprobe eeprom
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

so I run these items and get the error message

$ modprobe i2c-sis96x
$ modprobe i2c-isa
$ # Chip drivers
$ modprobe eeprom
$ modprobe w83627hf
$ # sleep 2 # optional
$ /usr/local/bin/sensors -s
Can't access procfs/sysfs file
Kernel interface access error
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!

