From: bfoddy@visi.com (Brian Foddy)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors on Asus PC-DL (Intel 82801EB ICH5)
Message-Id: <200311282159.42048.bfoddy@visi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm trying to use lm_sensors to monitor a new
machine using the Asus PC-DL motherboard,
(3Ghz Xeon, Canterwood chip set).  Using Mandrake
9.2 with the standard 2.8.0 included, sensors-detect

Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.


After sensors-detect it finds:
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe lm75
modprobe eeprom
modprobe smbus-arp
modprobe w83627hf
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

2 modules can't be loaded (I can't find them anywhere)
modprobe: Can't locate module smbus-arp
modprobe: Can't locate module w83627hf

And afterwards, the sensors command only outputs:
sensors
lm75-i2c-0-48
Adapter: SMBus I801 adapter at 0500
Algorithm: Non-I2C SMBus adapter
temp:     +253.0?C  (limit = +120.0?C, hysteresis = +100.0?C)

lm75-i2c-0-49
Adapter: SMBus I801 adapter at 0500
Algorithm: Non-I2C SMBus adapter
temp:     +253.0?C  (limit = +120.0?C, hysteresis = +100.0?C)

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0500
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512



No cpu temps, fan speeds, voltages, etc.
I see from your web site the 82801EB has a
first release of 2.8.0.  
Questions:
1.  Should this board work?
2.  Are the 2 failed modules the problem/significant?
3.  If I upgrade to 2.8.1 would that help?

Also of note, I use many of the bttv / btaudio / ivtv
modules on this machine, and want to be sure upgrading
I2C wouldn't break any of these modules (or at least
I want to know what I'm getting in to).

Hope you can help...  I'd like to see these temps.
Brian

