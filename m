From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Sat, 17 Mar 2007 14:23:10 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703171523.11555.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Samstag, 17. M?rz 2007 14:39 schrieb Jean Delvare:
>
> Patch accepted, will be in next -mm, and from there will go to 2.6.22.
> Thanks :)

I thank you!

>
> If you start working on the lm93 driver, make sure to search the
> mailing list archives first. I remember that the driver was already
> ported to Linux 2.6, but never reviewed. This was some times ago
> though, many things changed in the kernel meanwhile, so it's up to you
> whether you want to start from an old port or from scratch. 

I won't start from scratch, I have an at least partly working driver. Somebody 
made it apply to current kernels, but after a first quick glance at the code 
I'd say it needs quite a bit of work to make it acceptable for mainline.

> Beware, the 
> lm93 driver is a fat beast.

I already noticed :-)

Thanks,
Hans


