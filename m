From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: two questions about w83792d.c for linux-2.4
Message-Id: <l4hMHkYD.1108728747.4308840.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190A90@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> I have two questions about W83793D driver for linux-2.4
> (1) The "set" lines in /etc/sensors.conf w83792d part for voltage
> do NOT work! While all the "set" lines for fan and temperature limit
> can work. I can't find the reason.
>
> The more strange thing is that, under linux-2.6, the "set" lines for
> voltage CAN work!
>
> I attached the /etc/sensors.conf w83792d part in the end of this mail,
> for your reference.

The file doesn't look too bad, except for the fact that multipliers are
somewhat unusual. Typically voltages are being attenuated by resistors,
so the value we want "sensors" to report are greater than those
measured by the chip, and the multipliers in the configuration file are
greater than 1. Here you have multipliers less than 1 almost everywhere.
I'll have to take a look at the datasheet and code again to understand
why it is.

If the 2.6 driver works OK then the problem has to be in the 2.4 driver
itself. Can you please show the relevant function of the driver,
together with the functions and macros it might call?

Or we can have your driver commited as-is and have it fixed afterwards,
at your option.

> (2) The file kernel/include/sensors.h should be auto-generated, instead
> of being edited manually. But I don't know how to auto-generate the 792
> related codes into this file.
>
> Now I have to manually copy the codes such as
> #define W83792D_SYSCTL_IN0 1000
> #define W83792D_SYSCTL_IN1 1001
> from my w83792d.c, because if I don't copy these codes, there will be
> compile error.
>
> Could you tell me how to auto-generate the file
> kernel/include/sensors.h?
> Is there any script I have to run?

No there is no script to run. All you have to do is put two comment lines
around the SYSCTL definitions in the driver itself. Our Makefile system
has a rule that automatically parses all chip drivers and extract the
lines between these comment lines from all driver, and add them to
sensors.h. These lines are:

/* -- SENSORS SYSCTL START -- */

/* -- SENSORS SYSCTL END -- */

See all other chip drivers, they have them. It is important that you copy
exactly these comments, or the build process won't detect the SYSCTLs
properly. Also note that the driver itself has to be placed in
kernel/chips and might even need to be properly declared into
kernel/chips/Module.mk (if "make" builds the driver properly, it must
be OK).

Hope that helps,
--
Jean Delvare
