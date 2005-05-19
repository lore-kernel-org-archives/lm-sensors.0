From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <2bNTfKEv.1098087500.8785820.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Philip,

>How does the multiplexing work on the S4882 motherboard?  Is it
>controlled by GPIO pins or is there an I2C mux chip on the I2C bus?

I2C mux chip (Philips PCA9556) at 0x18. The mux chip controls two Philips
PCA9516 chips, for a total of 8 additional branches.

>What devices are on the different branches of the I2C bus?

Four branches have one National Semiconductor LM63 monitoring chip (2
temperatures, 1 fan), four branches have up to 4 memory module SPD
EEPROMs. In my modified version of the i2c-amd756 driver, I have
"merged" the branches by pair so that each virtual bus corresponds to
one CPU. This makes things more straightforward for the user, and also
reduces the mux operations. It would be great if the solution we come up
with would preserve that.

The board additionaly features an ADM1027 chip and a W83627HF chip.
Running "sensors" there when all modules are loaded is truly
impressive :)

>If we could come up with a "wrapper" model of an i2c bus driver for
>these mux situations that seems to me to be the ideal.  Such a wrapper
>would capture the knowledge of how to mux the bus and what branch of the
>mux is currently selected.  It would register multiple "virtual" i2c
>busses and mark the "parent" i2c bus as no-probe and in general attempt
>to prevent anything from accessing the parent bus directly.

This pretty much matches what Mark M. Hoffman suggested to me on IRC
yesterday. Great you seem to agree on the proper way to do it ;) I
didn't read the original virtual bus implementation proposal in enough
details to say if it was similar or not.

>Then our normal sensor drivers would just operate on the "virtual"
>busses directly and the wrapper would take care of changing the mux as
>required in an *atomic* way so that accesses are made to the different
>busses correctly.

Agreed. This isn't very different from what my current code does, except
that I didn't separate the parent bus and the trunk bus. Instead, the
parent bus is replaced by the trunk+mux bus before it is registered.
This is slightly more efficient in case i2c clients are already loaded,
but I don't think this should stop us.

That said, the approach you and Mark propose will probably require some
changes to the i2c core, so I don't think it belongs to lm_sensors CVS
but only to linux 2.6, at least for now. For this reason, I plan to
commit my changes to the i2c-amd756 driver to CVS. I hope to get it in
the form of a composite module or something similar, so as to address
Mark's fear for the lack of maintainability. If the solution planed for
linux 2.6 isn't too intrusive (the minimum requirement is that it
shouldn't alter any of the i2c_{adapter,algorithm,client,driver}
structures nor prototypes of existing interface functions) and after it
has been well tested, I may still consider porting it back to CVS and
update the i2c-amd756 driver to make use of it.

Thanks,
Jean
