From: miguel@rozsas.xx.nom.br (Miguel Angelo Rozsas)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi There !

	Anyone can you help me, please ?

	My system is a ASUS P4T, P4 1.4GHz, running RH9, with the last stable
kernel 2.4.22 (from kernel.org), whith the linux-2.4.22-i2c-2.8.1.patch
patch applied and lm_sensors-2.8.1.tar.gz installed.

Output of sensors-detect:
 BIOS vendor (ACPI): ASUS
 System vendor (DMI): System Manufacturer
 BIOS version (DMI): ASUS P4T ACPI BIOS Revision 1005
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
Probe succesfully concluded.

	I have no problem following the instructions on
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/QUICKSTART, except when
I have tried to do:

# sensors -s
as99127f-i2c-0-2d: Can't access /proc file for writing;
Run as root?
#

Looking at /proc/bus I've noticed that i2c* are 0444 !
# ls -l /proc/bus/i2c*
-r--r--r--    1 root     root            0 Nov  2 00:11 /proc/bus/i2c
-r--r--r--    1 root     root            0 Nov  2 00:11 /proc/bus/i2c-0

running just sensors, looks like fine (...almost...Why -12V and -5V
readings are wrong ?):
# sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.70 V  (min =  +1.58 V, max =  +1.92 V)
VCore 2:   +1.82 V  (min =  +1.58 V, max =  +1.92 V)
+3.3V:     +3.36 V  (min =  +2.98 V, max =  +3.63 V)
+5V:       +5.06 V  (min =  +4.52 V, max =  +5.48 V)
+12V:     +12.16 V  (min = +10.83 V, max = +13.15 V)
-12V:      -2.30 V  (min = -15.06 V, max = -12.32 V)
-5V:       -1.23 V  (min =  -5.49 V, max =  -4.50 V)
fan1:        0 RPM  (min = 3000 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)
fan3:     5037 RPM  (min = 3000 RPM, div = 2)
temp1:       +45?C  (limit =  +60?C)
temp2:     +42.0?C  (limit = +120?C, hysteresis = +100?C)
temp3:    +255.4?C  (limit = +120?C, hysteresis = +100?C)
vid:      +1.750 V
alarms:
beep_enable:
          Sound alarm enabled
 
eeprom-i2c-0-50
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
 
eeprom-i2c-0-51
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
 
eeprom-i2c-0-52
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter
 
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at e800
Algorithm: Non-I2C SMBus adapter

Finally the questions:

1) Why the permissions for /proc/bus/i2c* are 0444 ?
2) Why the reading for-12V and -5V are wrong ?
How can fix this ?


any help will be appreciated.
thanks in advance,


PS: Sorry any mistakes in my text. English isn't my native language.

-- 
Miguel Angelo Rozsas
miguel@rozsas.xx.nom.br
