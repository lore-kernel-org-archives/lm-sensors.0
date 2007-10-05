From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Oct 2007 20:08:49 +0000
Subject: Re: [lm-sensors] ipmisensors almost working...
Message-Id: <20071005220849.440d16ef@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4705ED70.6080206@jordet.net>
In-Reply-To: <4705ED70.6080206@jordet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stian, Yani,

On Fri, 05 Oct 2007 18:40:22 +0200, Stian Jordet wrote:
> On fre, 2007-10-05 at 12:17 -0400, Yani Ioannou wrote:
> > There are in fact some sensors we may never be able to convert
> > completely in the kernel - they require complex transformations
> > involving logarithms. etc, that kernel code simply can't (and
> > shouldn't) calculate, so I think the real solution to this will have
> > to involve userspace support.

Yes, this is what we do for other drivers too. Arbitrary computation
formulae can be attached to all measurement channels in libsensors,
with support for logarithm and exponential. So it's really only a
matter of writing the right configuration file for your system.

> (...)
> I see. I would very much like to test new code :) I'm now running a
> lm-sensors svn snapshot from yesterday, after Jean Delvare said that
> there was an bug in the earlier lm-sensors causing sensor channel
> numbers to be shifted. Upgrading to latest svn snapshot made my voltages
> look better (but still not good), while all but one temperature got
> divided by 10 (!).

Ah, yes. The sysfs interface standard in Linux 2.6 states that
temperatures are exported in 10^-3 degrees C, while I seem to remember
that the ipmisensors driver exports the values in 10-^2 degrees C (as
was done in Linux 2.4). There was a hack in libsensors to deal with
this deviation from the standard, which I removed while fixing the
indexing issue. So ipmisensors will have to be fixed to stick to the
standard interface.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
