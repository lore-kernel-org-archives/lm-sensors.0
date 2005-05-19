From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Tyan S4882 support complete
Message-Id: <20041115231910.2bd44311.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Just wanted to let you know that Linux 2.6.10-rc2 is out, and had full
support for the National Semiconductor LM63 and the specific SMBus
multiplexing needed by the S4882. After some discussions and changes to
my code, my drivers were accepted and merged. Thus the S4882 is
officially supported by Linux 2.6 since today.

I've also commited all my changes to lm_sensors CVS, so hardware
monitoring on the S4882 is also fully publicly supported on 2.4 kernels
since yesterday.

Enjoy :)

The only missing thing is the SMBus multiplexing driver autoloading. You
will have to manually load the i2c-amd756-s4882 driver to get
multiplexing to work. Since the only way to detect the S4882 is through
DMI data and this method is not implemented for x86_64, it cannot be
done now. It could be done when the S4882 is used with an i386 kernel,
but I guess nobody is interested in doing this anyway.

DMI data gathering for x86_64 will probably never be implemented in 2.4
kernels (at least it won't be accepted in the main kernel tree).
However, it could be implemented in 2.6, and if it were, we could add
autoload support to the s4882-specific driver. There don't seem to be
any interest in that (which is why it was never developed) except for
the S4882, so if we want it we'll have to do it ourselves.

Unfortunately, developing DMI data gathering for x86_64 is a somewhat
tricky task, not the kind that can be done remotely, and we do not have
an x86_64 system available for kernel development (as far as I know at
least.)

If Tyan or Harddata (or possibly both together) is interested in me
adding the autoload feature, please consider the donation of an x86_64
system. It wouldn't have to be full featured and shiny new, even an
older system would do providing it's x86_64 and working fine. It would
also be a nice way to reward and support the lm_sensors project in
general, and support linux on the x86_64 architecture too (if I own such
a machine myself, it better be well supported.)

As a final note I want to thank Alex again for moving from home to work
on Sundays several times when I screwed up his test system's kernel
while remotely testing my kernel code :')

Thanks all.

-- 
Jean Delvare
http://khali.linux-fr.org/
