From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Aug 2007 14:26:17 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 snapshots
Message-Id: <20070819162617.4b2edf16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070818175926.6ed4411e@hyperion.delvare>
In-Reply-To: <20070818175926.6ed4411e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

On Sat, 18 Aug 2007 21:48:47 +0200, Axel Thimm wrote:
> On Sat, Aug 18, 2007 at 05:59:26PM +0200, Jean Delvare wrote:
> > I think that the time has come to generate lm-sensors-3.0.0 snapshots
> > for testers to download. This branch is quite usable now, even though
> > some tools are still not working (e.g. sensord).
> > 
> > Could you please add lm-sensors/branches/lm-sensors-3.0.0 to the
> > snapshot system? Then we can put the snapshots in
> > http://dl.lm-sensors.org/lm-sensors-3/snapshots/ or similar.
> 
> we have now
> 
> http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/{lm-sensors,i2c}-r<rev>-<date>.tar.bz2
> 
> If you'd like to have two snapshot series I'd suggest adding the
> version into the path above, e.g.
> 
> {lm-sensors,i2c}-<version>-r<rev>-<date>.tar.bz2
> 
> or something similar.

I would be fine with

http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-3-r<rev>-<date>.tar.bz2

For i2c, no need to change anything as there is no development branch.

> > While we're here, it'd be nice to have snapshots for the new i2c-tools
> > repository as well. We'll release the first i2c-tools package at the
> > same time as lm-sensors-3.0.0.

For i2c-tools, this really doesn't have anything to do with i2c, so I
would like to have a separate base directory:

http://dl.lm-sensors.org/i2c-tools/snapshots/i2c-tools-r<rev>-<date>.tar.bz2

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
