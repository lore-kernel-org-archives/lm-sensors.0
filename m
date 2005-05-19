From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Why this output?
Message-Id: <B9F93E56.4423%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F92C49.4411%zdavatz@ywesee.com>
In-Reply-To: <B9F92C49.4411%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 14.11.2002 11:42 Uhr, "Jean Delvare" <khali@linux-fr.org> wrote:

> Ok, so the problem is real. You may try "depmod -ae" to display which
> symbols are unresoled, it may be an interesting clue.
Yes this gives me:
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-bf2.4/kernel/drivers/i2c/dmi_scan.o
depmod:         iounmap_Rsmp_5fb196d4
depmod:         __ioremap_Rsmp_9eac042a
depmod:         printk_Rsmp_1b7d4074
depmod:         kmalloc_Rsmp_93d4cfe6
And a lot more...

> I do not use Debian, sorry.
Ok. I believe they are not available.

> One important thing to notice is that i2c and lm_sensors will use
> information found un /usr/src/linux to compile well and choose where to
> install the modules. If the kernel you are running doesn't match the
> sources in /usr/src/linux, then it explains why you're having trouble.
> The next release (2.6.6) of i2c and lm_sensors should be easier to
> install because it will install for the running kernel regardless of
> what /usr/src/linux contains or points to (which has other drawbacks
> IMHO, but would probably help more that hurt).
When can I test version 2.6.6?

Thanks for your help and hints.

Zeno
