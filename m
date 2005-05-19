From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd0503221101176aa0e7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good news!

The OOPS is gone with your patch.  I tested with both the EEPROM and
NVidia drivers built into the kernel.  I have included the debugging
output from your latest patch below:

CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y

CONFIG_I2C_ISA=y
CONFIG_I2C_NFORCE2=y

CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_LM63=y
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y

CONFIG_SENSORS_EEPROM=y
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

Linux version 2.6.12-rc1 (root@Monkey100) (gcc version 3.3.5 (Debian
1:3.3.5-12)) #2 Tue Mar 22 13:40:51 EST 2005
i2c /dev entries driver
i2c-core: driver dev_driver registered.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-2: Registered as minor 2
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5500
i2c-core: driver adm1021 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 18
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 19
input: AT Translated Set 2 keyboard on isa0060/serio0
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 1a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 29
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2b
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 18
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 19
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 1a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 29
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2b
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4d
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4e
i2c-core: driver adm1025 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c_adapter i2c-2: ADM1025 detection failed at 0x2d.
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
i2c_adapter i2c-2: ADM1025 detection failed at 0x2e.
i2c-core: driver adm1026 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
 : Detecting device at 2,0x2d with COMPANY: 0x00 and VERSTEP: 0x19
 : Autodetecting device at 2,0x2d ...
 : : Autodetection failed
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
 : Detecting device at 2,0x2e with COMPANY: 0xff and VERSTEP: 0xff
 : Autodetecting device at 2,0x2e ...
 : : Autodetection failed
i2c-core: driver adm1031 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
i2c-core: driver eeprom registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 50
i2c_adapter i2c-1: client [eeprom] registered to adapter
registering 1-0050
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 51
i2c_adapter i2c-1: client [eeprom] registered to adapter
registering 1-0051
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 52
i2c_adapter i2c-1: client [eeprom] registered to adapter
registering 1-0052
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 53
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 54
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 55
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 56
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 57
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 50
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 51
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 52
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 53
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 54
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 55
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 56
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 57
i2c-core: driver lm63 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4c
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4c
i2c-core: driver lm75 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 48
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 49
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4b
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4e
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4f
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 48
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 49
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4b
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4d
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4e
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4f
i2c-core: driver lm77 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 48
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 49
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4b
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 48
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 49
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4b
i2c-core: driver lm78 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
i2c_adapter i2c-0: found normal isa entry for adapter 9191, addr 0290
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 20
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 21
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 22
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 23
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 24
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 25
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 26
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 27
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 28
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 29
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2b
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2f
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 20
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 21
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 22
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 23
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 24
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 25
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 26
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 27
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 28
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 29
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2b
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c-core: driver lm80 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 28
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 29
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2b
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2f
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 28
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 29
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2b
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2f
i2c-core: driver lm83 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 18
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 19
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 1a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 29
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2a
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2b
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 18
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 19
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 1a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 29
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2a
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2b
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4d
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4e
i2c-core: driver lm85 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c_adapter i2c-2: Detecting device at 2,0x2d with COMPANY: 0x00 and
VERSTEP: 0x00
i2c_adapter i2c-2: Autodetecting device at 2,0x2d ...
i2c_adapter i2c-2: Autodetection failed
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
i2c_adapter i2c-2: Detecting device at 2,0x2e with COMPANY: 0x00 and
VERSTEP: 0x00
i2c_adapter i2c-2: Autodetecting device at 2,0x2e ...
i2c_adapter i2c-2: Autodetection failed
i2c-core: driver lm87 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2d
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 2e
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2d
i2c_adapter i2c-2: LM87 detection failed at 0x2d.
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 2e
i2c_adapter i2c-2: LM87 detection failed at 0x2e.
i2c-core: driver lm90 registered.
drivers/i2c/busses/i2c-isa.c:59: c03eede0
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4c
i2c_adapter i2c-1: found normal i2c entry for adapter 1, addr 4d
drivers/i2c/busses/i2c-nforce2.c:332: c03ef000
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4c
i2c_adapter i2c-2: found normal i2c entry for adapter 2, addr 4d

            -- Miles
