From: marekm@amelek.gda.pl (Marek Michalkiewicz)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Matrox G400DH + lm_sensors problem
Message-Id: <20030621231835.GB528@alf.amelek.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030620001151.GA5184@alf.amelek.gda.pl>
In-Reply-To: <20030620001151.GA5184@alf.amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 21, 2003 at 12:36:26PM -0400, Mark D. Studebaker  wrote:
> If you have all the chip drivers compiled in,
> each one will scan each i2c bus as it is registered.
> We do not recommend compiling-in all the chip drivers, keep them as modules.

I have a completely non-modular kernel (CONFIG_MODULES=n) - I find it
easier that way (compiling the kernel on the faster box, then copying
just a single kernel image file to the slower one).  Another advantage
of this is that the recent ptrace/kmod exploit didn't work here ;)

Anyway, I don't have all the chip drivers compiled in, just the ones
I have in my machines (W83781D and VIA686A), which don't even have
to be accessed through I2C (ISA/PCI access works fine).  Perhaps there
should be a way for an I2C bus driver like i2c-matroxfb to exclude
itself from these automatic scans for all possible chips?  After all,
we know exactly what chips are on the Matrox I2C buses.

The good old G400 does not run very hot - but some of the new hot
(literally) graphics cards could really have temp. and fan sensors ;)

Could at least part of this I2C bus scanning be moved to user space
in the future?  There could be a config file to determine which
I2C buses should be scanned for which chips, to avoid conflicts.
If auto-probing on kernel startup is disabled, there should be no
problem with even all chip drivers compiled in (RAM is cheap...).
I imagine that chips could be registered/unregistered with some
ioctl calls on an open I2C device file descriptor.

One unrelated question - I have MSI MS-6368L v 5.0 motherboards
(with VIA VT82C686B), and the manual (bottom of page 2-17) says:

"CPU Fan supports the fan control. You can install the PC Alert
utility that will automatically control the CPU Fan speed according
to the actual CPU temperature."

This suggests that the VIA chip has a fan PWM output, but I could find
no mention of this in the lm_sensors docs.  Do you have any more info
on this?  Or is this the typical "VIA won't release docs" problem?

Thanks,
Marek
