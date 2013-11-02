From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 02 Nov 2013 19:24:35 +0000
Subject: Re: [lm-sensors] Patching driver for it8603e chip
Message-Id: <52755173.906@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5274CACD.60600@fastwebnet.it>
In-Reply-To: <5274CACD.60600@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/02/2013 02:50 AM, Xavier Giannakopoulos wrote:
> Hello all,
> thanks a lot for the great work done on sensors and device support for linux.
> I am trying to get up-to-date on the support for a device  embedded in the Asus board F2A85-M, which has a new ITE chip, the it8603e.
> I found a patch for the it87.c file, but the patch does not correspond to the latest version of the code I found (http://khali.linux-fr.org/devel/lm-sensors/drivers/it87/)
>
> Here is the article for patch
> http://article.gmane.org/gmane.linux.drivers.sensors/31372/match=it8603
>
> Can someone update me about the latest situation, was the patch included at some point, or is there a new version of the patch for the latest code?
> Thanks a lot, and best greetings,
> xavier g.
>
The patch was not included, and it won't be since it has too many problems.

As mentioned in the other thread, the chip appears to be built specifically for ASUS,
and neither ITE nor ASUS are willing provide datasheets which would enable us to add
support for the chip into Linux.

ASUS is an interesting company. On the one side, they claim to support Linux
on their web site, but when contacting technical support they state that
they don't, and that they won't even provide chip datasheets. From what I heard,
that used to be different. No idea why they changed their policy.

Not that we would ask for active support, but passive support (ie providing chip documentation)
would be nice. Until that happens, if it ever does, I can only recommend not to use ASUS boards
if you want to run Linux, if you need SuperIO chip support, and if the SuperIO chip is not
already supported by Linux.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
