From: mikko.cal@gmail.com (Mikko C.)
Date: Sat, 14 Oct 2006 09:42:47 +0000
Subject: [lm-sensors] help with laptop + eeprom
Message-Id: <4530B117.8090603@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I'm having problems with sensors on my new laptop with the new Core 2 
Duo processor.
I got the newest lm_sensors and sysfsutils. I'm running Slackware 11 
with 2.6.18 kernel.
I followed instructions and compiled the kernel with the right options 
(modules, etc.).
This is part of what i get running sensors-detect:

Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.

Next adapter: SMBus I801 adapter at 10c0
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x08
Client found at address 0x30
Client found at address 0x32
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x69

Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `ITE'...                                                Yes
Found unknown chip with ID 0x2803
Trying family `National Semiconductor'...                No
Trying family `SMSC'...                                            Yes
Found unknown chip with ID 0x2803
Trying family `VIA/Winbond/Fintek'...                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                                 No
Trying family `National Semiconductor'...                 No
Trying family `SMSC'...                                             No
Trying family `VIA/Winbond/Fintek'...                       No

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 10c0'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 10c0'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `eeprom' (confidence: 6)


#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# Chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----


Ok, so I modprobed the modules and I tried running sensors. But I get:
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

Have i missed something? All the modules are loaded... What else do I need?
Thank you!
Mikko C.

