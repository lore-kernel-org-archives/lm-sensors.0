From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c adapters class
Message-Id: <20040224223843.2fb3394a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

I noticed just today that a number of bus drivers in Linux 2.6.3 are
mostly useless, because they do not define their class to
I2C_ADAP_CLASS_SMBUS. This was the cause of sensors ticket 1501 problem,
as well as a recent report on the mailing-list (same motherboard -> same
bus driver: i2c-ali1535).

The list of bus drivers with no class defined is:
i2c-ali1535.c
i2c-elektor.c
i2c-elv.c
i2c-frodo.c
i2c-hydra.c
i2c-i810.c
i2c-ibm_iic.c
i2c-iop3xx.c
i2c-ite.c
i2c-keywest.c
i2c-philips-par.c
i2c-prosavage.c
i2c-rpx.c
i2c-savage4.c
i2c-sis5595.c
i2c-velleman.c
i2c-via.c
i2c-voodoo3.c
scx200_acb.c
scx200_i2c.c

I guess that the video card adapters don't want I2C_ADAP_CLASS_SMBUS:

i2c-i810.c
i2c-prosavage.c
i2c-savage4.c
i2c-voodoo3.c

But at least these have to use it:

i2c-ali1535.c
i2c-sis5595.c
i2c-via.c

For the rest of them, I don't know.

This raises the following question: what are these classes really for?

So far, all sensor chip drivers, except lm85, do check for
I2C_ADAP_CLASS_SMBUS.

If they are the list of chip types that can be present on each bus, they
we really want to fill all the bus drivers according to what we know
about them. One benefit I can see is limiting the risks of misdetection.

If this is more informative than anything else, and isn't supposed to be
stricly filled, then we should not make chip drivers check it.

As soon as I know what we are supposed to do, I'll prepare a patch in
that sense.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
