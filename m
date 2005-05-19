From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: lmsensors on Sony PCG-GRX416G
Message-Id: <200502060103.00747.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hei,

is there a chance to get lm-sensors running on a PCG-GRX416G ?

I build i2c 2.8.8 and lmsensors 2.8.8 against a vanilla 2.4.29 kernel. Result 
of sensors-detect:

/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# I2C chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

But sensors doesn't find any sensors.

Thanks,
Marcus 
