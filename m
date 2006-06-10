From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 10 Jun 2006 22:27:14 +0000
Subject: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA
Message-Id: <m3lks4k5od.fsf@defiant.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <m34pyyz0e1.fsf@defiant.localdomain>
	<20060609110546.GA26073@jupiter.solarsys.private>
In-Reply-To: <20060609110546.GA26073@jupiter.solarsys.private> (Mark M. Hoffman's message of "Fri, 9 Jun 2006 07:05:46 -0400")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

"Mark M. Hoffman" <mhoffman at lightlink.com> writes:

> SCL and SDA must be pulled high by hardware.  If a driver inits to
> setting them low, that's a bug in the driver.

Thanks for your response.

The question is rather who inits the lines: a) the hw driver,
b) the I2C algorithm driver.

With a) every hw driver has to know how to init them (duplicated
code but there might be positive side).

With b) I2C algorithm driver inits the lines and hw driver
doesn't worry about but it might have some limitations such
as unknown SCL state.

I understand the current case is a) - right?


The other question is _how_ to init the lines. There are 4 possible
hardware initial conditions:

  SCL SDA
a)  0   0 (outputs zeroed by default)
b)  0   1 (uncommon but may be left in this state by previous operations)
c)  1   0 (ditto)
d)  1   1 (I/O lines configured as input by default)

The internal state of devices connected to the bus is potentially
unknown. Some implementations just start with STOP to eliminate
this problem, I don't know what Linux driver is supposed to do.

(Other implementation I know are rather specialized and thus they
know their hardware init state, Linux I2C algorithm handles many
devices with potentially different initial state of hardware lines).


To summarize questions:
- is it the hw driver who has to init the bus
- how to init the bus (depending on init state)
-- 
Krzysztof Halasa

