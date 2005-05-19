From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm-sensors Debian ppc 2.4.20-ben10
Message-Id: <20030613124118.3be0cab0.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I am running a PPC with 2.4.20-ben10 Kernel.

I installed the packages lm-sensors-sources and i2c-source

in /usr/src/linux I done make-kpkg modules_image. This gave me two files:
i2c-2.4.20-ben10_2.7.0-4+zeno.1_powerpc.deb  
lm-sensors-2.4.20-ben10_2.7.0-5+zeno.1_powerpc.deb

Now when I do detect-sensors as root, I get: command not found.
So I cd to /usr/src/modules/lm-sensors/prog/detect/sensors-detect and run the skript form there.

All my sensors detect fine:
#----cut here----
# I2C adapter drivers
# modprobe unknown adapter uni-n 0 using Keywest i2c
# modprobe unknown adapter uni-n 1 using Keywest i2c
# modprobe unknown adapter mac-io 0 using Keywest i2c
# modprobe unknown adapter uni-n 0 using Keywest i2c
# modprobe unknown adapter uni-n 1 using Keywest i2c
# modprobe unknown adapter mac-io 0 using Keywest i2c
# modprobe unknown adapter uni-n 0 using Keywest i2c
# modprobe unknown adapter uni-n 1 using Keywest i2c
# modprobe unknown adapter mac-io 0 using Keywest i2c
# I2C chip drivers
lm75
eeprom
#----cut here----
 
Then, run /etc/init.d/modutils
 
 
To make the sensors modules behave correctly, add these lines to
/etc/modutils/local and run update-modules:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

But now when I try to run sensors, I get: command not found!

Has sensors not been installed with my dpkg -i lm-sensors-2.4.20-ben10_2.7.0-5+zeno.1_powerpc.deb ?

sudo find / -name sensors gives me:
/usr/src/modules/lm-sensors/prog/init/sensors
/usr/src/modules/lm-sensors/prog/sensors

Thanks for your time and feedback.

Zeno
