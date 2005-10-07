From: lmsensors@lizardlogic.co.uk (Stig Telfer)
Date: Fri, 07 Oct 2005 15:30:46 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <96426a60ace86bfbf59f8f566dfac267@lizardlogic.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean -

Thanks for the new patches.  I tested them and they appear to work.  
However, the problem with dev_dbg message prefixes early in driver 
initialisation is still there:

i2c-elektor: found cy82c693, config register 0x47 = 0xe1
i2c-elektor: found API UP2000 like board, will probe PCF8584 later
i2c-elektor: registers 0xe0000 remapped to fffffd00000e0000
  : Write fffffd00000e0001 0x80
  : Read fffffd00000e0001 0x00
  : Write fffffd00000e0000 0x55
  : Read fffffd00000e0000 0x55
  : Write fffffd00000e0001 0xA0
  : Read fffffd00000e0001 0x20
  : Write fffffd00000e0000 0x18
  : Read fffffd00000e0000 0xF8
  : Write fffffd00000e0001 0xC1
  : Read fffffd00000e0001 0x81
i2c-algo-pcf.o: deteted and initialized PCF8584.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-0: found device at 0xe0000

We don't get the driver name until we call i2c_add_adapter in 
i2c-algo-pcf.c.  Should we revert the dev_dbg statements to pr_debugs 
for device byte read/writes?  That doesn't sound very consistent 
though...

>> * Jean: use of val & 255 in printk statement in pcf_isa_setbyte() - I
>> think this is actually required because parameter val is an integer
>> quantity and could have been sign-extended?  I would prefer to change
>> the function parameter to u8, but this violates the types of struct
>> i2c_algo_pcf_data.
>
> The "& 255" is done in the debug printk only, iowrite8 is still called
> with val unmasked, so if the masking actually did something, something
> bas is happening, and the debug trace won't ever show it.
>
> Looking at i2c-algo-pcf, it's quite clear that val will always fit in
> an u8, so the masking is actually needless.

Perhaps the author's original intention would have been better 
described by casting val as (u8)val.  This avoids any sign-extended 
mangling from implicit size conversions, like this one:

	char val=0x80;
	printf("Write 0x%02X\n", val);

As you say, it doesn't matter for this case because our only caller 
(i2c-algo-pcf) does not generate arguments to pcf_isa_setbyte in this 
way.

Best wishes,
Stig

