From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 22:21:45 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <20051007222019.23b2c3ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stig,

> Thanks for the new patches.  I tested them and they appear to work.  
> However, the problem with dev_dbg message prefixes early in driver 
> initialisation is still there:
> 
> i2c-elektor: found cy82c693, config register 0x47 = 0xe1
> i2c-elektor: found API UP2000 like board, will probe PCF8584 later
> i2c-elektor: registers 0xe0000 remapped to fffffd00000e0000
>   : Write fffffd00000e0001 0x80
>   : Read fffffd00000e0001 0x00
>   : Write fffffd00000e0000 0x55
>   : Read fffffd00000e0000 0x55
>   : Write fffffd00000e0001 0xA0
>   : Read fffffd00000e0001 0x20
>   : Write fffffd00000e0000 0x18
>   : Read fffffd00000e0000 0xF8
>   : Write fffffd00000e0001 0xC1
>   : Read fffffd00000e0001 0x81
> i2c-algo-pcf.o: deteted and initialized PCF8584.
> i2c_adapter i2c-0: Registered as minor 0
> i2c_adapter i2c-0: registered as adapter #0
> i2c_adapter i2c-0: found device at 0xe0000
> 
> We don't get the driver name until we call i2c_add_adapter in 
> i2c-algo-pcf.c.

I get it now. I had missed the fact that pcf_isa_{set,get}byte would be
called during the initialization step.

> Should we revert the dev_dbg statements to pr_debugs for device byte
> read/writes?  That doesn't sound very consistent though...

That's the only option as far as I can see. I'll do that.

Thanks,
-- 
Jean Delvare
