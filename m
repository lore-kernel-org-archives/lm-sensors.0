From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Follow up for Ticket 1538
Message-Id: <1075122354.401510b272044@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
In-Reply-To: <LAECJBKLNEJMMONPNMGPGEFPCBAA.pierre.lamon@epfl.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Reply from support:
> > we have just submitted a new parport driver to 2.6 that
> > consolidates all the previous parallel port drivers.
> > You may wish to try it.

Just one thing: the new driver does not replace *all* previous drivers.
It replaces simple, parallel-port-pins-bashing drivers
(media/video/i2c-parport, i2c-elv, i2c-velleman and i2c-philips-par),
but not more complex drivers involving bidirectional parallel ports or
extra chips (i2c-pport and i2c-pcf-epp). i2c-pport might be integrated
someday. i2c-pcf-epp will never be, it's too different so it wouldn't
make sense.

> 1) Could I take the latest cvs version of your i2c directory and copy
> the files into the linux-2.6.1 directory (I'm using 2.6.1)? What is
> the best way to update the kernel sources?

It won't work. Drivers for linux 2.4 and linux 2.6 are different, you
can't mix them. If you need a driver that hasn't been ported yet,
you'll have to port it first.

> 2) Should I use i2c-pcf-epp for the following circuit? Is this the
> right driver to use? Which i2c modules should be insmoded at the same
> time? http://www.voxel.at/prj/i2c/images/i2c/i2c_adap.gif

I am no electronics guy, but I think that you need i2c-algo-pcf +
i2c-pcf-epp. The later hasn't been ported to Linux 2.6 yet. I suggest
that you first try with a 2.4 kernel. If it turns out to be what you
need, or only needs little change to work, and you really want Linux
2.6, then you'll have to port the driver. It's one of the latest bus
drivers still missing so your help will be welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
