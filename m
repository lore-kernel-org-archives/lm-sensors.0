From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Jan 2012 19:49:06 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <20120130204906.02d7aa11@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 30 Jan 2012 09:03:59 -0800, Guenter Roeck wrote:
> On Sat, 2012-01-28 at 15:04 -0500, Jean Delvare wrote:
> > On Sat, 28 Jan 2012 11:23:53 -0800, Guenter Roeck wrote:
> > > On Sat, Jan 28, 2012 at 01:37:56PM -0500, Jean Delvare wrote:
> > > > Add detection of the National Semiconductor (now Texas Instruments)
> > > > LM96080. It is functionally compatible with the LM80 but detection is
> > > > completely different.
> > > > ---
> > > > Frans, if you want to test this, a pre-patched version of
> > > > sensors-detect is available at:
> > > > http://khali.linux-fr.org/devel/misc/sensors-detect
> > >
> > > Looks good. Should we do the same for drivers/hwmon/lm80.c ?
> > 
> > I think so, yes. The LM96080 is different enough to have its own chip
> > name IMHO. The detection in the driver worked for Frans by chance
> > because the limit registers are all set to 0, but in the general case
> > it would fail.
>
> You or me or Frans ? Any takers ?

I'll do it, no problem. It's only a matter of getting to it, as I had a
busy day.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
