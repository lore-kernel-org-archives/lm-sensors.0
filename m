From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 05 Mar 2008 14:28:10 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <20080305152810.22cb8818@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 05 Mar 2008 11:31:30 +0100, Stefan Sassenberg wrote:
> Jean Delvare wrote:
> > Any message in the kernel logs when you modprobe w83627hf? Does the
> > modprobe itself fail or succeed? If it fails, what's the error message?
>
> When I modprobe, a line is added to /var/log/dmesg:
> w83627hf: Found W83627THF chip at 0x290
> There's no message on stdout or stderr.

So the kernel itself seems to be happy...

> (...)
> > Please compare /proc/ioports between a system where the w83627hf driver
> > works for you and a system where it doesn't. I'd suspect a resource
> > conflict.
> Using the 2.6.21.5 kernel:
> 0295-0296 : pnp 00:09
>    0295-0296 : w83627hf
> 
> Using the 2.6.23.14 kernel:
> Before modprobing:
> ...
> 0295-0296 : pnp 00:09
> ...
> 
> After modprobing:
> ...
> 0295-0296 : w83627hf
>    0295-0296 : pnp 00:09
>      0295-0296 : w83627hf
> ...

And this looks OK as well. My first guess was wrong, let me suggest
something else...

I didn't notice at first but you wrote you were using lm-sensors 2.9.1.
That's pretty old. In kernel 2.6.22 the w83627hf driver was converted
from an i2c-isa driver to a platform driver (together with many other
hwmon driver, as we were finally getting rid of i2c-isa.) Support for
platform drivers was added to lm-sensors only in 2.10.0. So, no
surprise it doesn't work for you. For a kernel >= 2.6.22, I would even
recommend lm-sensors >= 2.10.3.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
