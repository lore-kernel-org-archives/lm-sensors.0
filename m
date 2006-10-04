From: kress@hal.saar.de (Michael Kress)
Date: Wed, 04 Oct 2006 23:14:46 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <45244066.4000500@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, hi list,

thanks for your reply.

Jean Delvare wrote:
> You must be using an old version of lm_sensors. Type 8 is DDR2 SDRAM,
> which is supported for quite some time now.
>   
ok, no discussion - I uninstalled the old thing. :)
> This is an old version of sensors-detect, no wonder it doesn't detect
> your sensors. Please try again with the version of sensors-detect which
> comes with the freshly released lm_sensors 2.10.1.
>
> I think I've seen this motherboard before, so I guess it'll find a
> National Semiconductor LM93 for the temperatures and voltages, and a
> National Semiconductor PC87427 Super-I/O chip for the fans. Status for
> these chips is as follows:
>
> * A driver for the LM93 chip exists but wasn't officially ported to
> Linux 2.6. There was a preliminary port posted to this list at the
> times of ~ 2.6.10, but it was never properly reviewed due to lack of
> time.
>
> * We have a datasheet for the PC87427 but no public driver yet. I've
> been working on the fan support though, I have a preliminary driver
> waiting for testers.
>   
Version 2.10.1 gives me the following output:
-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----
Driver `lm93' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `National Semiconductor LM93' (confidence: 5)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x53
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 1100'
    Busdriver `i2c-i801', I2C address 0x57
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0840 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Fan Sensors' (confidence: 9)
  * ISA bus address 0x0880 (Busdriver `i2c-isa')
    Chip `Nat. Semi. PC87427 Super IO Health Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

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
# Chip drivers
# Warning: the required module lm93 is not currently installed
# on your system. For status of 2.6 kernel ports check
# http://www.lm-sensors.org/wiki/Devices. If driver is built
# into the kernel, or unavailable, comment out the following line.
modprobe lm93
modprobe eeprom
# no driver for Nat. Semi. PC87427 Super IO Fan Sensors yet
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----
-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----

Well, the trouble is of course, that there's no module lm93.

This is what Supermicro support has mailed me as a response to my
question as posted into the list. They called it "X6DH8-G2 SDK file",
but I'm sorry, I don't understand the things written here. Maybe that's
the data sheet you were talking about.
(Getting the response from the Supermicro support guy made me feel like
walking into a grocery store asking for some exotic product and
receiving a construction plan for the atoms to be compound in order to
build that product). :-)

X6DH8-G2_X6DH8-XG2.txt:
-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----
Bus Type = I/O Mapping and SMBus
One NS87427, One LM93

NS87427
===============================
Fan: I/O Based: 0840h, Bank Select Register: Base + 0Fh
Fan1 Fan Speed, Base + 12h, Base + 13h,   Bank 0
Fan2 Fan Speed, Base + 12h, Base + 13h,   Bank 1
Fan3 Fan Speed, Base + 12h, Base + 13h,   Bank 2
Fan4 Fan Speed, Base + 12h, Base + 13h,   Bank 3
Fan5 Fan Speed, Base + 12h, Base + 13h,   Bank 4
Fan6 Fan Speed, Base + 12h, Base + 13h,   Bank 6
CPU1 Fan Speed, Base + 12h, Base + 13h,   Bank 7
CPU2 Fan Speed, Base + 12h, Base + 13h,   Bank 5

Chassis Intrusion: I/O Based: 0800h, Bank Select Register: Base + 0Fh
Chassis Intrusion: Base + 0Ch,   All Bank

Power Supply Failure, GP57


LM93, Slave Address=0x2e (0x5C in 8-Bit format)
===============================
CPU1 Core Voltage, Offset 0x5c       
CPU2 Core Voltage, Offset 0x5d
+3.3V Voltage, Offset 0x5e
+5V Voltage, Offset 0x5f
+12V Voltage, Offset 0x56       
-12V Voltage, Offset 0x64
CPU1 Temperature, Offset 0x50       
CPU2 Temperature, Offset 0x51       
System Temperature, Offset 0x52
-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----

I can test your driver for the PC87427 if you like to. My only
constraint is that I have to put the server into production very soon
(in about one or two weeks).

TIA
ciao - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


