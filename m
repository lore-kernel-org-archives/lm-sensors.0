From: Stephen Cormier <s.cormier@gmx.net>
Date: Mon, 10 Dec 2007 01:10:58 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <200712092110.58471.s.cormier@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071209000554.GF20441@stusta.de>
In-Reply-To: <20071209000554.GF20441@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On December 9, 2007 08:19:59 pm Mike Houston wrote:
> On Sun, 9 Dec 2007 23:42:15 +0100
>
> Jean Delvare <khali@linux-fr.org> wrote:
> > On Sun, 09 Dec 2007 16:12:25 -0500, Elvis Pranskevichus wrote:
> > > This indeed looks like a broken ACPI BIOS since the
> > > aforementioned commit touches only the PNP ACPI driver. I'm not
> > > sure how to work around this, though. Ideas?
> >
> > Complaining to Gigabyte seems to be the best approach.
>
> I just happen to have a Windows Vista installation on this box as
> well, and I just thought to check. Sorry, I wish I'd have thought of
> it sooner but I don't go there often. You folks might be interested
> to know that Windows appears to have the same silly problem with the
> i/o resources (from Device Manager):
>
> [000000290 - 000000294]  Motherboard resources
> [000000290 - 00000029F]  Motherboard resources
>
> I don't have anything that reads sensors in Windows though, so I
> couldn't tell you if it could access that it87 chip or not.
>
> So this pretty much confirms that it's a motherboard/bios issue.
>
> Mike Houston
>

You could always give speedfan a try it says it works on Vista and that is 
what I used on XP when I was testing the overclock on my ga-965p-ds3 ver 3.3 
and it showed whatever meaningful voltages that you can get from that chip, 
the only ones that make sense for my board are the vdimm, vcore, +3.3v and 
+5v in both OSs I never checked the i/o ranges when I was running it the 
latest F12 BIOS was installed.

http://www.almico.com/sfdownload.php

Stephen

-- 
GPG Public Key: http://users.eastlink.ca/~stephencormier/publickey.asc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
