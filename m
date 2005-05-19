From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <1082465309.40851c1d2ecec@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
In-Reply-To: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Your lm_sensors-2.8.5/Makefile contains rules for "make install"
> which print a warning:
> *** The depmod command below may generate errors. We are aware of the
> *** problem and are working on a solution.
> This warning applies in particular to the case that $(DESTDIR) != "",
> when there are lots of warnings about files not owned by root (while
> I have seen no warnings in the other case).

Now, the warning was added as we changed internal structures of the i2c
subsystem in a way that makes it not compatible with the 2.4 kernel's
i2c subsystem. The dependencies error are between in-kernel i2c drivers
and our new i2c core.

So it's completely unrelated to the use of DESTDIR. I didn't even know
that it was generating extra errors in this case.


> Running depmod is a typical post-install action and I think there is
> no way to get it right with $(DESTDIR) != "".

Well, in my mind the -b flag was working well enough and was what people
needed. I remember one user cross-compiling modules for an embedded
system those root disk was mounted on the host system. I think that the
-b flag was exactly what the guy wanted.

> Instead of running "/sbin/depmod -a -b $(DESTDIR)" and producing a
> bunch of useless modules.* files, I would like to suggest that you
> omit this and instead print a warning that depmod must be run after
> the modules have been installed in their final location

I would much like to hear distribution packagers on this. Aurelien,
Axel?

> (as far as Iknow most/all Linux distributions run depmod early in
> their boot sequence) as follows:

True, but sometimes you want the modules to be usable directly. And some
distributions run depmod too late in the boot process and some modules
may be needed before that. I agree it's a distribution issue however.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
