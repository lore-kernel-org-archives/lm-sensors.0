From: swistakers@wp.pl (=?ISO-8859-2?Q?Micha=B3_=A6witakowski?=)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: Lmsensors on Mdk10 (some bugs)
Message-Id: <410FB665.6070604@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

I've installed lm_sensors on Mandrake 10 Official and I've found some 
bugs. Here's what said sensors-detect (look at the comments):

Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SiS96x SMBus adapter at 0xe600' (Algorithm unavailable)
     Busdriver `i2c-sis96x', I2C address 0x50
     Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (may not be inserted):  <-- lmsensors detected this 
chip but it's not mentioned in modprobe commands

   Misdetects:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83697HF' (confidence: 8)

Driver `w83627hf' (should be inserted):

   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)?

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
# I2C chip drivers
modprobe eeprom
modprobe w83627hf  <-- there's not module "w83627hf", the proper name is 
"w83627hf_wdt"

# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

Lm_sensors didn't work without "w83781d", I've added modprobe w83781d to 
/etc/rc.d/rc.local and corrected w83627hf. Now it works.

Some information about my system:
Mandrake 10 Official + updates(bug fixes)
kernel-2.6.3-15mdk (from rpm)
lm_sensors 2.8.7

Sorry for my English.
Greetings!
Micha? ?witakowski
