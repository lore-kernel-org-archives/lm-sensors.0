From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 26 Oct 2010 15:05:00 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <4CC6EE1C.30505@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 26 Oct 2010 16:52:15 +0200, Clemens Ladisch wrote:
> > Jean Delvare wrote:
> > > On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:
> > > > And on the newest CPUs, Intel has switched to one temperature sensor per
> > > > package.
> > > 
> > > Really? Starting with which CPU model?
> > 
> > Sandy Bridge (pkgtemp driver).
> 
> My understanding was that this was an additional per-package
> (meta-)sensor, and not a replacement for the per-core sensors.

Yes, you're right; I looked only at the coretemp documentation
which isn't quite up to date.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
