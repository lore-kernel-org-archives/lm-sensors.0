From: mike corn <mikecorn@arcor.de>
Date: Sun, 22 Jul 2007 08:10:22 +0000
Subject: [lm-sensors] Intel D975XBX2 motherboard "no sensors found"
Message-Id: <46A310EE.4080206@arcor.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Motherboard: Intel D975XBX2
CPU: Core 2 Quad 6600
Linux: Ubuntu 7.04
lm-sensors: 2.10.1

Your online docs are in shambles, so perhaps I did not understand them.
Here is exactly what I did:

1. sensors-detect: found i2c-i801 and eeprom
(I answered YES to all queries, including the auto add to /etc/modules)
2. modprobe i2c-i801 and eeprom
3. sensors --> "no sensors found"

Relevant outputs are pasted below.
Note "unknown adaptor NVIDIA i2c".

regards,
Mike

===================

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `NVIDIA i2c adapter 0 at 2:00.0'
    Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 
0x56 0x57)
    Chip `EDID EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 4000'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at 4000'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `eeprom' (confidence: 6)

====================
To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA i2c adapter 0 at 2:00.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 2:00.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 2:00.0
i2c-i801
# Chip drivers
eeprom
#----cut here----



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
