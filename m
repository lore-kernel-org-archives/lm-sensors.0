From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 24 Jun 2005 00:33:27 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] max6875: new i2c device driver
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9099BFF5@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

First off, thanks for taking the time to review the code.

[...]
> What are the typical accesses to the interface files in your case?

The configuration is written once at board-level check-out.
This consists of about 20 EEPROM writes scattered across the 70
registers.

The user EEPROM, which contains the serial/model numbers, is written at
top-level check-out. 
(That's when the board is put in the nice black box with a nice stamped
aluminum serial number plate.)

After that, the user EEPROM is read at power-up.
The configuration stuff is never accessed again.

[...]
> But in fact I am also wondering what the point of this driver is. I'm
> not happy with a binary file containing the full set of registers,
this
> is awfully not convenient to use. Imagine the mess it would be if all
> i2c drivers would do the same... Binary files in sysfs are supposed to
> be an exception, not the rule.
> 
> If this is done this way because you simply flush a blob into the
eeprom
> once as startup, then a userspace tool relying on i2c-dev would have
> been just as efficient, and more flexible.

I have to agree with you there.
I had to write a tool to program the device anyway, so it would be
trivial to use i2c-dev instead of the sysfs files.

Would it be acceptable to axe register access entirely and only provide
an interface to the user EEPROM?
I would be happy with read-only access to the EEPROM.

Thanks,
Ben

