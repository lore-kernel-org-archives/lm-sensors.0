From: charless.fowlkes@gmail.com (Charless Fowlkes)
Date: Wed, 09 Nov 2005 10:10:46 +0000
Subject: [lm-sensors] iwill versus w83627thf
Message-Id: <c3d94a2d0511090110i70b4d1d9s4287080d5dc429f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello -

has anyone run lm_sensors on an iwill zmaxdp motherboard?

when i run sensors-detect, i get a reasonable answer

Driver `eeprom' (should be inserted):
Detects correctly:
* Bus `SMBus nForce2 adapter at e800'
Busdriver `i2c-nforce2', I2C address 0x50
Chip `SPD EEPROM' (confidence: 8)
* Bus `SMBus nForce2 adapter at e800'
Busdriver `i2c-nforce2', I2C address 0x51
Chip `SPD EEPROM' (confidence: 8)

Driver `w83627hf' (should be inserted):
Detects correctly:
* ISA bus address 0x0290 (Busdriver `i2c-isa')
Chip `Winbond W83627THF Super IO Sensors' (confidence: 9)

and have no problem loading the suggested modules

[fowlkes@xor ~]$ lsmod | grep i2c
i2c_sensor 7617 2 w83627hf,eeprom
i2c_isa 6337 0
i2c_nforce2 11073 0
i2c_dev 13761 0
i2c_core 25409 6 w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_nforce2,i2c_dev

but sensors only gives me info from eeprom, nothing from the winbond chip.
i'm pretty sure the chip is a w83627thf. i can get sensor values from it
using
"speedfan".

this is a standard fc4 install, lm_sensors v2.9.1, kernel
2.6.13-1.1532_FC4smp.


thanks,
charless
