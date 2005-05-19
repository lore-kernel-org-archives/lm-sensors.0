From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: I2C chip driver functionality check -- help?
Message-Id: <4035880F.6090000@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200402171249.i1HCnJQ29795@sfendt.octagonsystems.com>
In-Reply-To: <200402171249.i1HCnJQ29795@sfendt.octagonsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great question.

I just checked our sources and couldn't find any usage for I2C_FUNC_I2C except for
the i2c-iop3xx driver supporting it.
Not a single chip driver checks it.

I can't say for sure what the intent was for I2C_FUNC_I2C.

But I do know that the preferred method for chip drivers,
and the method that can take advantage of the functionality bitmask,
is to use the i2c_smbus_xxx calls for all accesses.
Those capabilities are exported as I2C_FUNC_SMBUS_xxx bits.

The advantage is that they will work with both low-level i2c
bit-banging drivers, like i2c-algo-bit, and high-level
PCI SMBus drivers. That's because i2c-core contains
an "emulation layer" such that calls get
converted as neccessary to work with the particular adapter.

Then you can check for the specific operations you require with the functionality,
and it will work on any adapter that supports it, whether smbus or i2c.

The low-level i2c_master_xxx calls shouldn't be necessary unless you are
doing i2c-specific things that i2c-core doesn't provide exported as
a i2c_smbus_xxx call. And if you do need something like that,
you may want to discuss it with us, perhaps it should be in i2c-core.

If you must use master_xfer, (i.e. it must be a low-level i2c adapter),
the correct method of detecting that capability is
	if(adapter->algo->master_xfer) {
		/* you're good */
	} else {
		/* must be an smbus adapter */
	}
i.e., check that the function is non-null.

let us know if you have other questions.

mds
		



Sean S Fendt wrote:
> To anyone who may be able to help.
> 
> Sorry if this is a repeat, but I have not seen any response, and I'm not sure 
> the message got to the list, and this is the last remaining issue for my 
> linux package.  So just in case it did not...
> 
> I'm writing drivers for custom hardware on Octagon System's line of embedded 
> PCs.  I'm busy with an I2C bus and chip driver set for our GX1 based 
> products, using kernel 2.6.2.
> 
> A simple (I hope) question:
> Why doesn't bit_func() in i2c-algo-bit.c not return with the I2C_FUNC_I2C bit 
> set?
> 
> My chip driver needs to use i2c_master_send() and i2c_master_recv(), and I 
> cant' find any other functionality bit that makes sense.  If I skip the 
> functionality check, it seems to work.  Did I miss something in the 
> documentation, that is am I checking for the wrong functionality bit(s)?
> 
> Background:
> 
> The I2C bus is just a couple of GPIO leads from the 5530 companion part.  The 
> custom driver using the bit-bang algorithm seems to be working fine.
> 
> The custom chip driver is for a 4KByte EEPROM, of which 2KB is available to 
> the user for static data storage (the other is used to store bios settings 
> without need for a battery, and for video configuration and system 
> diagnostics and test).  The driver gives read-write access to the user half 
> of the device.  This too, seems to be working fine, except for the 
> check_functionality call, which is temporarily commented out.
> 
> Both of the above will be released under the GPL, and ship with full source 
> in our linux development kits.  They are available to the project if there is 
> any interest.  Presently this combination works with 3 of Octagon's SBCs and 
> are expected to support at least one more product currently in development.
> 
> Thanks in advance for any thoughts or suggestions.
