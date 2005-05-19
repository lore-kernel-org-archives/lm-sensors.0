From: SBrandt@gmx.de (Sebastian Brandt)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Problem: i2c-proc w/o sysctl support
Message-Id: <001801c1b88e$ee6926e0$68a0a8c0@aachen.sourcery.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Developers,
when I tried to use i2c and lm_sensors, it mysteriously failed for me - of
course, for me only, like usual.
Loading i2c-proc.o resulted in out-of-memory error, with the usual
modprobe/insmod explanation about wrong irqs or io ports. Looking at the
code an debugging, I found out that register_sysctl_table fails. Fittingly,
/proc/sys did not exist. Syctl-support was not compiled into the kernel.

Resume:
If syctl is not supported, i2c-proc.c does not really do anything. Still, it
should either load silently and keep silent or check for CONFIG_SYSCTL=y
when compiling. None of the i2c-modules can live w/o it.

thanks,
Sebastian Brandt

PS.: I hope this is not considered spam ....


/*   If everything seems to be going well, you   */
/* obviously don't know what the hell's going on */
/*      Sebastian Brandt - SBrandt@gmx.de        */
