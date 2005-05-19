From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <20021114114206.534e3424.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks for the hint. Something does happen:
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-pcf.o
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-ali1535.o
> 
> And a lot more messages like this one.

Ok, so the problem is real. You may try "depmod -ae" to display which
symbols are unresoled, it may be an interesting clue.

> Do you know where to get the Kernel-Source of Debian 2.4.18-bf2.4

I do not use Debian, sorry.

> I think I need that source and then I will get one step further.

One important thing to notice is that i2c and lm_sensors will use
information found un /usr/src/linux to compile well and choose where to
install the modules. If the kernel you are running doesn't match the
sources in /usr/src/linux, then it explains why you're having trouble.
The next release (2.6.6) of i2c and lm_sensors should be easier to
install because it will install for the running kernel regardless of
what /usr/src/linux contains or points to (which has other drawbacks
IMHO, but would probably help more that hurt).

> Thanks for your help and hints.
You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
