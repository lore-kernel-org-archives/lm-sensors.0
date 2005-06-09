From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Jun 2005 21:30:09 +0000
Subject: [lm-sensors] Re: [PATCH 1/2] Add support for Maxim/Dallas
Message-Id: <20050609212933.2fa44d62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42A0CD46.60300@mvista.com>
	<20050603214653.GA15314@gate.ebshome.net>
	<42A0D714.1050601@mvista.com>
	<20050609192551.76b103ea.khali@linux-fr.org>
	<42A89338.209@mvista.com>
In-Reply-To: <42A89338.209@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: LM@ozlabs.org, linuxppc-embedded@ozlabs.org, Sensors <lm-sensors@lm-sensors.org>

Hi Mark,

> I interpreted the doc the same way Randy did when I did the m41t00
> chip  code.  Also, Mark Studebaker seemed to support that
> interpretation in  this email:
> http://archives.andrew.net.au/lm-sensors/msg29325.html

I am not discussing the fast that using basic SMBus commands increases
the number of system the driver will be usable on. This is quite
obviously true, and I am fine with using this when there is no
performance drawback.

However, in the case of the DS1374, reading the registers as a block
would make the driver *much* faster and more simple. This has to be
considered, especially if the DS1374 chip is found on a limited number
of systems.

If you think the documentation should be updated to reflect that better,
well, patches are welcome ;)

> I suppose the best thing to do is check if the adapter is a true i2c 
> ctlr (something like: i2c_check_functionality(adapter, I2C_FUNC_I2C)) 
> and base the cmds used on that.
> 
> We can do something similar with I2C_FUNC_SMBUS_READ_I2C_BLOCK & 
> I2C_FUNC_SMBUS_WRITE_BLOCK_DATA to check if we can use the smbus
> block cmds too, correct?

There is actually no benefit in checking for true I2C, since the
commands you would then build would be exactly I2C_FUNC_SMBUS_READ_I2C
and I2C_FUNC_SMBUS_WRITE_BLOCK_DATA. Better check for these directly, as
some non-I2C masters will support them (especially the second, the first
one is only rarely found). If both functions are supported, go with
this. If not, either fallback to the current code, or drop this code and
state that this isn't supported (I'd do that). If it happens that this
support is ever needed, it can be added back at that time - but that
time may never actually come.

Thanks,
-- 
Jean Delvare
