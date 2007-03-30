From: Aldo Caruso <acaruso@argencasas.com>
Date: Fri, 30 Mar 2007 01:27:30 +0000
Subject: [lm-sensors] ITE IT8718F Super IO Sensors
Message-Id: <460C6782.7010603@argencasas.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

  I'm running debian on a Penium IV with a P4M800PRO-M motherboard.
  I run sensors-detect and this is the result :

//--------------------------------------------------------------
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 0400'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8718F Super IO Sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-viapro
# Chip drivers
eeprom
it87
#----cut here----
//--------------------------------------------------------------

I let the program add the former lines to /etc/modules, I reboot, I run 
sensors and this is the result:
//--------------------------------------------------------------
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
//--------------------------------------------------------------

Doing lsmod I found all the above modules listed.

Thanks for any idea,

Aldo




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
