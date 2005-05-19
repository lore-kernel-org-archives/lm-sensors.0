From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors without module support
Message-Id: <20041222153919.3433cf74.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41C96B89.7050208@edeca.net>
In-Reply-To: <41C96B89.7050208@edeca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Is it possible to use lm-sensors without module support in the kernel?

Yes it is. However, this is not the most usual way to do, and has known
problems (but workarounds exist).

First, you are invited to only include drivers you know you need. If you
include all i2c bus drivers and all i2c chip drivers, your kernel will
be very slow to fire up, and you are also likely to have problems
because some busses are undetectable (most non-PCI), and i2c chip
probings are rather slow. Also, some chips are supported by several
drivers, and some chips are easily misdetected as other ones, so you are
likely to have misdetection issues if you include everything.

If you only include the bus drivers and chip drivers you need, it should
work OK, except that some of our documentation and scripts assume
modules are used, so you have to mentally correct.

> sensors-detect exits immediately with "couldn't open /proc/modules". 
> I am using 2.6.7 and have compiled i2c and the relevant code for my
> sensors (an SiS 961 and Winbond chip) into the kernel.

This is a known bug, reported and fixed back in July 2004 by Andras
Bali. Versions 2.8.8 and up of lm_sensors don't have the problem
anymore.

Note that sensors-detect will not work properly with a kernel where chip
drivers are built-in, because it can only probe I2C chips that are not
in use by a chip driver. The suggested approach would be in two steps:

First, build a kernel with the only the bus driver you need (i2c-sis96x,
obviously, and you should include i2c-isa as well). When running this
kernel, run sensors-detect. It should work OK, and will tell you what
chip driver you need. Recompile with this chip driver built-in and
you're done.

Of course if you already know for sure what chip driver you need, you
can skip step 1 (in which case you don't need sensors-detect at all).
Beware that we have 3 different drivers for Winbond chips (4 if you
consider that the ASB100 is a Winbond clone).

> I don't wish to enable module support on the machine as it's a server
> and I'd like to keep that extra hole closed up.

No problem, I understand. Just keep in mind that not so many people do
what you are trying to do so you might find issues (just like you had
with sensors-detect). Please report them to us so that we can fix them!

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
