From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <B9F9364E.4419%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 14.11.2002 11:11 Uhr, "Jean Delvare" <khali@linux-fr.org> wrote:

> My first guess is that you forgot to run "depmod -a" after installing
> lm_sensors. So, try to run (as root) "depmod -a" and see what happens.
> If nothing happens, it's alright and you should be able to run
> sensors-detect.

Thanks for the hint. Something does happen:
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-bit.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-algo-pcf.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/i2c-ali1535.o

And a lot more messages like this one.

Do you know where to get the Kernel-Source of Debian 2.4.18-bf2.4

I think I need that source and then I will get one step further.

Thanks for your help and hints.

Zeno
