From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Aug 2005 16:42:16 +0000
Subject: [lm-sensors] Backport to 2.4 kernel of lm77 to use in wrap board
Message-Id: <eacspnat.1123684476.4919580.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FA0A66.1050504@infovia.com.ar>
In-Reply-To: <42FA0A66.1050504@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Beat,

On 2005-08-10, Beat Meier wrote:
> I'm trying to backport lm77 to kernel 2.4.
> lm77.c compiles :-) but it is not recognized on the wrap board.

Just getting it to compile might not be sufficient. There are some
significant changes betwen 2.4 and 2.6 as far as hardware monitoring
drivers are concerned. But if you copy what is done in lm75.c for
example, that should work.

If you get it to work, please send us the modified lm77.c file so that we
can add it to lm_sensors.

> The lm77 on wrap is accessible on secondary I2C bus at address 90h.
> How can I access it there?

You certainly mean 48h.

You need a bus driver for the I2C bus the LM77 chip is connected to.

> I've seen in a thread that in 2.6 you must use scx200_acb (because no
> userspace support).

This is unrelated. The lack of user-space support means that you won't
see the data related to the LM77 chip when running "sensors".
User-space doesn't replace the bus driver in any way.

> What can I use in 2.4 kernel so the lm77 is acessible?

Linux 2.4 has the scx200_acb driver too, if this is what you need. It's
not distributed with lm_sensors, it is part of the official kernel tree.

You can use sensors-detect and/or i2cdetect to make sure your i2c bus is
properly set up before even trying the lm77 driver.

> To get/set temperature do I need userspace support?

You don't need it, it's only more convenient.

--
Jean Delvare
