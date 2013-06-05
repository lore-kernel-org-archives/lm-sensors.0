From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Wed, 05 Jun 2013 11:43:07 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_1/2=5D_hwmon=3A_mc13783-adc=3A_Re?=
Message-Id: <1370432587.906000493@f233.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <1370430879.384973987@f91.mail.ru>
 <201306051336.49776.arnd@arndb.de>
In-Reply-To: <201306051336.49776.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> On Wednesday 05 June 2013, Alexander Shiyan wrote:
> > Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
> > symbols in the log (debug) will say a developer who does not know about
> > mc13892 compatibility with mc13783? I still believe that this should be reflected.
> 
> If the log messages use dev_printk, they will use the correct device name already,
> if not, that can be fixed.
> 
> I agree with Jean: we don't just rename things unless there is a significant
> benefit, which I don't see here. There is also the risk that we need to support
> a different chip named mc13xxx in the future that is different enough to require
> a new driver and then the naming is even more screwed up.

It is a pity that the revision and updating of the code of this driver died.
Well, lets drop thesepatches.
Thanks.

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
