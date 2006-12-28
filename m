From: maj1224@yahoo.com (Matt Jerdonek)
Date: Thu, 28 Dec 2006 18:38:54 +0000
Subject: [lm-sensors] Detecting temp on Xeon
Message-Id: <20061228183854.53963.qmail@web33506.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm pretty new to lm-sensors, and I'm struggling getting a temperature reading off a Xeon (dual core LV aka Sossaman).

I first ran sensors-detect and got the following output:
---------------------------------------------------------------------
To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# You must also install and load the IPMI modules
modprobe i2c-ipmi
# I2C chip drivers
modprobe eeprom
modprobe bmcsensors
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----
-----------------------------------------------------------------------------

I also updated my /etc/sysconfig/lm_sensors file.  Unfortunately, I'm getting an error in the bmcsensors driver:

[root at sprm4 root]# lm_ipmi_kcs_sm: kcs hosed: OBF not ready in time
bmcsensors.o: Error 0xff on cmd 0xa/0x22; state = 0; probably fatal.

So, I took out the bmcsensors and tried both xeontemp and adm1021 driver.  In all cases, this is the output I get from sensors:

[root at sprm4 root]# sensors
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0540
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0540
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0540
Unknown EEPROM type (255).

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 0540
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 0540
Memory type:            DDR2 SDRAM DIMM
Memory size (MB):       1024

Does this make sense to anyone?

Some additional info:
kernel 2.4.21, chipset of Intel E7520 + 6300ESB, sensors version 2.10.0, libsensors version 2.10.0



Thanks in advance for any help,
-- Matt



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

