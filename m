From: sfendt@octagonsystems.com (Sean S Fendt)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: I2C chip driver functionality check -- help?
Message-Id: <200402171249.i1HCnJQ29795@sfendt.octagonsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To anyone who may be able to help.

Sorry if this is a repeat, but I have not seen any response, and I'm not sure 
the message got to the list, and this is the last remaining issue for my 
linux package.  So just in case it did not...

I'm writing drivers for custom hardware on Octagon System's line of embedded 
PCs. ?I'm busy with an I2C bus and chip driver set for our GX1 based 
products, using kernel 2.6.2.

A simple (I hope) question:
Why doesn't bit_func() in i2c-algo-bit.c not return with the I2C_FUNC_I2C bit 
set?

My chip driver needs to use i2c_master_send() and i2c_master_recv(), and I 
cant' find any other functionality bit that makes sense. ?If I skip the 
functionality check, it seems to work. ?Did I miss something in the 
documentation, that is am I checking for the wrong functionality bit(s)?

Background:

The I2C bus is just a couple of GPIO leads from the 5530 companion part.  The 
custom driver using the bit-bang algorithm seems to be working fine.

The custom chip driver is for a 4KByte EEPROM, of which 2KB is available to 
the user for static data storage (the other is used to store bios settings 
without need for a battery, and for video configuration and system 
diagnostics and test).  The driver gives read-write access to the user half 
of the device.  This too, seems to be working fine, except for the 
check_functionality call, which is temporarily commented out.

Both of the above will be released under the GPL, and ship with full source 
in our linux development kits.  They are available to the project if there is 
any interest.  Presently this combination works with 3 of Octagon's SBCs and 
are expected to support at least one more product currently in development.

Thanks in advance for any thoughts or suggestions.
-- 
-- Sean Fendt
sfendt@octagonsystems.com
Ph: 303 430 1500 Ext 3048
