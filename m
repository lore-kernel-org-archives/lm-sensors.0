From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 26 Oct 2010 15:02:32 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026150232.GA22948@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 26, 2010 at 10:53:16AM -0400, Jean Delvare wrote:
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
> 
At least that is what the Intel folks said. There can be one or more package 
level sensors. Those are in addition to the per-core sensors, not a replacement.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
