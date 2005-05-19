From: zayets@comcast.net (Rob)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <1100659621.2956.12.camel@Oneniisama>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, I have successfully installed LM sensors version 2.8.4, and I am
using them with a 2.6.3 Mandrake 10 kernel.

sensors works when i tell it sensors in the terminal, but the values are
off (double), Per the FAQ it tells me to modify the conf file.  I have
an asus A7N8XE-deluxe, which i know uses the asb100 file. When I modify
the file in that area, cut the fan info to divide by 2, and swap the
labels for CPU and Motherboard.  Save, then do sensors-s then rebooted,
and none of my changes to effect.


[rob@Oneniisama rob]$ sensors
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Memory type: DDR SDRAM DIMM
Memory size (MB): 512

eeprom-i2c-0-50
Adapter: SMBus nForce2 adapter at 5000
Memory type: DDR SDRAM DIMM
Memory size (MB): 512

asb100-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
VCore 1: +1.68 V (min = +1.55 V, max = +1.73 V)
+3.3V: +3.30 V (min = +3.12 V, max = +3.46 V)
+5V: +4.97 V (min = +4.73 V, max = +5.24 V)
+12V: +11.67 V (min = +10.76 V, max = +13.19 V)
-12V (reserved):
-12.13 V (min = -0.00 V, max = -0.00 V)
-5V (reserved):
-5.12 V (min = -0.00 V, max = -0.00 V)
CPU Fan: 11637 RPM (min = 1997 RPM, div = 4) <------------- this is
double what it really is
Chassis Fan:
12500 RPM (min = 3994 RPM, div = 2) <------------- this is double what
it really is
Power Fan:3994 RPM (min = 3994 RPM, div = 2) ALARM 
---------------variable speed fan, 3000 sounds like a safer min
M/B Temp: +52?C (high = +0?C, hyst = +0?C)<------really is cpu temp
CPU Temp (Intel):
+40?C (high = +45?C, hyst = +40?C) <----40 is likely the mobo temp
Power Temp:
+127?C (high = +0?C, hyst = +0?C)
CPU Temp (AMD):
+25?C (high = +80?C, hyst = +75?C)
vid: +1.650 V
alarms:

I dont know what the intel and amd  temps are. I have an AMD processor,
and it runs about 55 degrees.


sensors-detect


told me to do this

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here

And i did


To load everything that is needed, add this to some /etc/rc* file:


 Which file? there are many folders and files.

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# I2C chip drivers
modprobe asb100
modprobe smbus-arp
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----


I think that this may be why its not recognizing my changes, becuase it
doesnt know where in the conf file to look?  The etc/rc additions 
perhaps tell it where to look in the conf file, but I dont know which
etc/rc file to add too, there are rc1-6 folders, and each has many
files.  Which folder and file do I add too?

Thank you in advance for any help. I'm a semi newbie, and I have been
able to figure out the rest, but this is where I am getting lost, as a
specific file to modify is not listed.

Thank you again

Rob




