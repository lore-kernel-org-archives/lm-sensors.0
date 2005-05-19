From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: nForce2
Message-Id: <20030625153454.05e91b22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Sea1-F157XvPIPKH5jt0000cb5f@hotmail.com>
In-Reply-To: <Sea1-F157XvPIPKH5jt0000cb5f@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a Shuttle SN41G2 XPC that uses the nForce2 chipset. I have
> installed Redhat Linux 9 and wish to use gKrellm for hardware
> monitoring, but the lm_sensors that comes bundled with Redhat 9 won't
> detect any of the sensors on my motherboard. I have read on your site
> that CVS version 2.8.0 has support for the nForce2 motherboards but
> all that is written in the changelog is:
> 
> Module i2c-nforce2: New
> 
> Does this mean it is still in development or it is a stable working
> version? I look forward to your reply as I really wish to monitor my
> cpu temps in my new system.

The driver really exist, but hasn't been extensively tested. We had both
positive and negative (to say the less) feedback, so feel free to give
it a try, but expect your mileage to vary.

You'll probably have difficulties too, because Gkrellm depends
(package-wise) from lm_sensors which itself could depend form i2c
(unless Red Hat integrated it into the kernel). If you install
lm_sensors from CVS, you'll need i2c from CVS too (tag lk2-4) (which in
turn may conflict with your kernel if i2c was built-in). And the new
library isn't compatible with the old one, so the Gkrellm package won't
work. All this mean that if you want to try CVS, you'll have to remove
all your packages that deal with lm sensors in any way, and install
everything from sources.

This would of course be very welcome since we need testers for this new
driver, but a reasonable skill with this kind of stuff is required if
you don't want to break your system down within a hour.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
