From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 10 Jun 2005 03:52:57 +0000
Subject: [lm-sensors] Linking Problem
Message-Id: <20050610015215.GB23717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <42A8906C.10707@ul.ie>
In-Reply-To: <42A8906C.10707@ul.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Gearoid:

* Gearoid Murphy <gearoid.murphy@ul.ie> [2005-06-09 19:54:36 +0100]:
> Hi all,
>    This should be trivial for everyone here. I'm trying to write a user 
> space program i2c device driver. I access the device using /dev but when 
> I try to use functions included in the i2c-core my compiler tells me its 

The functions in i2c-core are for the use of in-kernel drivers (including
kernel modules).  Userspace cannot use them directly.

> getting an undefined reference. I know this is because I'm not including 
> the proper libraries. How do i get around this?. I've tried explicitly 
> including the i2c-core.ko in the gcc compile command but this spews out 
> errors about other undefined references.

Err... no way that could be expected to work.  You can't just link an
object or fragment of the kernel with a user program.

>    All I want to do is successfully communicate to an SRF08 sonar using 
> the i2c parallel port adapter for the ELV adapter (built using the 
> schema in the i2c docs). I'm using debian 2.6+ and am completely at my 
> wits end.

Get the lm_sensors2 package.  Install just the userspace part of it.
That will give you, among other things, /usr/local/include/linux/i2c-dev.h.
Use that in your user program (#include <linux/i2c-dev.h>).  All the
code in that header is inline, so you won't need to link anything else.
The functions are similar to those in i2c-core.

OR, if you're familiar with Python, I wrote a set of Python bindings
for I2C/SMBus access.  You can find them here:

http://members.dca.net/mhoffman/sensors/python/20050122/

Copy those two files somewhere, then 'python ./setup.py --help-commands'.
(I really should include a readme.txt)

Feel free to ask more questions; good luck with your project.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

