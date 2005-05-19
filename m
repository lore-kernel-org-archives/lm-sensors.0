From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337: export ds1337_do_command
Message-Id: <20050510183651.GA10720@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique> <20050510175549.GC1530@suse.de>
In-Reply-To: <20050510175549.GC1530@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>, James Chapman <jchapman@katalix.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

On Tue, May 10, 2005 at 10:55:49AM -0700, Greg KH wrote:
> > --- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
> > +++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
> > @@ -380,5 +380,7 @@
> >  MODULE_DESCRIPTION("DS1337 RTC driver");
> >  MODULE_LICENSE("GPL");
> >  
> > +EXPORT_SYMBOL(ds1337_do_command);
> 
> EXPORT_SYMBOL_GPL() ok?

I do not realy care (and I think since unfamous SCO case people care
more about licenses than writing code). James is driver author, so I'll
do whatever he (and you) think is right. And while you bring up license
issue, comment on top of file says GPL version 2, but MODULE_LICENSE is
set to GPL.

Best regards,
	ladis
