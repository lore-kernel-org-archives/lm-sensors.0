From: sfendt@octagonsystems.com (Sean S Fendt)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Need advice, writing new driver.
Message-Id: <200312091903.hB9J3RP26691@sfendt.octagonsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

My name is Sean Fendt, I'm employed by Octagon Systems to provide Linux 
support on their line of industrial single board computers and expansion 
cards.  Right now, I'm working on the model PC770, an EBX Formfactor Pentium 
3, based on the Intel 815 chipset.

I need to support a MicroChip 24LC32A (24C32) EEPROM on the SM Bus.  How 
should I proceed?

Background:
Octagon includes in their CPU boards, an Octagon Specific Serial EEPROM.  
This has several purposes:

1. As an industrial PC, the system BIOS is modified to store all setup 
configuration in the serial EEPROM, so no battery is required for retention 
of configuration data.

2. Production test results, custom configurations, serial numbers, PO 
numbers, and much other production data is also stored in this device.

3. (The one I care about).  The top 50% of the EEPROM is available for USER 
DATA.  The user can do whatever they want with it.  I intend to provide a 
driver that only accesses this space.

In past products, I've either had a regular I2C controller (I wrote a full 
kernel I2C driver for the ZF Mach's Access Bus), or a bit-bang interface 
created out of a few chipset GPIO lines (done on all of Octagon's GX1 
designs).

Now, however, in the i815 chipset has an SM Bus.  So, the hardware group 
decided to connect our EEPROM to the SM Bus, along with our standard DS1775 
Temp Sensor, the EEPROM interface on the SDRAM socket, and the clock 
generator.

Our EEPROM is hardwired to address 0x51, as to not conflict with the SDRAM's 
EEPROM at 0x50.  The DS1775 works fine with the lm75 driver, and the click 
generator is something we don't want to give users easy access to anyhow.

The following, I already know:

The group doing octagon's extended BIOS functions (extended int 17 calls) can 
access the device on the SM Bus, so the hardware is capable of the necessary 
commands. (They have discovered, however, they must do a block write, not a 
byte or word write for it to function correctly).

The i801 driver which supports the SM Bus on our board, does not support 
i2c-level commands.  How much trouble will I have if I decide to extend this 
driver to allow at least some i2c-level commands?

Is there some other way I can support the 2-byte address EEPROMs without 
extending the driver to allow i2c-level commands?

Would I be better off to just start over from scratch, write my own bus 
driver, and use my old EEPROM and DS1775 drivers (which are not lm-sensors 
compatable)?  I have permission from the company to submit my work in this 
area to the lm sensors project, which I'd rather do, but if it just doesn't 
make sens, I could start a completely new bus driver.

-- 
-- Sean Fendt
sfendt@octagonsystems.com
Ph: 303 430 1500 Ext 3048
