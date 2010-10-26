From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 14:53:16 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026165316.0d3c1b83@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 16:52:15 +0200, Clemens Ladisch wrote:
> Jean Delvare wrote:
> > On Tue, 26 Oct 2010 15:53:29 +0200, Clemens Ladisch wrote:
> > > And on the newest CPUs, Intel has switched to one temperature sensor per
> > > package.
> > 
> > Really? Starting with which CPU model?
> 
> Sandy Bridge (pkgtemp driver).

My understanding was that this was an additional per-package
(meta-)sensor, and not a replacement for the per-core sensors.

> > > I'll look into the datasheet to see if this situation (two northbridges
> > > per CPU) is documented and can be detected so that the driver can ignore
> > > these superfluous sensors.
> > 
> > If these sensors exist, I see no valid reason to ignore them.
> 
> It might be possible that these are just two ways to read the same
> sensor, i.e., that two sensors per CPU do not actually exist.

Ah, that would be different, and I'd agree with you then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
