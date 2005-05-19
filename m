From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040419191250.0f403a89.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > As a side node, I don't expect people to run sensors-detect on
> > video-dedicated i2c busses...
> 
> That is only one part of the problem.  The sensor modules itself do
> probing as well.  So if sensors-detect found a sensor on your smbus
> and adds the driver module to the config, that driver module will
> look for its sensor on all i2c adapters registered in the system,
> i.e. also on TV cards.

Agreed, but this is a different problem IMHO. Michael Hunold is working
on extending the .class usage in the kernel. I think it's a good idea, I
was just waiting for Greg to give us his opinion on whether we should
use an extra flag or make the check mandatory.

> Rather than mucking with address lists I'd prefeare to export the
> .class field to userspace somehow (ioctl? sysfs?) so sensors-detect
> can see and use it as well.  That avoids any address clashes in the
> first place.

Sysfs. Yes, that's a good idea as well, and was already discussed on the
LKML. But let's handle each problem in its time.

My proposal of address ranges is admitedly a trick, just meant to
prevent about any form of eeprom corruption (although I of course put
the stress on the AT24RF08 because we know how bad it is). It is not
meant as a solution to prevent any kind of bus or video chips hangs. For
this, the .class selection mechanism is what we want. Also note that the
.class thing alone would not solve the eeprom corruption issues, since
they usually live on the same bus as the hardware monitoring chips.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
